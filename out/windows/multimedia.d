// Written in the D programming language.

module windows.multimedia;

public import windows.core;
public import windows.com : HRESULT, IPersistFile, IUnknown;
public import windows.coreaudio : HTASK;
public import windows.directshow : BITMAPINFOHEADER;
public import windows.displaydevices : POINT, RECT;
public import windows.gdi : BITMAPINFO, HDC, HICON, HPALETTE, PALETTEENTRY;
public import windows.hid : JOYREGHWVALUES;
public import windows.systemservices : BOOL, FARPROC, HANDLE, HINSTANCE, LPTIMECALLBACK,
                                       LRESULT, PSTR, PWSTR;
public import windows.windowsandmessaging : HWND, LPARAM, OPENFILENAMEA, OPENFILENAMEW,
                                            WPARAM;

extern(Windows) @nogc nothrow:


// Callbacks

alias DRVCALLBACK = void function(ptrdiff_t hdrvr, uint uMsg, size_t dwUser, size_t dw1, size_t dw2);
alias LPDRVCALLBACK = void function();
alias PDRVCALLBACK = void function();
///Processes driver messages for the installable driver. <b>DriverProc</b> is a driver-supplied function.
///Params:
///    Arg1 = Identifier of the installable driver.
///    Arg2 = Handle of the installable driver instance. Each instance of the installable driver has a unique handle.
///    Arg3 = Driver message value. It can be a custom value or one of these standard values: <table> <tr> <th>Value</th>
///           <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DRV_CLOSE"></a><a id="drv_close"></a><dl>
///           <dt><b>DRV_CLOSE</b></dt> </dl> </td> <td width="60%"> Notifies the driver that it should decrement its usage
///           count and unload the driver if the count is zero. </td> </tr> <tr> <td width="40%"><a id="DRV_CONFIGURE"></a><a
///           id="drv_configure"></a><dl> <dt><b>DRV_CONFIGURE</b></dt> </dl> </td> <td width="60%"> Notifies the driver that
///           it should display a configuration dialog box. This message is sent only if the driver returns a nonzero value
///           when processing the DRV_QUERYCONFIGURE message. </td> </tr> <tr> <td width="40%"><a id="DRV_DISABLE"></a><a
///           id="drv_disable"></a><dl> <dt><b>DRV_DISABLE</b></dt> </dl> </td> <td width="60%"> Notifies the driver that its
///           allocated memory is about to be freed. </td> </tr> <tr> <td width="40%"><a id="DRV_ENABLE"></a><a
///           id="drv_enable"></a><dl> <dt><b>DRV_ENABLE</b></dt> </dl> </td> <td width="60%"> Notifies the driver that it has
///           been loaded or reloaded or that Windows has been enabled. </td> </tr> <tr> <td width="40%"><a
///           id="DRV_FREE"></a><a id="drv_free"></a><dl> <dt><b>DRV_FREE</b></dt> </dl> </td> <td width="60%"> Notifies the
///           driver that it will be discarded. </td> </tr> <tr> <td width="40%"><a id="DRV_INSTALL"></a><a
///           id="drv_install"></a><dl> <dt><b>DRV_INSTALL</b></dt> </dl> </td> <td width="60%"> Notifies the driver that it
///           has been successfully installed. </td> </tr> <tr> <td width="40%"><a id="DRV_LOAD"></a><a id="drv_load"></a><dl>
///           <dt><b>DRV_LOAD</b></dt> </dl> </td> <td width="60%"> Notifies the driver that it has been successfully loaded.
///           </td> </tr> <tr> <td width="40%"><a id="DRV_OPEN"></a><a id="drv_open"></a><dl> <dt><b>DRV_OPEN</b></dt> </dl>
///           </td> <td width="60%"> Notifies the driver that it is about to be opened. </td> </tr> <tr> <td width="40%"><a
///           id="DRV_POWER"></a><a id="drv_power"></a><dl> <dt><b>DRV_POWER</b></dt> </dl> </td> <td width="60%"> Notifies the
///           driver that the device's power source is about to be turned on or off. </td> </tr> <tr> <td width="40%"><a
///           id="DRV_QUERYCONFIGURE"></a><a id="drv_queryconfigure"></a><dl> <dt><b>DRV_QUERYCONFIGURE</b></dt> </dl> </td>
///           <td width="60%"> Directs the driver to specify whether it supports the DRV_CONFIGURE message. </td> </tr> <tr>
///           <td width="40%"><a id="DRV_REMOVE"></a><a id="drv_remove"></a><dl> <dt><b>DRV_REMOVE</b></dt> </dl> </td> <td
///           width="60%"> Notifies the driver that it is about to be removed from the system. </td> </tr> </table>
///    Arg4 = 32-bit message-specific value.
///    Arg5 = 32-bit message-specific value.
///Returns:
///    Returns nonzero if successful or zero otherwise.
///    
alias DRIVERPROC = LRESULT function(size_t param0, ptrdiff_t param1, uint param2, LPARAM param3, LPARAM param4);
alias DRIVERMSGPROC = uint function(uint param0, uint param1, size_t param2, size_t param3, size_t param4);
///The <b>MMIOProc</b> function is a custom input/output (I/O) procedure installed by the mmioInstallIOProc function.
///<b>MMIOProc</b> is a placeholder for the application-defined function name. The address of this function can be
///specified in the callback-address parameter of <b>mmioInstallIOProc</b>.
///Params:
///    lpmmioinfo = Points to an MMIOINFO structure containing information about the open file. The I/O procedure must maintain the
///                 <b>lDiskOffset</b> member in this structure to indicate the file offset to the next read or write location. The
///                 I/O procedure can use the <b>adwInfo</b>[] member to store state information. The I/O procedure should not modify
///                 any other members of the MMIOINFO structure.
///    uMsg = Specifies a message indicating the requested I/O operation. Messages that can be received include MMIOM_OPEN,
///           MMIOM_CLOSE, MMIOM_READ, MMIOM_SEEK, MMIOM_WRITE, and MMIOM_WRITEFLUSH.
///    lParam1 = Specifies an application-defined parameter for the message.
///    lParam2 = Specifies an application-defined parameter for the message.
///Returns:
///    The return value depends on the message specified by <i>uMsg</i>. If the I/O procedure does not recognize a
///    message, it should return zero.
///    
alias MMIOPROC = LRESULT function(PSTR lpmmioinfo, uint uMsg, LPARAM lParam1, LPARAM lParam2);
alias LPMMIOPROC = LRESULT function();
alias WAVECALLBACK = void function();
alias LPWAVECALLBACK = void function();
alias MIDICALLBACK = void function();
alias LPMIDICALLBACK = void function();
///The <b>acmDriverEnumCallback</b> function specifies a callback function used with the acmDriverEnum function. The
///<b>acmDriverEnumCallback</b> name is a placeholder for an application-defined function name.
///Params:
///    hadid = Handle to an ACM driver identifier.
///    dwInstance = Application-defined value specified in acmDriverEnum.
///    fdwSupport = Driver-support flags specific to the driver specified by [ACMDRIVERDETAILS](./nf-msacm-acmdriverdetails.md)
///                 structure. This parameter can be a combination of the following values. <table> <tr> <th>Value </th> <th>Meaning
///                 </th> </tr> <tr> <td>ACMDRIVERDETAILS_SUPPORTF_ASYNC</td> <td>Driver supports asynchronous conversions.</td>
///                 </tr> <tr> <td>ACMDRIVERDETAILS_SUPPORTF_CODEC</td> <td>Driver supports conversion between two different format
///                 tags. For example, if a driver supports compression from WAVE_FORMAT_PCM to WAVE_FORMAT_ADPCM, this flag is
///                 set.</td> </tr> <tr> <td>ACMDRIVERDETAILS_SUPPORTF_CONVERTER</td> <td>Driver supports conversion between two
///                 different formats of the same format tag. For example, if a driver supports resampling of WAVE_FORMAT_PCM, this
///                 flag is set.</td> </tr> <tr> <td>ACMDRIVERDETAILS_SUPPORTF_DISABLED</td> <td>Driver has been disabled. An
///                 application must specify the ACM_DRIVERENUMF_DISABLED flag with acmDriverEnum to include disabled drivers in the
///                 enumeration.</td> </tr> <tr> <td>ACMDRIVERDETAILS_SUPPORTF_FILTER</td> <td>Driver supports a filter (modification
///                 of the data without changing any of the format attributes). For example, if a driver supports volume or echo
///                 operations on WAVE_FORMAT_PCM, this flag is set.</td> </tr> </table>
///Returns:
///    The callback function must return <b>TRUE</b> to continue enumeration or <b>FALSE</b> to stop enumeration.
///    
alias ACMDRIVERENUMCB = BOOL function(HACMDRIVERID__* hadid, size_t dwInstance, uint fdwSupport);
///The <b>acmDriverProc</b> function specifies a callback function used with the ACM driver. The <b>acmDriverProc</b>
///name is a placeholder for an application-defined function name. The actual name must be exported by including it in
///the module-definition file of the executable or DLL file.
///Params:
///    Arg1 = Identifier of the installable ACM driver.
///    Arg2 = Handle to the installable ACM driver. This parameter is a unique handle the ACM assigns to the driver.
///    Arg3 = ACM driver message.
///    Arg4 = Message parameter.
///    Arg5 = Message parameter.
///Returns:
///    Returns zero if successful or an error otherwise.
///    
alias ACMDRIVERPROC = LRESULT function(size_t param0, HACMDRIVERID__* param1, uint param2, LPARAM param3, 
                                       LPARAM param4);
alias LPACMDRIVERPROC = LRESULT function();
///The <b>acmFormatTagEnumCallback</b> function specifies a callback function used with the acmFormatTagEnum function.
///The <b>acmFormatTagEnumCallback</b> name is a placeholder for an application-defined function name.
///Params:
///    hadid = Handle to the ACM driver identifier.
///    paftd = Pointer to an [ACMFORMATTAGDETAILS](./nf-msacm-acmformattagdetails.md) structure that contains the enumerated
///            format tag details.
///    dwInstance = Application-defined value specified in the acmFormatTagEnum function.
///    fdwSupport = Driver-support flags specific to the format tag. These flags are identical to the
///                 [ACMDRIVERDETAILS](./nf-msacm-acmdriverdetails.md) structure. This parameter can be a combination of the
///                 following values and indicates which operations the driver supports with the format tag. <table> <tr> <th>Value
///                 </th> <th>Meaning </th> </tr> <tr> <td>ACMDRIVERDETAILS_SUPPORTF_ASYNC</td> <td>Driver supports asynchronous
///                 conversions with the specified filter tag.</td> </tr> <tr> <td>ACMDRIVERDETAILS_SUPPORTF_CODEC</td> <td>Driver
///                 supports conversion between two different format tags where one of the tags is the specified format tag. For
///                 example, if a driver supports compression from WAVE_FORMAT_PCM to WAVE_FORMAT_ADPCM, this flag is set.</td> </tr>
///                 <tr> <td>ACMDRIVERDETAILS_SUPPORTF_CONVERTER</td> <td>Driver supports conversion between two different formats of
///                 the specified format tag. For example, if a driver supports resampling of WAVE_FORMAT_PCM, this flag is set.</td>
///                 </tr> <tr> <td>ACMDRIVERDETAILS_SUPPORTF_FILTER</td> <td>Driver supports a filter (modification of the data
///                 without changing any of the format attributes). For example, if a driver supports volume or echo operations on
///                 the specified format tag, this flag is set.</td> </tr> <tr> <td>ACMDRIVERDETAILS_SUPPORTF_HARDWARE</td>
///                 <td>Driver supports hardware input, output, or both of the specified format tag through a waveform-audio device.
///                 An application should use acmMetrics with the ACM_METRIC_HARDWARE_WAVE_INPUT and ACM_METRIC_HARDWARE_WAVE_OUTPUT
///                 metric indexes to get the waveform-audio device identifiers associated with the supporting ACM driver.</td> </tr>
///                 </table>
///Returns:
///    The callback function must return <b>TRUE</b> to continue enumeration or <b>FALSE</b> to stop enumeration.
///    
alias ACMFORMATTAGENUMCBA = BOOL function(HACMDRIVERID__* hadid, tACMFORMATTAGDETAILSA* paftd, size_t dwInstance, 
                                          uint fdwSupport);
///The <b>acmFormatTagEnumCallback</b> function specifies a callback function used with the acmFormatTagEnum function.
///The <b>acmFormatTagEnumCallback</b> name is a placeholder for an application-defined function name.
///Params:
///    hadid = Handle to the ACM driver identifier.
///    paftd = Pointer to an [ACMFORMATTAGDETAILS](./nf-msacm-acmformattagdetails.md) structure that contains the enumerated
///            format tag details.
///    dwInstance = Application-defined value specified in the acmFormatTagEnum function.
///    fdwSupport = Driver-support flags specific to the format tag. These flags are identical to the
///                 [ACMDRIVERDETAILS](./nf-msacm-acmdriverdetails.md) structure. This parameter can be a combination of the
///                 following values and indicates which operations the driver supports with the format tag. <table> <tr> <th>Value
///                 </th> <th>Meaning </th> </tr> <tr> <td>ACMDRIVERDETAILS_SUPPORTF_ASYNC</td> <td>Driver supports asynchronous
///                 conversions with the specified filter tag.</td> </tr> <tr> <td>ACMDRIVERDETAILS_SUPPORTF_CODEC</td> <td>Driver
///                 supports conversion between two different format tags where one of the tags is the specified format tag. For
///                 example, if a driver supports compression from WAVE_FORMAT_PCM to WAVE_FORMAT_ADPCM, this flag is set.</td> </tr>
///                 <tr> <td>ACMDRIVERDETAILS_SUPPORTF_CONVERTER</td> <td>Driver supports conversion between two different formats of
///                 the specified format tag. For example, if a driver supports resampling of WAVE_FORMAT_PCM, this flag is set.</td>
///                 </tr> <tr> <td>ACMDRIVERDETAILS_SUPPORTF_FILTER</td> <td>Driver supports a filter (modification of the data
///                 without changing any of the format attributes). For example, if a driver supports volume or echo operations on
///                 the specified format tag, this flag is set.</td> </tr> <tr> <td>ACMDRIVERDETAILS_SUPPORTF_HARDWARE</td>
///                 <td>Driver supports hardware input, output, or both of the specified format tag through a waveform-audio device.
///                 An application should use acmMetrics with the ACM_METRIC_HARDWARE_WAVE_INPUT and ACM_METRIC_HARDWARE_WAVE_OUTPUT
///                 metric indexes to get the waveform-audio device identifiers associated with the supporting ACM driver.</td> </tr>
///                 </table>
///Returns:
///    The callback function must return <b>TRUE</b> to continue enumeration or <b>FALSE</b> to stop enumeration.
///    
alias ACMFORMATTAGENUMCBW = BOOL function(HACMDRIVERID__* hadid, tACMFORMATTAGDETAILSW* paftd, size_t dwInstance, 
                                          uint fdwSupport);
///The <b>acmFormatEnumCallback</b> function specifies a callback function used with the acmFormatEnum function. The
///<b>acmFormatEnumCallback</b> name is a placeholder for the application-defined function name.
///Params:
///    hadid = Handle to the ACM driver identifier.
///    pafd = Pointer to an [ACMFORMATDETAILS](./nf-msacm-acmformatdetails.md) structure that contains the enumerated format
///           details for a format tag.
///    dwInstance = Application-defined value specified in the acmFormatEnum function.
///    fdwSupport = Driver support flags specific to the driver identified by [ACMDRIVERDETAILS](./nf-msacm-acmdriverdetails.md)
///                 structure, but they are specific to the format that is being enumerated. This parameter can be a combination of
///                 the following values and indicates which operations the driver supports for the format tag. <table> <tr>
///                 <th>Value </th> <th>Meaning </th> </tr> <tr> <td>ACMDRIVERDETAILS_SUPPORTF_ASYNC</td> <td>Driver supports
///                 asynchronous conversions with the specified filter tag.</td> </tr> <tr> <td>ACMDRIVERDETAILS_SUPPORTF_CODEC</td>
///                 <td>Driver supports conversion between two different format tags for the specified format. For example, if a
///                 driver supports compression from WAVE_FORMAT_PCM to WAVE_FORMAT_ADPCM with the specified format, this flag is
///                 set.</td> </tr> <tr> <td>ACMDRIVERDETAILS_SUPPORTF_CONVERTER</td> <td>Driver supports conversion between two
///                 different formats of the same format tag while using the specified format. For example, if a driver supports
///                 resampling of WAVE_FORMAT_PCM to the specified format, this flag is set.</td> </tr> <tr>
///                 <td>ACMDRIVERDETAILS_SUPPORTF_FILTER</td> <td>Driver supports a filter (modification of the data without changing
///                 any of the format attributes) with the specified format. For example, if a driver supports volume or echo
///                 operations on WAVE_FORMAT_PCM, this flag is set.</td> </tr> <tr> <td>ACMDRIVERDETAILS_SUPPORTF_HARDWARE</td>
///                 <td>Driver supports hardware input, output, or both of the specified format tags through a waveform-audio device.
///                 An application should use the acmMetrics function with the ACM_METRIC_HARDWARE_WAVE_INPUT and
///                 ACM_METRIC_HARDWARE_WAVE_OUTPUT metric indexes to get the waveform-audio device identifiers associated with the
///                 supporting ACM driver.</td> </tr> </table>
///Returns:
///    The callback function must return <b>TRUE</b> to continue enumeration or <b>FALSE</b> to stop enumeration.
///    
alias ACMFORMATENUMCBA = BOOL function(HACMDRIVERID__* hadid, tACMFORMATDETAILSA* pafd, size_t dwInstance, 
                                       uint fdwSupport);
///The <b>acmFormatEnumCallback</b> function specifies a callback function used with the acmFormatEnum function. The
///<b>acmFormatEnumCallback</b> name is a placeholder for the application-defined function name.
///Params:
///    hadid = Handle to the ACM driver identifier.
///    pafd = Pointer to an [ACMFORMATDETAILS](./nf-msacm-acmformatdetails.md) structure that contains the enumerated format
///           details for a format tag.
///    dwInstance = Application-defined value specified in the acmFormatEnum function.
///    fdwSupport = Driver support flags specific to the driver identified by [ACMDRIVERDETAILS](./nf-msacm-acmdriverdetails.md)
///                 structure, but they are specific to the format that is being enumerated. This parameter can be a combination of
///                 the following values and indicates which operations the driver supports for the format tag. <table> <tr>
///                 <th>Value </th> <th>Meaning </th> </tr> <tr> <td>ACMDRIVERDETAILS_SUPPORTF_ASYNC</td> <td>Driver supports
///                 asynchronous conversions with the specified filter tag.</td> </tr> <tr> <td>ACMDRIVERDETAILS_SUPPORTF_CODEC</td>
///                 <td>Driver supports conversion between two different format tags for the specified format. For example, if a
///                 driver supports compression from WAVE_FORMAT_PCM to WAVE_FORMAT_ADPCM with the specified format, this flag is
///                 set.</td> </tr> <tr> <td>ACMDRIVERDETAILS_SUPPORTF_CONVERTER</td> <td>Driver supports conversion between two
///                 different formats of the same format tag while using the specified format. For example, if a driver supports
///                 resampling of WAVE_FORMAT_PCM to the specified format, this flag is set.</td> </tr> <tr>
///                 <td>ACMDRIVERDETAILS_SUPPORTF_FILTER</td> <td>Driver supports a filter (modification of the data without changing
///                 any of the format attributes) with the specified format. For example, if a driver supports volume or echo
///                 operations on WAVE_FORMAT_PCM, this flag is set.</td> </tr> <tr> <td>ACMDRIVERDETAILS_SUPPORTF_HARDWARE</td>
///                 <td>Driver supports hardware input, output, or both of the specified format tags through a waveform-audio device.
///                 An application should use the acmMetrics function with the ACM_METRIC_HARDWARE_WAVE_INPUT and
///                 ACM_METRIC_HARDWARE_WAVE_OUTPUT metric indexes to get the waveform-audio device identifiers associated with the
///                 supporting ACM driver.</td> </tr> </table>
///Returns:
///    The callback function must return <b>TRUE</b> to continue enumeration or <b>FALSE</b> to stop enumeration.
///    
alias ACMFORMATENUMCBW = BOOL function(HACMDRIVERID__* hadid, tACMFORMATDETAILSW* pafd, size_t dwInstance, 
                                       uint fdwSupport);
alias ACMFORMATCHOOSEHOOKPROCA = uint function(HWND hwnd, uint uMsg, WPARAM wParam, LPARAM lParam);
alias ACMFORMATCHOOSEHOOKPROCW = uint function(HWND hwnd, uint uMsg, WPARAM wParam, LPARAM lParam);
///The <b>acmFilterTagEnumCallback</b> function specifies a callback function used with the acmFilterTagEnum function.
///The <b>acmFilterTagEnumCallback</b> function name is a placeholder for an application-defined function name.
///Params:
///    hadid = Handle to the ACM driver identifier.
///    paftd = Pointer to an [ACMFILTERTAGDETAILS](./nf-msacm-acmfiltertagdetails.md) structure that contains the enumerated
///            filter tag details.
///    dwInstance = Application-defined value specified in acmFilterTagEnum.
///    fdwSupport = Driver-support flags specific to the driver identifier [ACMDRIVERDETAILS](./nf-msacm-acmdriverdetails.md)
///                 structure. This parameter can be a combination of the following values and identifies which operations the driver
///                 supports with the filter tag. <table> <tr> <th>Value </th> <th>Meaning </th> </tr> <tr>
///                 <td><b>ACMDRIVERDETAILS_SUPPORTF_ASYNC</b></td> <td>Driver supports asynchronous conversions with the specified
///                 filter tag.</td> </tr> <tr> <td><b>ACMDRIVERDETAILS_SUPPORTF_CODEC</b></td> <td>Driver supports conversion
///                 between two different format tags while using the specified filter tag. For example, if a driver supports
///                 compression from <b>WAVE_FORMAT_PCM</b> to <b>WAVE_FORMAT_ADPCM</b> with the specified filter tag, this flag is
///                 set.</td> </tr> <tr> <td><b>ACMDRIVERDETAILS_SUPPORTF_CONVERTER</b></td> <td>Driver supports conversion between
///                 two different formats of the same format tag while using the specified filter tag. For example, if a driver
///                 supports resampling of <b>WAVE_FORMAT_PCM</b> with the specified filter tag, this flag is set.</td> </tr> <tr>
///                 <td><b>ACMDRIVERDETAILS_SUPPORTF_FILTER</b></td> <td>Driver supports a filter (modification of the data without
///                 changing any of the format attributes). For example, if a driver supports volume or echo operations on
///                 <b>WAVE_FORMAT_PCM</b>, this flag is set.</td> </tr> <tr> <td><b>ACMDRIVERDETAILS_SUPPORTF_HARDWARE</b></td>
///                 <td>Driver supports hardware input, output, or both with the specified filter tag through a waveform-audio
///                 device. An application should use the acmMetrics function with the <b>ACM_METRIC_HARDWARE_WAVE_INPUT</b> and
///                 <b>ACM_METRIC_HARDWARE_WAVE_OUTPUT</b> metric indices to get the waveform-audio device identifiers associated
///                 with the supporting ACM driver.</td> </tr> </table>
///Returns:
///    The callback function must return <b>TRUE</b> to continue enumeration or <b>FALSE</b> to stop enumeration.
///    
alias ACMFILTERTAGENUMCBA = BOOL function(HACMDRIVERID__* hadid, tACMFILTERTAGDETAILSA* paftd, size_t dwInstance, 
                                          uint fdwSupport);
///The <b>acmFilterTagEnumCallback</b> function specifies a callback function used with the acmFilterTagEnum function.
///The <b>acmFilterTagEnumCallback</b> function name is a placeholder for an application-defined function name.
///Params:
///    hadid = Handle to the ACM driver identifier.
///    paftd = Pointer to an [ACMFILTERTAGDETAILS](./nf-msacm-acmfiltertagdetails.md) structure that contains the enumerated
///            filter tag details.
///    dwInstance = Application-defined value specified in acmFilterTagEnum.
///    fdwSupport = Driver-support flags specific to the driver identifier [ACMDRIVERDETAILS](./nf-msacm-acmdriverdetails.md)
///                 structure. This parameter can be a combination of the following values and identifies which operations the driver
///                 supports with the filter tag. <table> <tr> <th>Value </th> <th>Meaning </th> </tr> <tr>
///                 <td><b>ACMDRIVERDETAILS_SUPPORTF_ASYNC</b></td> <td>Driver supports asynchronous conversions with the specified
///                 filter tag.</td> </tr> <tr> <td><b>ACMDRIVERDETAILS_SUPPORTF_CODEC</b></td> <td>Driver supports conversion
///                 between two different format tags while using the specified filter tag. For example, if a driver supports
///                 compression from <b>WAVE_FORMAT_PCM</b> to <b>WAVE_FORMAT_ADPCM</b> with the specified filter tag, this flag is
///                 set.</td> </tr> <tr> <td><b>ACMDRIVERDETAILS_SUPPORTF_CONVERTER</b></td> <td>Driver supports conversion between
///                 two different formats of the same format tag while using the specified filter tag. For example, if a driver
///                 supports resampling of <b>WAVE_FORMAT_PCM</b> with the specified filter tag, this flag is set.</td> </tr> <tr>
///                 <td><b>ACMDRIVERDETAILS_SUPPORTF_FILTER</b></td> <td>Driver supports a filter (modification of the data without
///                 changing any of the format attributes). For example, if a driver supports volume or echo operations on
///                 <b>WAVE_FORMAT_PCM</b>, this flag is set.</td> </tr> <tr> <td><b>ACMDRIVERDETAILS_SUPPORTF_HARDWARE</b></td>
///                 <td>Driver supports hardware input, output, or both with the specified filter tag through a waveform-audio
///                 device. An application should use the acmMetrics function with the <b>ACM_METRIC_HARDWARE_WAVE_INPUT</b> and
///                 <b>ACM_METRIC_HARDWARE_WAVE_OUTPUT</b> metric indices to get the waveform-audio device identifiers associated
///                 with the supporting ACM driver.</td> </tr> </table>
///Returns:
///    The callback function must return <b>TRUE</b> to continue enumeration or <b>FALSE</b> to stop enumeration.
///    
alias ACMFILTERTAGENUMCBW = BOOL function(HACMDRIVERID__* hadid, tACMFILTERTAGDETAILSW* paftd, size_t dwInstance, 
                                          uint fdwSupport);
///The <b>acmFilterEnumCallback</b> function specifies a callback function used with the acmFilterEnum function. The
///<b>acmFilterEnumCallback</b> name is a placeholder for an application-defined function name.
///Params:
///    hadid = Handle to the ACM driver identifier.
///    pafd = Pointer to an [ACMFILTERDETAILS](./nf-msacm-acmfilterdetails.md) structure that contains the enumerated filter
///           details for a filter tag.
///    dwInstance = Application-defined value specified in acmFilterEnum.
///    fdwSupport = Driver-support flags specific to the driver identified by [ACMDRIVERDETAILS](./nf-msacm-acmdriverdetails.md)
///                 structure, but they are specific to the filter that is being enumerated. This parameter can be a combination of
///                 the following values and identifies which operations the driver supports for the filter tag. <table> <tr>
///                 <th>Value </th> <th>Meaning </th> </tr> <tr> <td>ACMDRIVERDETAILS_SUPPORTF_ASYNC</td> <td>Driver supports
///                 asynchronous conversions with the specified filter tag.</td> </tr> <tr> <td>ACMDRIVERDETAILS_SUPPORTF_CODEC</td>
///                 <td>Driver supports conversion between two different format tags while using the specified filter. For example,
///                 if a driver supports compression from WAVE_FORMAT_PCM to WAVE_FORMAT_ADPCM with the specified filter, this flag
///                 is set.</td> </tr> <tr> <td>ACMDRIVERDETAILS_SUPPORTF_CONVERTER</td> <td>Driver supports conversion between two
///                 different formats of the same format tag while using the specified filter. For example, if a driver supports
///                 resampling of WAVE_FORMAT_PCM with the specified filter, this flag is set.</td> </tr> <tr>
///                 <td>ACMDRIVERDETAILS_SUPPORTF_FILTER</td> <td>Driver supports a filter (modification of the data without changing
///                 any of the format attributes). For example, if a driver supports volume or echo operations on WAVE_FORMAT_PCM,
///                 this flag is set.</td> </tr> <tr> <td>ACMDRIVERDETAILS_SUPPORTF_HARDWARE</td> <td>Driver supports hardware input,
///                 output, or both with the specified filter through a waveform-audio device. An application should use the
///                 acmMetrics function with the ACM_METRIC_HARDWARE_WAVE_INPUT and ACM_METRIC_HARDWARE_WAVE_OUTPUT metric indices to
///                 get the waveform-audio device identifiers associated with the supporting ACM driver.</td> </tr> </table>
///Returns:
///    The callback function must return <b>TRUE</b> to continue enumeration or <b>FALSE</b> to stop enumeration.
///    
alias ACMFILTERENUMCBA = BOOL function(HACMDRIVERID__* hadid, tACMFILTERDETAILSA* pafd, size_t dwInstance, 
                                       uint fdwSupport);
///The <b>acmFilterEnumCallback</b> function specifies a callback function used with the acmFilterEnum function. The
///<b>acmFilterEnumCallback</b> name is a placeholder for an application-defined function name.
///Params:
///    hadid = Handle to the ACM driver identifier.
///    pafd = Pointer to an [ACMFILTERDETAILS](./nf-msacm-acmfilterdetails.md) structure that contains the enumerated filter
///           details for a filter tag.
///    dwInstance = Application-defined value specified in acmFilterEnum.
///    fdwSupport = Driver-support flags specific to the driver identified by [ACMDRIVERDETAILS](./nf-msacm-acmdriverdetails.md)
///                 structure, but they are specific to the filter that is being enumerated. This parameter can be a combination of
///                 the following values and identifies which operations the driver supports for the filter tag. <table> <tr>
///                 <th>Value </th> <th>Meaning </th> </tr> <tr> <td>ACMDRIVERDETAILS_SUPPORTF_ASYNC</td> <td>Driver supports
///                 asynchronous conversions with the specified filter tag.</td> </tr> <tr> <td>ACMDRIVERDETAILS_SUPPORTF_CODEC</td>
///                 <td>Driver supports conversion between two different format tags while using the specified filter. For example,
///                 if a driver supports compression from WAVE_FORMAT_PCM to WAVE_FORMAT_ADPCM with the specified filter, this flag
///                 is set.</td> </tr> <tr> <td>ACMDRIVERDETAILS_SUPPORTF_CONVERTER</td> <td>Driver supports conversion between two
///                 different formats of the same format tag while using the specified filter. For example, if a driver supports
///                 resampling of WAVE_FORMAT_PCM with the specified filter, this flag is set.</td> </tr> <tr>
///                 <td>ACMDRIVERDETAILS_SUPPORTF_FILTER</td> <td>Driver supports a filter (modification of the data without changing
///                 any of the format attributes). For example, if a driver supports volume or echo operations on WAVE_FORMAT_PCM,
///                 this flag is set.</td> </tr> <tr> <td>ACMDRIVERDETAILS_SUPPORTF_HARDWARE</td> <td>Driver supports hardware input,
///                 output, or both with the specified filter through a waveform-audio device. An application should use the
///                 acmMetrics function with the ACM_METRIC_HARDWARE_WAVE_INPUT and ACM_METRIC_HARDWARE_WAVE_OUTPUT metric indices to
///                 get the waveform-audio device identifiers associated with the supporting ACM driver.</td> </tr> </table>
///Returns:
///    The callback function must return <b>TRUE</b> to continue enumeration or <b>FALSE</b> to stop enumeration.
///    
alias ACMFILTERENUMCBW = BOOL function(HACMDRIVERID__* hadid, tACMFILTERDETAILSW* pafd, size_t dwInstance, 
                                       uint fdwSupport);
alias ACMFILTERCHOOSEHOOKPROCA = uint function(HWND hwnd, uint uMsg, WPARAM wParam, LPARAM lParam);
alias ACMFILTERCHOOSEHOOKPROCW = uint function(HWND hwnd, uint uMsg, WPARAM wParam, LPARAM lParam);
alias AVISAVECALLBACK = BOOL function(int param0);
///The <b>capYieldCallback</b> function is the yield callback function used with video capture. The name
///<b>capYieldCallback</b> is a placeholder for the application-supplied function name. To set the callback, send the
///WM_CAP_SET_CALLBACK_YIELD message to the capture window or call the capSetCallbackOnYield macro.
///Params:
///    hWnd = Handle to the capture window associated with the callback function.
alias CAPYIELDCALLBACK = LRESULT function(HWND hWnd);
///The <b>capStatusCallback</b> function is the status callback function used with video capture. The name
///<b>capStatusCallback</b> is a placeholder for the application-supplied function name. To set the callback, send the
///WM_CAP_SET_CALLBACK_STATUS message to the capture window or call the capSetCallbackOnStatus macro.
///Params:
///    hWnd = Handle to the capture window associated with the callback function.
///    nID = Message identification number.
///    lpsz = Pointer to a textual description of the returned status.
alias CAPSTATUSCALLBACKW = LRESULT function(HWND hWnd, int nID, const(PWSTR) lpsz);
///The <b>capErrorCallback</b> function is the error callback function used with video capture. The name
///<b>capErrorCallback</b> is a placeholder for the application-supplied function name. To set the callback, send the
///WM_CAP_SET_CALLBACK_ERROR message to the capture window or call the capSetCallbackOnError macro.
///Params:
///    hWnd = Handle to the capture window associated with the callback function.
///    nID = Error identification number.
///    lpsz = Pointer to a textual description of the returned error.
alias CAPERRORCALLBACKW = LRESULT function(HWND hWnd, int nID, const(PWSTR) lpsz);
///The <b>capStatusCallback</b> function is the status callback function used with video capture. The name
///<b>capStatusCallback</b> is a placeholder for the application-supplied function name. To set the callback, send the
///WM_CAP_SET_CALLBACK_STATUS message to the capture window or call the capSetCallbackOnStatus macro.
///Params:
///    hWnd = Handle to the capture window associated with the callback function.
///    nID = Message identification number.
///    lpsz = Pointer to a textual description of the returned status.
alias CAPSTATUSCALLBACKA = LRESULT function(HWND hWnd, int nID, const(PSTR) lpsz);
///The <b>capErrorCallback</b> function is the error callback function used with video capture. The name
///<b>capErrorCallback</b> is a placeholder for the application-supplied function name. To set the callback, send the
///WM_CAP_SET_CALLBACK_ERROR message to the capture window or call the capSetCallbackOnError macro.
///Params:
///    hWnd = Handle to the capture window associated with the callback function.
///    nID = Error identification number.
///    lpsz = Pointer to a textual description of the returned error.
alias CAPERRORCALLBACKA = LRESULT function(HWND hWnd, int nID, const(PSTR) lpsz);
///The <b>capVideoStreamCallback</b> function is the callback function used with streaming capture to optionally process
///a frame of captured video. The name <b>capVideoStreamCallback</b> is a placeholder for the application-supplied
///function name. To set this callback for streaming capture, send the WM_CAP_SET_CALLBACK_VIDEOSTREAM message to the
///capture window or call the capSetCallbackOnVideoStream macro. To set this callback for preview frame capture, send
///the WM_CAP_SET_CALLBACK_FRAME message to the capture window or call the capSetCallbackOnFrame macro.
///Params:
///    hWnd = Handle to the capture window associated with the callback function.
///    lpVHdr = Pointer to a VIDEOHDR structure containing information about the captured frame.
alias CAPVIDEOCALLBACK = LRESULT function(HWND hWnd, VIDEOHDR* lpVHdr);
///The <b>capWaveStreamCallback</b> function is the callback function used with streaming capture to optionally process
///buffers of audio data. The name <b>capWaveStreamCallback</b> is a placeholder for the application-supplied function
///name. To set the callback, send the WM_CAP_SET_CALLBACK_WAVESTREAM message to the capture window or call the
///capSetCallbackOnWaveStream macro.
///Params:
///    hWnd = Handle to the capture window associated with the callback function.
///    lpWHdr = Pointer to a WAVEHDR structure containing information about the captured audio data.
alias CAPWAVECALLBACK = LRESULT function(HWND hWnd, WAVEHDR* lpWHdr);
///The <b>capControlCallback</b> function is the callback function used for precision control to begin and end streaming
///capture. The name <b>capControlCallback</b> is a placeholder for the application-supplied function name. To set the
///callback, send the WM_CAP_SET_CALLBACK_CAPCONTROL message to the capture window or call the
///capSetCallbackOnCapControl macro.
///Params:
///    hWnd = Handle to the capture window associated with the callback function.
///    nState = Current state of the capture operation. The CONTROLCALLBACK_PREROLL value is sent initially to enable prerolling
///             of the video sources and to return control to the capture application at the exact moment recording is to begin.
///             The CONTROLCALLBACK_CAPTURING value is sent once per captured frame to indicate that streaming capture is in
///             progress and to enable the application to end capture.
///Returns:
///    When <i>nState</i> is set to CONTROLCALLBACK_PREROLL, this callback function must return <b>TRUE</b> to start
///    capture or <b>FALSE</b> to abort it. When <i>nState</i> is set to CONTROLCALLBACK_CAPTURING, this callback
///    function must return <b>TRUE</b> to continue capture or <b>FALSE</b> to end it.
///    
alias CAPCONTROLCALLBACK = LRESULT function(HWND hWnd, int nState);
alias JOYDEVMSGPROC = uint function(uint param0, uint param1, int param2, int param3);
alias LPJOYDEVMSGPROC = uint function();
alias TASKCALLBACK = void function(size_t dwInst);
alias LPTASKCALLBACK = void function();

// Structs


struct HMIDI
{
    ptrdiff_t Value;
}

struct HMIDIIN
{
    ptrdiff_t Value;
}

struct HMIDIOUT
{
    ptrdiff_t Value;
}

struct HMIDISTRM
{
    ptrdiff_t Value;
}

struct HMIXER
{
    ptrdiff_t Value;
}

struct HMIXEROBJ
{
    ptrdiff_t Value;
}

struct HWAVEIN
{
    ptrdiff_t Value;
}

struct HWAVEOUT
{
    ptrdiff_t Value;
}

struct MMTIME
{
align (1):
    uint wType;
union u
    {
    align (1):
        uint ms;
        uint sample;
        uint cb;
        uint ticks;
struct smpte
        {
            ubyte    hour;
            ubyte    min;
            ubyte    sec;
            ubyte    frame;
            ubyte    fps;
            ubyte    dummy;
            ubyte[2] pad;
        }
struct midi
        {
        align (1):
            uint songptrpos;
        }
    }
}

struct HDRVR__
{
align (1):
    int unused;
}

struct DRVCONFIGINFOEX
{
align (1):
    uint         dwDCISize;
    const(PWSTR) lpszDCISectionName;
    const(PWSTR) lpszDCIAliasName;
    uint         dnDevNode;
}

///Contains the registry key and value names associated with the installable driver.
struct DRVCONFIGINFO
{
align (1):
    ///Size of the structure, in bytes.
    uint         dwDCISize;
    ///Address of a null-terminated, wide-character string specifying the name of the registry key associated with the
    ///driver.
    const(PWSTR) lpszDCISectionName;
    ///Address of a null-terminated, wide-character string specifying the name of the registry value associated with the
    ///driver.
    const(PWSTR) lpszDCIAliasName;
}

struct HMMIO__
{
align (1):
    int unused;
}

struct MMIOINFO
{
align (1):
    uint       dwFlags;
    uint       fccIOProc;
    LPMMIOPROC pIOProc;
    uint       wErrorRet;
    HTASK      htask;
    int        cchBuffer;
    byte*      pchBuffer;
    byte*      pchNext;
    byte*      pchEndRead;
    byte*      pchEndWrite;
    int        lBufOffset;
    int        lDiskOffset;
    uint[3]    adwInfo;
    uint       dwReserved1;
    uint       dwReserved2;
    HMMIO__*   hmmio;
}

///The <b>MMCKINFO</b> structure contains information about a chunk in a RIFF file.
struct MMCKINFO
{
align (1):
    ///Chunk identifier.
    uint ckid;
    ///Size, in bytes, of the data member of the chunk. The size of the data member does not include the 4-byte chunk
    ///identifier, the 4-byte chunk size, or the optional pad byte at the end of the data member.
    uint cksize;
    ///Form type for "RIFF" chunks or the list type for "LIST" chunks.
    uint fccType;
    ///File offset of the beginning of the chunk's data member, relative to the beginning of the file.
    uint dwDataOffset;
    ///Flags specifying additional information about the chunk. It can be zero or the following flag: <table> <tr>
    ///<th>Name</th> <th>Description</th> </tr> <tr> <td width="40%"><a id="MMIO_DIRTY"></a><a id="mmio_dirty"></a><dl>
    ///<dt><b>MMIO_DIRTY</b></dt> </dl> </td> <td width="60%"> The length of the chunk might have changed and should be
    ///updated by the mmioAscend function. This flag is set when a chunk is created by using the mmioCreateChunk
    ///function. </td> </tr> </table>
    uint dwFlags;
}

///The <b>WAVEHDR</b> structure defines the header used to identify a waveform-audio buffer.
struct WAVEHDR
{
align (1):
    ///Pointer to the waveform buffer.
    PSTR     lpData;
    ///Length, in bytes, of the buffer.
    uint     dwBufferLength;
    ///When the header is used in input, specifies how much data is in the buffer.
    uint     dwBytesRecorded;
    ///User data.
    size_t   dwUser;
    ///A bitwise <b>OR</b> of zero of more flags. The following flags are defined: <table> <tr> <th>Name</th>
    ///<th>Description</th> </tr> <tr> <td width="40%"><a id="WHDR_BEGINLOOP"></a><a id="whdr_beginloop"></a><dl>
    ///<dt><b>WHDR_BEGINLOOP</b></dt> </dl> </td> <td width="60%"> This buffer is the first buffer in a loop. This flag
    ///is used only with output buffers. </td> </tr> <tr> <td width="40%"><a id="WHDR_DONE"></a><a
    ///id="whdr_done"></a><dl> <dt><b>WHDR_DONE</b></dt> </dl> </td> <td width="60%"> Set by the device driver to
    ///indicate that it is finished with the buffer and is returning it to the application. </td> </tr> <tr> <td
    ///width="40%"><a id="WHDR_ENDLOOP"></a><a id="whdr_endloop"></a><dl> <dt><b>WHDR_ENDLOOP</b></dt> </dl> </td> <td
    ///width="60%"> This buffer is the last buffer in a loop. This flag is used only with output buffers. </td> </tr>
    ///<tr> <td width="40%"><a id="WHDR_INQUEUE"></a><a id="whdr_inqueue"></a><dl> <dt><b>WHDR_INQUEUE</b></dt> </dl>
    ///</td> <td width="60%"> Set by Windows to indicate that the buffer is queued for playback. </td> </tr> <tr> <td
    ///width="40%"><a id="WHDR_PREPARED"></a><a id="whdr_prepared"></a><dl> <dt><b>WHDR_PREPARED</b></dt> </dl> </td>
    ///<td width="60%"> Set by Windows to indicate that the buffer has been prepared with the waveInPrepareHeader or
    ///waveOutPrepareHeader function. </td> </tr> </table>
    uint     dwFlags;
    ///Number of times to play the loop. This member is used only with output buffers.
    uint     dwLoops;
    ///Reserved.
    WAVEHDR* lpNext;
    ///Reserved.
    size_t   reserved;
}

///The <b>WAVEOUTCAPS</b> structure describes the capabilities of a waveform-audio output device.
struct WAVEOUTCAPSA
{
align (1):
    ///Manufacturer identifier for the device driver for the device. Manufacturer identifiers are defined in
    ///Manufacturer and Product Identifiers.
    ushort   wMid;
    ///Product identifier for the device. Product identifiers are defined in Manufacturer and Product Identifiers.
    ushort   wPid;
    ///Version number of the device driver for the device. The high-order byte is the major version number, and the
    ///low-order byte is the minor version number.
    uint     vDriverVersion;
    ///Product name in a null-terminated string.
    byte[32] szPname;
    ///Standard formats that are supported. Can be a combination of the following: <table> <tr> <th>Format</th>
    ///<th>Description</th> </tr> <tr> <td>WAVE_FORMAT_1M08</td> <td>11.025 kHz, mono, 8-bit</td> </tr> <tr>
    ///<td>WAVE_FORMAT_1M16</td> <td>11.025 kHz, mono, 16-bit</td> </tr> <tr> <td>WAVE_FORMAT_1S08</td> <td>11.025 kHz,
    ///stereo, 8-bit</td> </tr> <tr> <td>WAVE_FORMAT_1S16</td> <td>11.025 kHz, stereo, 16-bit</td> </tr> <tr>
    ///<td>WAVE_FORMAT_2M08</td> <td>22.05 kHz, mono, 8-bit</td> </tr> <tr> <td>WAVE_FORMAT_2M16</td> <td>22.05 kHz,
    ///mono, 16-bit</td> </tr> <tr> <td>WAVE_FORMAT_2S08</td> <td>22.05 kHz, stereo, 8-bit</td> </tr> <tr>
    ///<td>WAVE_FORMAT_2S16</td> <td>22.05 kHz, stereo, 16-bit</td> </tr> <tr> <td>WAVE_FORMAT_4M08</td> <td>44.1 kHz,
    ///mono, 8-bit</td> </tr> <tr> <td>WAVE_FORMAT_4M16</td> <td>44.1 kHz, mono, 16-bit</td> </tr> <tr>
    ///<td>WAVE_FORMAT_4S08</td> <td>44.1 kHz, stereo, 8-bit</td> </tr> <tr> <td>WAVE_FORMAT_4S16</td> <td>44.1 kHz,
    ///stereo, 16-bit</td> </tr> <tr> <td>WAVE_FORMAT_96M08</td> <td>96 kHz, mono, 8-bit</td> </tr> <tr>
    ///<td>WAVE_FORMAT_96M16</td> <td>96 kHz, mono, 16-bit</td> </tr> <tr> <td>WAVE_FORMAT_96S08</td> <td>96 kHz,
    ///stereo, 8-bit</td> </tr> <tr> <td>WAVE_FORMAT_96S16</td> <td>96 kHz, stereo, 16-bit</td> </tr> </table>
    uint     dwFormats;
    ///Number specifying whether the device supports mono (1) or stereo (2) output.
    ushort   wChannels;
    ushort   wReserved1;
    ///Optional functionality supported by the device. The following values are defined: <table> <tr> <th>Flag</th>
    ///<th>Description</th> </tr> <tr> <td>WAVECAPS_LRVOLUME</td> <td>Supports separate left and right volume
    ///control.</td> </tr> <tr> <td>WAVECAPS_PITCH</td> <td>Supports pitch control.</td> </tr> <tr>
    ///<td>WAVECAPS_PLAYBACKRATE</td> <td>Supports playback rate control.</td> </tr> <tr> <td>WAVECAPS_SYNC</td> <td>The
    ///driver is synchronous and will block while playing a buffer.</td> </tr> <tr> <td>WAVECAPS_VOLUME</td>
    ///<td>Supports volume control.</td> </tr> <tr> <td>WAVECAPS_SAMPLEACCURATE</td> <td>Returns sample-accurate
    ///position information.</td> </tr> </table>
    uint     dwSupport;
}

///The <b>WAVEOUTCAPS</b> structure describes the capabilities of a waveform-audio output device.
struct WAVEOUTCAPSW
{
align (1):
    ///Manufacturer identifier for the device driver for the device. Manufacturer identifiers are defined in
    ///Manufacturer and Product Identifiers.
    ushort     wMid;
    ///Product identifier for the device. Product identifiers are defined in Manufacturer and Product Identifiers.
    ushort     wPid;
    ///Version number of the device driver for the device. The high-order byte is the major version number, and the
    ///low-order byte is the minor version number.
    uint       vDriverVersion;
    ///Product name in a null-terminated string.
    ushort[32] szPname;
    ///Standard formats that are supported. Can be a combination of the following: <table> <tr> <th>Format</th>
    ///<th>Description</th> </tr> <tr> <td>WAVE_FORMAT_1M08</td> <td>11.025 kHz, mono, 8-bit</td> </tr> <tr>
    ///<td>WAVE_FORMAT_1M16</td> <td>11.025 kHz, mono, 16-bit</td> </tr> <tr> <td>WAVE_FORMAT_1S08</td> <td>11.025 kHz,
    ///stereo, 8-bit</td> </tr> <tr> <td>WAVE_FORMAT_1S16</td> <td>11.025 kHz, stereo, 16-bit</td> </tr> <tr>
    ///<td>WAVE_FORMAT_2M08</td> <td>22.05 kHz, mono, 8-bit</td> </tr> <tr> <td>WAVE_FORMAT_2M16</td> <td>22.05 kHz,
    ///mono, 16-bit</td> </tr> <tr> <td>WAVE_FORMAT_2S08</td> <td>22.05 kHz, stereo, 8-bit</td> </tr> <tr>
    ///<td>WAVE_FORMAT_2S16</td> <td>22.05 kHz, stereo, 16-bit</td> </tr> <tr> <td>WAVE_FORMAT_4M08</td> <td>44.1 kHz,
    ///mono, 8-bit</td> </tr> <tr> <td>WAVE_FORMAT_4M16</td> <td>44.1 kHz, mono, 16-bit</td> </tr> <tr>
    ///<td>WAVE_FORMAT_4S08</td> <td>44.1 kHz, stereo, 8-bit</td> </tr> <tr> <td>WAVE_FORMAT_4S16</td> <td>44.1 kHz,
    ///stereo, 16-bit</td> </tr> <tr> <td>WAVE_FORMAT_96M08</td> <td>96 kHz, mono, 8-bit</td> </tr> <tr>
    ///<td>WAVE_FORMAT_96M16</td> <td>96 kHz, mono, 16-bit</td> </tr> <tr> <td>WAVE_FORMAT_96S08</td> <td>96 kHz,
    ///stereo, 8-bit</td> </tr> <tr> <td>WAVE_FORMAT_96S16</td> <td>96 kHz, stereo, 16-bit</td> </tr> </table>
    uint       dwFormats;
    ///Number specifying whether the device supports mono (1) or stereo (2) output.
    ushort     wChannels;
    ushort     wReserved1;
    ///Optional functionality supported by the device. The following values are defined: <table> <tr> <th>Flag</th>
    ///<th>Description</th> </tr> <tr> <td>WAVECAPS_LRVOLUME</td> <td>Supports separate left and right volume
    ///control.</td> </tr> <tr> <td>WAVECAPS_PITCH</td> <td>Supports pitch control.</td> </tr> <tr>
    ///<td>WAVECAPS_PLAYBACKRATE</td> <td>Supports playback rate control.</td> </tr> <tr> <td>WAVECAPS_SYNC</td> <td>The
    ///driver is synchronous and will block while playing a buffer.</td> </tr> <tr> <td>WAVECAPS_VOLUME</td>
    ///<td>Supports volume control.</td> </tr> <tr> <td>WAVECAPS_SAMPLEACCURATE</td> <td>Returns sample-accurate
    ///position information.</td> </tr> </table>
    uint       dwSupport;
}

struct WAVEOUTCAPS2A
{
align (1):
    ushort   wMid;
    ushort   wPid;
    uint     vDriverVersion;
    byte[32] szPname;
    uint     dwFormats;
    ushort   wChannels;
    ushort   wReserved1;
    uint     dwSupport;
    GUID     ManufacturerGuid;
    GUID     ProductGuid;
    GUID     NameGuid;
}

struct WAVEOUTCAPS2W
{
align (1):
    ushort     wMid;
    ushort     wPid;
    uint       vDriverVersion;
    ushort[32] szPname;
    uint       dwFormats;
    ushort     wChannels;
    ushort     wReserved1;
    uint       dwSupport;
    GUID       ManufacturerGuid;
    GUID       ProductGuid;
    GUID       NameGuid;
}

///The <b>WAVEINCAPS</b> structure describes the capabilities of a waveform-audio input device.
struct WAVEINCAPSA
{
align (1):
    ///Manufacturer identifier for the device driver for the waveform-audio input device. Manufacturer identifiers are
    ///defined in Manufacturer and Product Identifiers.
    ushort   wMid;
    ///Product identifier for the waveform-audio input device. Product identifiers are defined in Manufacturer and
    ///Product Identifiers.
    ushort   wPid;
    ///Version number of the device driver for the waveform-audio input device. The high-order byte is the major version
    ///number, and the low-order byte is the minor version number.
    uint     vDriverVersion;
    ///Product name in a null-terminated string.
    byte[32] szPname;
    ///Standard formats that are supported. Can be a combination of the following: <table> <tr> <th>Format</th>
    ///<th>Description</th> </tr> <tr> <td>WAVE_FORMAT_1M08</td> <td>11.025 kHz, mono, 8-bit</td> </tr> <tr>
    ///<td>WAVE_FORMAT_1M16</td> <td>11.025 kHz, mono, 16-bit</td> </tr> <tr> <td>WAVE_FORMAT_1S08</td> <td>11.025 kHz,
    ///stereo, 8-bit</td> </tr> <tr> <td>WAVE_FORMAT_1S16</td> <td>11.025 kHz, stereo, 16-bit</td> </tr> <tr>
    ///<td>WAVE_FORMAT_2M08</td> <td>22.05 kHz, mono, 8-bit</td> </tr> <tr> <td>WAVE_FORMAT_2M16</td> <td>22.05 kHz,
    ///mono, 16-bit</td> </tr> <tr> <td>WAVE_FORMAT_2S08</td> <td>22.05 kHz, stereo, 8-bit</td> </tr> <tr>
    ///<td>WAVE_FORMAT_2S16</td> <td>22.05 kHz, stereo, 16-bit</td> </tr> <tr> <td>WAVE_FORMAT_4M08</td> <td>44.1 kHz,
    ///mono, 8-bit</td> </tr> <tr> <td>WAVE_FORMAT_4M16</td> <td>44.1 kHz, mono, 16-bit</td> </tr> <tr>
    ///<td>WAVE_FORMAT_4S08</td> <td>44.1 kHz, stereo, 8-bit</td> </tr> <tr> <td>WAVE_FORMAT_4S16</td> <td>44.1 kHz,
    ///stereo, 16-bit</td> </tr> <tr> <td>WAVE_FORMAT_96M08</td> <td>96 kHz, mono, 8-bit</td> </tr> <tr>
    ///<td>WAVE_FORMAT_96M16</td> <td>96 kHz, mono, 16-bit</td> </tr> <tr> <td>WAVE_FORMAT_96S08</td> <td>96 kHz,
    ///stereo, 8-bit</td> </tr> <tr> <td>WAVE_FORMAT_96S16</td> <td>96 kHz, stereo, 16-bit</td> </tr> </table>
    uint     dwFormats;
    ///Number specifying whether the device supports mono (1) or stereo (2) input.
    ushort   wChannels;
    ushort   wReserved1;
}

///The <b>WAVEINCAPS</b> structure describes the capabilities of a waveform-audio input device.
struct WAVEINCAPSW
{
align (1):
    ///Manufacturer identifier for the device driver for the waveform-audio input device. Manufacturer identifiers are
    ///defined in Manufacturer and Product Identifiers.
    ushort     wMid;
    ///Product identifier for the waveform-audio input device. Product identifiers are defined in Manufacturer and
    ///Product Identifiers.
    ushort     wPid;
    ///Version number of the device driver for the waveform-audio input device. The high-order byte is the major version
    ///number, and the low-order byte is the minor version number.
    uint       vDriverVersion;
    ///Product name in a null-terminated string.
    ushort[32] szPname;
    ///Standard formats that are supported. Can be a combination of the following: <table> <tr> <th>Format</th>
    ///<th>Description</th> </tr> <tr> <td>WAVE_FORMAT_1M08</td> <td>11.025 kHz, mono, 8-bit</td> </tr> <tr>
    ///<td>WAVE_FORMAT_1M16</td> <td>11.025 kHz, mono, 16-bit</td> </tr> <tr> <td>WAVE_FORMAT_1S08</td> <td>11.025 kHz,
    ///stereo, 8-bit</td> </tr> <tr> <td>WAVE_FORMAT_1S16</td> <td>11.025 kHz, stereo, 16-bit</td> </tr> <tr>
    ///<td>WAVE_FORMAT_2M08</td> <td>22.05 kHz, mono, 8-bit</td> </tr> <tr> <td>WAVE_FORMAT_2M16</td> <td>22.05 kHz,
    ///mono, 16-bit</td> </tr> <tr> <td>WAVE_FORMAT_2S08</td> <td>22.05 kHz, stereo, 8-bit</td> </tr> <tr>
    ///<td>WAVE_FORMAT_2S16</td> <td>22.05 kHz, stereo, 16-bit</td> </tr> <tr> <td>WAVE_FORMAT_4M08</td> <td>44.1 kHz,
    ///mono, 8-bit</td> </tr> <tr> <td>WAVE_FORMAT_4M16</td> <td>44.1 kHz, mono, 16-bit</td> </tr> <tr>
    ///<td>WAVE_FORMAT_4S08</td> <td>44.1 kHz, stereo, 8-bit</td> </tr> <tr> <td>WAVE_FORMAT_4S16</td> <td>44.1 kHz,
    ///stereo, 16-bit</td> </tr> <tr> <td>WAVE_FORMAT_96M08</td> <td>96 kHz, mono, 8-bit</td> </tr> <tr>
    ///<td>WAVE_FORMAT_96M16</td> <td>96 kHz, mono, 16-bit</td> </tr> <tr> <td>WAVE_FORMAT_96S08</td> <td>96 kHz,
    ///stereo, 8-bit</td> </tr> <tr> <td>WAVE_FORMAT_96S16</td> <td>96 kHz, stereo, 16-bit</td> </tr> </table>
    uint       dwFormats;
    ///Number specifying whether the device supports mono (1) or stereo (2) input.
    ushort     wChannels;
    ushort     wReserved1;
}

struct WAVEINCAPS2A
{
align (1):
    ushort   wMid;
    ushort   wPid;
    uint     vDriverVersion;
    byte[32] szPname;
    uint     dwFormats;
    ushort   wChannels;
    ushort   wReserved1;
    GUID     ManufacturerGuid;
    GUID     ProductGuid;
    GUID     NameGuid;
}

struct WAVEINCAPS2W
{
align (1):
    ushort     wMid;
    ushort     wPid;
    uint       vDriverVersion;
    ushort[32] szPname;
    uint       dwFormats;
    ushort     wChannels;
    ushort     wReserved1;
    GUID       ManufacturerGuid;
    GUID       ProductGuid;
    GUID       NameGuid;
}

///The <b>WAVEFORMAT</b> structure describes the format of waveform-audio data. Only format information common to all
///waveform-audio data formats is included in this structure. This structure has been superseded by the WAVEFORMATEX
///structure.
struct WAVEFORMAT
{
align (1):
    ///Format type. The following type is defined: <table> <tr> <th>Name</th> <th>Description</th> </tr> <tr> <td
    ///width="40%"><a id="WAVE_FORMAT_PCM"></a><a id="wave_format_pcm"></a><dl> <dt><b>WAVE_FORMAT_PCM</b></dt> </dl>
    ///</td> <td width="60%"> Waveform-audio data is PCM. </td> </tr> </table>
    ushort wFormatTag;
    ///Number of channels in the waveform-audio data. Mono data uses one channel and stereo data uses two channels.
    ushort nChannels;
    ///Sample rate, in samples per second.
    uint   nSamplesPerSec;
    ///Required average data transfer rate, in bytes per second. For example, 16-bit stereo at 44.1 kHz has an average
    ///data rate of 176,400 bytes per second (2 channels — 2 bytes per sample per channel — 44,100 samples per
    ///second).
    uint   nAvgBytesPerSec;
    ///Block alignment, in bytes. The block alignment is the minimum atomic unit of data. For PCM data, the block
    ///alignment is the number of bytes used by a single sample, including data for both channels if the data is stereo.
    ///For example, the block alignment for 16-bit stereo PCM is 4 bytes (2 channels — 2 bytes per sample).
    ushort nBlockAlign;
}

///The <b>PCMWAVEFORMAT</b> structure describes the data format for PCM waveform-audio data. This structure has been
///superseded by the WAVEFORMATEX structure.
struct PCMWAVEFORMAT
{
align (1):
    ///A WAVEFORMAT structure containing general information about the format of the data.
    WAVEFORMAT wf;
    ///Number of bits per sample.
    ushort     wBitsPerSample;
}

///The WAVEFORMATEX structure specifies the data format of a wave audio stream.
struct WAVEFORMATEX
{
align (1):
    ///Specifies the waveform audio format type. For more information, see the following Remarks section.
    ushort wFormatTag;
    ///Specifies the number of channels of audio data. For monophonic audio, set this member to 1. For stereo, set this
    ///member to 2.
    ushort nChannels;
    ///Specifies the sample frequency at which each channel should be played or recorded. If <b>wFormatTag</b> =
    ///WAVE_FORMAT_PCM, then common values for <b>nSamplesPerSec</b> are 8.0 kHz, 11.025 kHz, 22.05 kHz, and 44.1 kHz.
    ///For example, to specify a sample frequency of 11.025 kHz, set <b>nSamplesPerSec</b> to 11025. For non-PCM
    ///formats, this member should be computed according to the manufacturer's specification of the format tag.
    uint   nSamplesPerSec;
    ///Specifies the required average data transfer rate in bytes per second. This value is useful for estimating buffer
    ///size.
    uint   nAvgBytesPerSec;
    ///Specifies the block alignment in bytes. The block alignment is the size of the minimum atomic unit of data for
    ///the <b>wFormatTag</b> format type. If <b>wFormatTag</b> = WAVE_FORMAT_PCM or <b>wFormatTag</b> =
    ///WAVE_FORMAT_IEEE_FLOAT, set <b>nBlockAlign</b> to <code>(nChannels*wBitsPerSample)/8</code>, which is the size of
    ///a single audio frame. For non-PCM formats, this member should be computed according to the manufacturer's
    ///specification for the format tag. Playback and record software should process a multiple of <b>nBlockAlign</b>
    ///bytes of data at a time. Data written to and read from a device should always start at the beginning of a block.
    ushort nBlockAlign;
    ///Specifies the number of bits per sample for the format type specified by <b>wFormatTag</b>. If <b>wFormatTag</b>
    ///= WAVE_FORMAT_PCM, then <b>wBitsPerSample</b> should be set to either 8 or 16. If <b>wFormatTag</b> =
    ///WAVE_FORMAT_IEEE_FLOAT, <b>wBitsPerSample</b> should be set to 32. For non-PCM formats, set the value of this
    ///member according to the manufacturer's specification for the format tag. Some compression schemes cannot define a
    ///value for <b>wBitsPerSample</b>. In this case, set <b>wBitsPerSample</b> to zero.
    ushort wBitsPerSample;
    ///Specifies the size, in bytes, of extra format information appended to the end of the WAVEFORMATEX structure. This
    ///information can be used by non-PCM formats to store extra attributes for the <b>wFormatTag</b>. If no extra
    ///information is required by the <b>wFormatTag</b>, set this member to zero. For WAVE_FORMAT_PCM formats, clients
    ///should ignore this member (its value is implicitly zero). Because all clients might not follow this rule, we
    ///recommend that you initialize <b>cbSize</b> to zero for WAVE_FORMAT_PCM formats.
    ushort cbSize;
}

///The <b>MIDIOUTCAPS</b> structure describes the capabilities of a MIDI output device.
struct MIDIOUTCAPSA
{
align (1):
    ///Manufacturer identifier of the device driver for the MIDI output device. Manufacturer identifiers are defined in
    ///Manufacturer and Product Identifiers.
    ushort   wMid;
    ///Product identifier of the MIDI output device. Product identifiers are defined in Manufacturer and Product
    ///Identifiers.
    ushort   wPid;
    ///Version number of the device driver for the MIDI output device. The high-order byte is the major version number,
    ///and the low-order byte is the minor version number.
    uint     vDriverVersion;
    ///Product name in a null-terminated string.
    byte[32] szPname;
    ///Type of the MIDI output device. This value can be one of the following: <table> <tr> <th>Name</th>
    ///<th>Description</th> </tr> <tr> <td width="40%"><a id="MOD_MIDIPORT"></a><a id="mod_midiport"></a><dl>
    ///<dt><b>MOD_MIDIPORT</b></dt> </dl> </td> <td width="60%"> MIDI hardware port. </td> </tr> <tr> <td width="40%"><a
    ///id="MOD_SYNTH"></a><a id="mod_synth"></a><dl> <dt><b>MOD_SYNTH</b></dt> </dl> </td> <td width="60%"> Synthesizer.
    ///</td> </tr> <tr> <td width="40%"><a id="MOD_SQSYNTH"></a><a id="mod_sqsynth"></a><dl> <dt><b>MOD_SQSYNTH</b></dt>
    ///</dl> </td> <td width="60%"> Square wave synthesizer. </td> </tr> <tr> <td width="40%"><a id="MOD_FMSYNTH"></a><a
    ///id="mod_fmsynth"></a><dl> <dt><b>MOD_FMSYNTH</b></dt> </dl> </td> <td width="60%"> FM synthesizer. </td> </tr>
    ///<tr> <td width="40%"><a id="MOD_MAPPER"></a><a id="mod_mapper"></a><dl> <dt><b>MOD_MAPPER</b></dt> </dl> </td>
    ///<td width="60%"> Microsoft MIDI mapper. </td> </tr> <tr> <td width="40%"><a id="MOD_WAVETABLE"></a><a
    ///id="mod_wavetable"></a><dl> <dt><b>MOD_WAVETABLE</b></dt> </dl> </td> <td width="60%"> Hardware wavetable
    ///synthesizer. </td> </tr> <tr> <td width="40%"><a id="MOD_SWSYNTH"></a><a id="mod_swsynth"></a><dl>
    ///<dt><b>MOD_SWSYNTH</b></dt> </dl> </td> <td width="60%"> Software synthesizer. </td> </tr> </table>
    ushort   wTechnology;
    ///Number of voices supported by an internal synthesizer device. If the device is a port, this member is not
    ///meaningful and is set to 0.
    ushort   wVoices;
    ///Maximum number of simultaneous notes that can be played by an internal synthesizer device. If the device is a
    ///port, this member is not meaningful and is set to 0.
    ushort   wNotes;
    ///Channels that an internal synthesizer device responds to, where the least significant bit refers to channel 0 and
    ///the most significant bit to channel 15. Port devices that transmit on all channels set this member to 0xFFFF.
    ushort   wChannelMask;
    ///Optional functionality supported by the device. It can be one or more of the following: <table> <tr>
    ///<th>Name</th> <th>Description</th> </tr> <tr> <td width="40%"><a id="MIDICAPS_CACHE"></a><a
    ///id="midicaps_cache"></a><dl> <dt><b>MIDICAPS_CACHE</b></dt> </dl> </td> <td width="60%"> Supports patch caching.
    ///</td> </tr> <tr> <td width="40%"><a id="MIDICAPS_LRVOLUME"></a><a id="midicaps_lrvolume"></a><dl>
    ///<dt><b>MIDICAPS_LRVOLUME</b></dt> </dl> </td> <td width="60%"> Supports separate left and right volume control.
    ///</td> </tr> <tr> <td width="40%"><a id="MIDICAPS_STREAM"></a><a id="midicaps_stream"></a><dl>
    ///<dt><b>MIDICAPS_STREAM</b></dt> </dl> </td> <td width="60%"> Provides direct support for the midiStreamOut
    ///function. </td> </tr> <tr> <td width="40%"><a id="MIDICAPS_VOLUME"></a><a id="midicaps_volume"></a><dl>
    ///<dt><b>MIDICAPS_VOLUME</b></dt> </dl> </td> <td width="60%"> Supports volume control. </td> </tr> </table> If a
    ///device supports volume changes, the MIDICAPS_VOLUME flag will be set for the dwSupport member. If a device
    ///supports separate volume changes on the left and right channels, both the MIDICAPS_VOLUME and the
    ///MIDICAPS_LRVOLUME flags will be set for this member.
    uint     dwSupport;
}

///The <b>MIDIOUTCAPS</b> structure describes the capabilities of a MIDI output device.
struct MIDIOUTCAPSW
{
align (1):
    ///Manufacturer identifier of the device driver for the MIDI output device. Manufacturer identifiers are defined in
    ///Manufacturer and Product Identifiers.
    ushort     wMid;
    ///Product identifier of the MIDI output device. Product identifiers are defined in Manufacturer and Product
    ///Identifiers.
    ushort     wPid;
    ///Version number of the device driver for the MIDI output device. The high-order byte is the major version number,
    ///and the low-order byte is the minor version number.
    uint       vDriverVersion;
    ///Product name in a null-terminated string.
    ushort[32] szPname;
    ///Type of the MIDI output device. This value can be one of the following: <table> <tr> <th>Name</th>
    ///<th>Description</th> </tr> <tr> <td width="40%"><a id="MOD_MIDIPORT"></a><a id="mod_midiport"></a><dl>
    ///<dt><b>MOD_MIDIPORT</b></dt> </dl> </td> <td width="60%"> MIDI hardware port. </td> </tr> <tr> <td width="40%"><a
    ///id="MOD_SYNTH"></a><a id="mod_synth"></a><dl> <dt><b>MOD_SYNTH</b></dt> </dl> </td> <td width="60%"> Synthesizer.
    ///</td> </tr> <tr> <td width="40%"><a id="MOD_SQSYNTH"></a><a id="mod_sqsynth"></a><dl> <dt><b>MOD_SQSYNTH</b></dt>
    ///</dl> </td> <td width="60%"> Square wave synthesizer. </td> </tr> <tr> <td width="40%"><a id="MOD_FMSYNTH"></a><a
    ///id="mod_fmsynth"></a><dl> <dt><b>MOD_FMSYNTH</b></dt> </dl> </td> <td width="60%"> FM synthesizer. </td> </tr>
    ///<tr> <td width="40%"><a id="MOD_MAPPER"></a><a id="mod_mapper"></a><dl> <dt><b>MOD_MAPPER</b></dt> </dl> </td>
    ///<td width="60%"> Microsoft MIDI mapper. </td> </tr> <tr> <td width="40%"><a id="MOD_WAVETABLE"></a><a
    ///id="mod_wavetable"></a><dl> <dt><b>MOD_WAVETABLE</b></dt> </dl> </td> <td width="60%"> Hardware wavetable
    ///synthesizer. </td> </tr> <tr> <td width="40%"><a id="MOD_SWSYNTH"></a><a id="mod_swsynth"></a><dl>
    ///<dt><b>MOD_SWSYNTH</b></dt> </dl> </td> <td width="60%"> Software synthesizer. </td> </tr> </table>
    ushort     wTechnology;
    ///Number of voices supported by an internal synthesizer device. If the device is a port, this member is not
    ///meaningful and is set to 0.
    ushort     wVoices;
    ///Maximum number of simultaneous notes that can be played by an internal synthesizer device. If the device is a
    ///port, this member is not meaningful and is set to 0.
    ushort     wNotes;
    ///Channels that an internal synthesizer device responds to, where the least significant bit refers to channel 0 and
    ///the most significant bit to channel 15. Port devices that transmit on all channels set this member to 0xFFFF.
    ushort     wChannelMask;
    ///Optional functionality supported by the device. It can be one or more of the following: <table> <tr>
    ///<th>Name</th> <th>Description</th> </tr> <tr> <td width="40%"><a id="MIDICAPS_CACHE"></a><a
    ///id="midicaps_cache"></a><dl> <dt><b>MIDICAPS_CACHE</b></dt> </dl> </td> <td width="60%"> Supports patch caching.
    ///</td> </tr> <tr> <td width="40%"><a id="MIDICAPS_LRVOLUME"></a><a id="midicaps_lrvolume"></a><dl>
    ///<dt><b>MIDICAPS_LRVOLUME</b></dt> </dl> </td> <td width="60%"> Supports separate left and right volume control.
    ///</td> </tr> <tr> <td width="40%"><a id="MIDICAPS_STREAM"></a><a id="midicaps_stream"></a><dl>
    ///<dt><b>MIDICAPS_STREAM</b></dt> </dl> </td> <td width="60%"> Provides direct support for the midiStreamOut
    ///function. </td> </tr> <tr> <td width="40%"><a id="MIDICAPS_VOLUME"></a><a id="midicaps_volume"></a><dl>
    ///<dt><b>MIDICAPS_VOLUME</b></dt> </dl> </td> <td width="60%"> Supports volume control. </td> </tr> </table> If a
    ///device supports volume changes, the MIDICAPS_VOLUME flag will be set for the dwSupport member. If a device
    ///supports separate volume changes on the left and right channels, both the MIDICAPS_VOLUME and the
    ///MIDICAPS_LRVOLUME flags will be set for this member.
    uint       dwSupport;
}

struct MIDIOUTCAPS2A
{
align (1):
    ushort   wMid;
    ushort   wPid;
    uint     vDriverVersion;
    byte[32] szPname;
    ushort   wTechnology;
    ushort   wVoices;
    ushort   wNotes;
    ushort   wChannelMask;
    uint     dwSupport;
    GUID     ManufacturerGuid;
    GUID     ProductGuid;
    GUID     NameGuid;
}

struct MIDIOUTCAPS2W
{
align (1):
    ushort     wMid;
    ushort     wPid;
    uint       vDriverVersion;
    ushort[32] szPname;
    ushort     wTechnology;
    ushort     wVoices;
    ushort     wNotes;
    ushort     wChannelMask;
    uint       dwSupport;
    GUID       ManufacturerGuid;
    GUID       ProductGuid;
    GUID       NameGuid;
}

///The <b>MIDIINCAPS</b> structure describes the capabilities of a MIDI input device.
struct MIDIINCAPSA
{
align (1):
    ///Manufacturer identifier of the device driver for the MIDI input device. Manufacturer identifiers are defined in
    ///Manufacturer and Product Identifiers.
    ushort   wMid;
    ///Product identifier of the MIDI input device. Product identifiers are defined in Manufacturer and Product
    ///Identifiers.
    ushort   wPid;
    ///Version number of the device driver for the MIDI input device. The high-order byte is the major version number,
    ///and the low-order byte is the minor version number.
    uint     vDriverVersion;
    ///Product name in a null-terminated string.
    byte[32] szPname;
    ///Reserved; must be zero.
    uint     dwSupport;
}

///The <b>MIDIINCAPS</b> structure describes the capabilities of a MIDI input device.
struct MIDIINCAPSW
{
align (1):
    ///Manufacturer identifier of the device driver for the MIDI input device. Manufacturer identifiers are defined in
    ///Manufacturer and Product Identifiers.
    ushort     wMid;
    ///Product identifier of the MIDI input device. Product identifiers are defined in Manufacturer and Product
    ///Identifiers.
    ushort     wPid;
    ///Version number of the device driver for the MIDI input device. The high-order byte is the major version number,
    ///and the low-order byte is the minor version number.
    uint       vDriverVersion;
    ///Product name in a null-terminated string.
    ushort[32] szPname;
    ///Reserved; must be zero.
    uint       dwSupport;
}

struct MIDIINCAPS2A
{
align (1):
    ushort   wMid;
    ushort   wPid;
    uint     vDriverVersion;
    byte[32] szPname;
    uint     dwSupport;
    GUID     ManufacturerGuid;
    GUID     ProductGuid;
    GUID     NameGuid;
}

struct MIDIINCAPS2W
{
align (1):
    ushort     wMid;
    ushort     wPid;
    uint       vDriverVersion;
    ushort[32] szPname;
    uint       dwSupport;
    GUID       ManufacturerGuid;
    GUID       ProductGuid;
    GUID       NameGuid;
}

///The <b>MIDIHDR</b> structure defines the header used to identify a MIDI system-exclusive or stream buffer.
struct MIDIHDR
{
align (1):
    ///Pointer to MIDI data.
    PSTR      lpData;
    ///Size of the buffer.
    uint      dwBufferLength;
    ///Actual amount of data in the buffer. This value should be less than or equal to the value given in the
    ///<b>dwBufferLength</b> member.
    uint      dwBytesRecorded;
    ///Custom user data.
    size_t    dwUser;
    ///Flags giving information about the buffer. <table> <tr> <th>Name</th> <th>Description</th> </tr> <tr> <td
    ///width="40%"><a id="MHDR_DONE"></a><a id="mhdr_done"></a><dl> <dt><b>MHDR_DONE</b></dt> </dl> </td> <td
    ///width="60%"> Set by the device driver to indicate that it is finished with the buffer and is returning it to the
    ///application. </td> </tr> <tr> <td width="40%"><a id="MHDR_INQUEUE"></a><a id="mhdr_inqueue"></a><dl>
    ///<dt><b>MHDR_INQUEUE</b></dt> </dl> </td> <td width="60%"> Set by Windows to indicate that the buffer is queued
    ///for playback. </td> </tr> <tr> <td width="40%"><a id="MHDR_ISSTRM"></a><a id="mhdr_isstrm"></a><dl>
    ///<dt><b>MHDR_ISSTRM</b></dt> </dl> </td> <td width="60%"> Set to indicate that the buffer is a stream buffer.
    ///</td> </tr> <tr> <td width="40%"><a id="MHDR_PREPARED"></a><a id="mhdr_prepared"></a><dl>
    ///<dt><b>MHDR_PREPARED</b></dt> </dl> </td> <td width="60%"> Set by Windows to indicate that the buffer has been
    ///prepared by using the midiInPrepareHeader or midiOutPrepareHeader function. </td> </tr> </table>
    uint      dwFlags;
    ///Reserved; do not use.
    MIDIHDR*  lpNext;
    ///Reserved; do not use.
    size_t    reserved;
    ///Offset into the buffer when a callback is performed. (This callback is generated because the MEVT_F_CALLBACK flag
    ///is set in the <b>dwEvent</b> member of the MIDIEVENT structure.) This offset enables an application to determine
    ///which event caused the callback.
    uint      dwOffset;
    ///Reserved; do not use.
    size_t[8] dwReserved;
}

///The MIDIEVENT structure describes a MIDI event in a stream buffer.
struct MIDIEVENT
{
align (1):
    ///Time, in MIDI ticks, between the previous event and the current event. The length of a tick is defined by the
    ///time format and possibly the tempo associated with the stream. (The definition is identical to the specification
    ///for a tick in a standard MIDI file.)
    uint    dwDeltaTime;
    ///Reserved; must be zero.
    uint    dwStreamID;
    ///Event code and event parameters or length. To parse this information, use the MEVT_EVENTTYPE and MEVT_EVENTPARM
    ///macros. See Remarks.
    uint    dwEvent;
    ///If <b>dwEvent</b> specifies MEVT_F_LONG and the length of the buffer, this member contains parameters for the
    ///event. This parameter data must be padded with zeros so that an integral number of <b>DWORD</b> values are
    ///stored. For example, if the event data is five bytes long, three pad bytes must follow the data for a total of
    ///eight bytes. In this case, the low 24 bits of <b>dwEvent</b> would contain the value 5. If <b>dwEvent</b>
    ///specifies MEVT_F_SHORT, do not use this member in the stream buffer.
    uint[1] dwParms;
}

///The <b>MIDISTRMBUFFVER</b> structure contains version information for a long MIDI event of the MEVT_VERSION type.
struct MIDISTRMBUFFVER
{
align (1):
    ///Version of the stream. The high 16 bits contain the major version, and the low 16 bits contain the minor version.
    ///The version number for the first implementation of MIDI streams should be 1.0.
    uint dwVersion;
    ///Manufacturer identifier. Manufacturer identifiers are defined in Manufacturer and Product Identifiers.
    uint dwMid;
    ///OEM version of the stream. Original equipment manufacturers can use this field to version-stamp any custom events
    ///they have specified. If a custom event is specified, it must be the first event sent after the stream is opened.
    uint dwOEMVersion;
}

///The <b>MIDIPROPTIMEDIV</b> structure contains the time division property for a stream.
struct MIDIPROPTIMEDIV
{
align (1):
    ///Length, in bytes, of this structure. This member must be filled in for both the MIDIPROP_SET and MIDIPROP_GET
    ///operations of the midiStreamProperty function.
    uint cbStruct;
    ///Time division for this stream, in the format specified in the <i>Standard MIDI Files 1.0</i> specification. The
    ///low 16 bits of this <b>DWORD</b> value contain the time division. This member is set in a MIDIPROP_SET operation
    ///and is filled on return from a MIDIPROP_GET operation.
    uint dwTimeDiv;
}

///The <b>MIDIPROPTEMPO</b> structure contains the tempo property for a stream.
struct MIDIPROPTEMPO
{
align (1):
    ///Length, in bytes, of this structure. This member must be filled in for both the MIDIPROP_SET and MIDIPROP_GET
    ///operations of the midiStreamProperty function.
    uint cbStruct;
    ///Tempo of the stream, in microseconds per quarter note. The tempo is honored only if the time division for the
    ///stream is specified in quarter note format. This member is set in a MIDIPROP_SET operation and is filled on
    ///return from a MIDIPROP_GET operation.
    uint dwTempo;
}

///The <b>AUXCAPS</b> structure describes the capabilities of an auxiliary output device.
struct AUXCAPSA
{
align (1):
    ///Manufacturer identifier for the device driver for the auxiliary audio device. Manufacturer identifiers are
    ///defined in Manufacturer and Product Identifiers.
    ushort   wMid;
    ///Product identifier for the auxiliary audio device. Currently, no product identifiers are defined for auxiliary
    ///audio devices.
    ushort   wPid;
    ///Version number of the device driver for the auxiliary audio device. The high-order byte is the major version
    ///number, and the low-order byte is the minor version number.
    uint     vDriverVersion;
    ///Product name in a null-terminated string.
    byte[32] szPname;
    ///Type of the auxiliary audio output: <table> <tr> <th>Name</th> <th>Description</th> </tr> <tr> <td width="40%"><a
    ///id="AUXCAPS_AUXIN"></a><a id="auxcaps_auxin"></a><dl> <dt><b>AUXCAPS_AUXIN</b></dt> </dl> </td> <td width="60%">
    ///Audio output from auxiliary input jacks. </td> </tr> <tr> <td width="40%"><a id="AUXCAPS_CDAUDIO"></a><a
    ///id="auxcaps_cdaudio"></a><dl> <dt><b>AUXCAPS_CDAUDIO</b></dt> </dl> </td> <td width="60%"> Audio output from an
    ///internal CD-ROM drive. </td> </tr> </table>
    ushort   wTechnology;
    ushort   wReserved1;
    ///Describes optional functionality supported by the auxiliary audio device. <table> <tr> <th>Name</th>
    ///<th>Description</th> </tr> <tr> <td width="40%"><a id="AUXCAPS_LRVOLUME"></a><a id="auxcaps_lrvolume"></a><dl>
    ///<dt><b>AUXCAPS_LRVOLUME</b></dt> </dl> </td> <td width="60%"> Supports separate left and right volume control.
    ///</td> </tr> <tr> <td width="40%"><a id="AUXCAPS_VOLUME"></a><a id="auxcaps_volume"></a><dl>
    ///<dt><b>AUXCAPS_VOLUME</b></dt> </dl> </td> <td width="60%"> Supports volume control. </td> </tr> </table> If a
    ///device supports volume changes, the AUXCAPS_VOLUME flag will be set. If a device supports separate volume changes
    ///on the left and right channels, both AUXCAPS_VOLUME and the AUXCAPS_LRVOLUME will be set.
    uint     dwSupport;
}

///The <b>AUXCAPS</b> structure describes the capabilities of an auxiliary output device.
struct AUXCAPSW
{
align (1):
    ///Manufacturer identifier for the device driver for the auxiliary audio device. Manufacturer identifiers are
    ///defined in Manufacturer and Product Identifiers.
    ushort     wMid;
    ///Product identifier for the auxiliary audio device. Currently, no product identifiers are defined for auxiliary
    ///audio devices.
    ushort     wPid;
    ///Version number of the device driver for the auxiliary audio device. The high-order byte is the major version
    ///number, and the low-order byte is the minor version number.
    uint       vDriverVersion;
    ///Product name in a null-terminated string.
    ushort[32] szPname;
    ///Type of the auxiliary audio output: <table> <tr> <th>Name</th> <th>Description</th> </tr> <tr> <td width="40%"><a
    ///id="AUXCAPS_AUXIN"></a><a id="auxcaps_auxin"></a><dl> <dt><b>AUXCAPS_AUXIN</b></dt> </dl> </td> <td width="60%">
    ///Audio output from auxiliary input jacks. </td> </tr> <tr> <td width="40%"><a id="AUXCAPS_CDAUDIO"></a><a
    ///id="auxcaps_cdaudio"></a><dl> <dt><b>AUXCAPS_CDAUDIO</b></dt> </dl> </td> <td width="60%"> Audio output from an
    ///internal CD-ROM drive. </td> </tr> </table>
    ushort     wTechnology;
    ushort     wReserved1;
    ///Describes optional functionality supported by the auxiliary audio device. <table> <tr> <th>Name</th>
    ///<th>Description</th> </tr> <tr> <td width="40%"><a id="AUXCAPS_LRVOLUME"></a><a id="auxcaps_lrvolume"></a><dl>
    ///<dt><b>AUXCAPS_LRVOLUME</b></dt> </dl> </td> <td width="60%"> Supports separate left and right volume control.
    ///</td> </tr> <tr> <td width="40%"><a id="AUXCAPS_VOLUME"></a><a id="auxcaps_volume"></a><dl>
    ///<dt><b>AUXCAPS_VOLUME</b></dt> </dl> </td> <td width="60%"> Supports volume control. </td> </tr> </table> If a
    ///device supports volume changes, the AUXCAPS_VOLUME flag will be set. If a device supports separate volume changes
    ///on the left and right channels, both AUXCAPS_VOLUME and the AUXCAPS_LRVOLUME will be set.
    uint       dwSupport;
}

struct AUXCAPS2A
{
align (1):
    ushort   wMid;
    ushort   wPid;
    uint     vDriverVersion;
    byte[32] szPname;
    ushort   wTechnology;
    ushort   wReserved1;
    uint     dwSupport;
    GUID     ManufacturerGuid;
    GUID     ProductGuid;
    GUID     NameGuid;
}

struct AUXCAPS2W
{
align (1):
    ushort     wMid;
    ushort     wPid;
    uint       vDriverVersion;
    ushort[32] szPname;
    ushort     wTechnology;
    ushort     wReserved1;
    uint       dwSupport;
    GUID       ManufacturerGuid;
    GUID       ProductGuid;
    GUID       NameGuid;
}

///The <b>MIXERCAPS</b> structure describes the capabilities of a mixer device.
struct MIXERCAPSA
{
align (1):
    ///A manufacturer identifier for the mixer device driver. Manufacturer identifiers are defined in Manufacturer and
    ///Product Identifiers.
    ushort   wMid;
    ///A product identifier for the mixer device driver. Product identifiers are defined in Manufacturer and Product
    ///Identifiers.
    ushort   wPid;
    ///Version number of the mixer device driver. The high-order byte is the major version number, and the low-order
    ///byte is the minor version number.
    uint     vDriverVersion;
    ///Name of the product. If the mixer device driver supports multiple cards, this string must uniquely and easily
    ///identify (potentially to a user) the specific card.
    byte[32] szPname;
    ///Various support information for the mixer device driver. No extended support bits are currently defined.
    uint     fdwSupport;
    ///The number of audio line destinations available through the mixer device. All mixer devices must support at least
    ///one destination line, so this member cannot be zero. Destination indexes used in the <b>dwDestination</b> member
    ///of the MIXERLINE structure range from zero to the value specified in the <b>cDestinations</b> member minus one.
    uint     cDestinations;
}

///The <b>MIXERCAPS</b> structure describes the capabilities of a mixer device.
struct MIXERCAPSW
{
align (1):
    ///A manufacturer identifier for the mixer device driver. Manufacturer identifiers are defined in Manufacturer and
    ///Product Identifiers.
    ushort     wMid;
    ///A product identifier for the mixer device driver. Product identifiers are defined in Manufacturer and Product
    ///Identifiers.
    ushort     wPid;
    ///Version number of the mixer device driver. The high-order byte is the major version number, and the low-order
    ///byte is the minor version number.
    uint       vDriverVersion;
    ///Name of the product. If the mixer device driver supports multiple cards, this string must uniquely and easily
    ///identify (potentially to a user) the specific card.
    ushort[32] szPname;
    ///Various support information for the mixer device driver. No extended support bits are currently defined.
    uint       fdwSupport;
    ///The number of audio line destinations available through the mixer device. All mixer devices must support at least
    ///one destination line, so this member cannot be zero. Destination indexes used in the <b>dwDestination</b> member
    ///of the MIXERLINE structure range from zero to the value specified in the <b>cDestinations</b> member minus one.
    uint       cDestinations;
}

struct MIXERCAPS2A
{
align (1):
    ushort   wMid;
    ushort   wPid;
    uint     vDriverVersion;
    byte[32] szPname;
    uint     fdwSupport;
    uint     cDestinations;
    GUID     ManufacturerGuid;
    GUID     ProductGuid;
    GUID     NameGuid;
}

struct MIXERCAPS2W
{
align (1):
    ushort     wMid;
    ushort     wPid;
    uint       vDriverVersion;
    ushort[32] szPname;
    uint       fdwSupport;
    uint       cDestinations;
    GUID       ManufacturerGuid;
    GUID       ProductGuid;
    GUID       NameGuid;
}

///The <b>MIXERLINE</b> structure describes the state and metrics of an audio line.
struct MIXERLINEA
{
align (1):
    ///Size, in bytes, of the <b>MIXERLINE</b> structure. This member must be initialized before calling the
    ///mixerGetLineInfo function. The size specified in this member must be large enough to contain the <b>MIXERLINE</b>
    ///structure. When <b>mixerGetLineInfo</b> returns, this member contains the actual size of the information
    ///returned. The returned information will not exceed the requested size.
    uint     cbStruct;
    ///Destination line index. This member ranges from zero to one less than the value specified in the
    ///<b>cDestinations</b> member of the MIXERCAPS structure retrieved by the mixerGetDevCaps function. When the
    ///mixerGetLineInfo function is called with the MIXER_GETLINEINFOF_DESTINATION flag, properties for the destination
    ///line are returned. (The <b>dwSource</b> member must be set to zero in this case.) When called with the
    ///MIXER_GETLINEINFOF_SOURCE flag, the properties for the source given by the <b>dwSource</b> member that is
    ///associated with the <b>dwDestination</b> member are returned.
    uint     dwDestination;
    ///Index for the audio source line associated with the <b>dwDestination</b> member. That is, this member specifies
    ///the <i>n</i>th audio source line associated with the specified audio destination line. This member is not used
    ///for destination lines and must be set to zero when MIXER_GETLINEINFOF_DESTINATION is specified in the
    ///mixerGetLineInfo function. When the MIXER_GETLINEINFOF_SOURCE flag is specified, this member ranges from zero to
    ///one less than the value specified in the <b>cConnections</b> member for the audio destination line given in the
    ///<b>dwDestination</b> member.
    uint     dwSource;
    ///An identifier defined by the mixer device that uniquely refers to the audio line described by the
    ///<b>MIXERLINE</b> structure. This identifier is unique for each mixer device and can be in any format. An
    ///application should use this identifier only as an abstract handle.
    uint     dwLineID;
    ///Status and support flags for the audio line. This member is always returned to the application and requires no
    ///initialization. <table> <tr> <th>Name</th> <th>Description</th> </tr> <tr> <td width="40%"><a
    ///id="MIXERLINE_LINEF_ACTIVE"></a><a id="mixerline_linef_active"></a><dl> <dt><b>MIXERLINE_LINEF_ACTIVE</b></dt>
    ///</dl> </td> <td width="60%"> Audio line is active. An active line indicates that a signal is probably passing
    ///through the line. </td> </tr> <tr> <td width="40%"><a id="MIXERLINE_LINEF_DISCONNECTED"></a><a
    ///id="mixerline_linef_disconnected"></a><dl> <dt><b>MIXERLINE_LINEF_DISCONNECTED</b></dt> </dl> </td> <td
    ///width="60%"> Audio line is disconnected. A disconnected line's associated controls can still be modified, but the
    ///changes have no effect until the line is connected. </td> </tr> <tr> <td width="40%"><a
    ///id="MIXERLINE_LINEF_SOURCE"></a><a id="mixerline_linef_source"></a><dl> <dt><b>MIXERLINE_LINEF_SOURCE</b></dt>
    ///</dl> </td> <td width="60%"> Audio line is an audio source line associated with a single audio destination line.
    ///If this flag is not set, this line is an audio destination line associated with zero or more audio source lines.
    ///</td> </tr> </table> If an application is not using a waveform-audio output device, the audio line associated
    ///with that device would not be active (that is, the MIXERLINE_LINEF_ACTIVE flag would not be set). If the
    ///waveform-audio output device is opened, then the audio line is considered active and the MIXERLINE_LINEF_ACTIVE
    ///flag will be set. A paused or starved waveform-audio output device is still considered active. In other words, if
    ///the waveform-audio output device is opened by an application regardless of whether data is being played, the
    ///associated audio line is considered active. If a line cannot be strictly defined as active, the mixer device will
    ///always set the MIXERLINE_LINEF_ACTIVE flag.
    uint     fdwLine;
    ///Instance data defined by the audio device for the line. This member is intended for custom mixer applications
    ///designed specifically for the mixer device returning this information. Other applications should ignore this
    ///data.
    size_t   dwUser;
    ///Component type for this audio line. An application can use this information to display tailored graphics or to
    ///search for a particular component. If an application does not use component types, this member should be ignored.
    ///This member can be one of the following values: <table> <tr> <th>Name</th> <th>Description</th> </tr> <tr> <td
    ///width="40%"><a id="MIXERLINE_COMPONENTTYPE_DST_DIGITAL"></a><a id="mixerline_componenttype_dst_digital"></a><dl>
    ///<dt><b>MIXERLINE_COMPONENTTYPE_DST_DIGITAL</b></dt> </dl> </td> <td width="60%"> Audio line is a digital
    ///destination (for example, digital input to a DAT or CD audio device). </td> </tr> <tr> <td width="40%"><a
    ///id="MIXERLINE_COMPONENTTYPE_DST_HEADPHONES"></a><a id="mixerline_componenttype_dst_headphones"></a><dl>
    ///<dt><b>MIXERLINE_COMPONENTTYPE_DST_HEADPHONES</b></dt> </dl> </td> <td width="60%"> Audio line is an adjustable
    ///(gain and/or attenuation) destination intended to drive headphones. Most audio cards use the same audio
    ///destination line for speakers and headphones, in which case the mixer device simply uses the
    ///MIXERLINE_COMPONENTTYPE_DST_SPEAKERS type. </td> </tr> <tr> <td width="40%"><a
    ///id="MIXERLINE_COMPONENTTYPE_DST_LINE"></a><a id="mixerline_componenttype_dst_line"></a><dl>
    ///<dt><b>MIXERLINE_COMPONENTTYPE_DST_LINE</b></dt> </dl> </td> <td width="60%"> Audio line is a line level
    ///destination (for example, line level input from a CD audio device) that will be the final recording source for
    ///the analog-to-digital converter (ADC). Because most audio cards for personal computers provide some sort of gain
    ///for the recording audio source line, the mixer device will use the MIXERLINE_COMPONENTTYPE_DST_WAVEIN type. </td>
    ///</tr> <tr> <td width="40%"><a id="MIXERLINE_COMPONENTTYPE_DST_MONITOR"></a><a
    ///id="mixerline_componenttype_dst_monitor"></a><dl> <dt><b>MIXERLINE_COMPONENTTYPE_DST_MONITOR</b></dt> </dl> </td>
    ///<td width="60%"> Audio line is a destination used for a monitor. </td> </tr> <tr> <td width="40%"><a
    ///id="MIXERLINE_COMPONENTTYPE_DST_SPEAKERS"></a><a id="mixerline_componenttype_dst_speakers"></a><dl>
    ///<dt><b>MIXERLINE_COMPONENTTYPE_DST_SPEAKERS</b></dt> </dl> </td> <td width="60%"> Audio line is an adjustable
    ///(gain and/or attenuation) destination intended to drive speakers. This is the typical component type for the
    ///audio output of audio cards for personal computers. </td> </tr> <tr> <td width="40%"><a
    ///id="MIXERLINE_COMPONENTTYPE_DST_TELEPHONE"></a><a id="mixerline_componenttype_dst_telephone"></a><dl>
    ///<dt><b>MIXERLINE_COMPONENTTYPE_DST_TELEPHONE</b></dt> </dl> </td> <td width="60%"> Audio line is a destination
    ///that will be routed to a telephone line. </td> </tr> <tr> <td width="40%"><a
    ///id="MIXERLINE_COMPONENTTYPE_DST_UNDEFINED"></a><a id="mixerline_componenttype_dst_undefined"></a><dl>
    ///<dt><b>MIXERLINE_COMPONENTTYPE_DST_UNDEFINED</b></dt> </dl> </td> <td width="60%"> Audio line is a destination
    ///that cannot be defined by one of the standard component types. A mixer device is required to use this component
    ///type for line component types that have not been defined by Microsoft Corporation. </td> </tr> <tr> <td
    ///width="40%"><a id="MIXERLINE_COMPONENTTYPE_DST_VOICEIN"></a><a id="mixerline_componenttype_dst_voicein"></a><dl>
    ///<dt><b>MIXERLINE_COMPONENTTYPE_DST_VOICEIN</b></dt> </dl> </td> <td width="60%"> Audio line is a destination that
    ///will be the final recording source for voice input. This component type is exactly like
    ///MIXERLINE_COMPONENTTYPE_DST_WAVEIN but is intended specifically for settings used during voice
    ///recording/recognition. Support for this line is optional for a mixer device. Many mixer devices provide only
    ///MIXERLINE_COMPONENTTYPE_DST_WAVEIN. </td> </tr> <tr> <td width="40%"><a
    ///id="MIXERLINE_COMPONENTTYPE_DST_WAVEIN"></a><a id="mixerline_componenttype_dst_wavein"></a><dl>
    ///<dt><b>MIXERLINE_COMPONENTTYPE_DST_WAVEIN</b></dt> </dl> </td> <td width="60%"> Audio line is a destination that
    ///will be the final recording source for the waveform-audio input (ADC). This line typically provides some sort of
    ///gain or attenuation. This is the typical component type for the recording line of most audio cards for personal
    ///computers. </td> </tr> <tr> <td width="40%"><a id="MIXERLINE_COMPONENTTYPE_SRC_ANALOG"></a><a
    ///id="mixerline_componenttype_src_analog"></a><dl> <dt><b>MIXERLINE_COMPONENTTYPE_SRC_ANALOG</b></dt> </dl> </td>
    ///<td width="60%"> Audio line is an analog source (for example, analog output from a video-cassette tape). </td>
    ///</tr> <tr> <td width="40%"><a id="MIXERLINE_COMPONENTTYPE_SRC_AUXILIARY"></a><a
    ///id="mixerline_componenttype_src_auxiliary"></a><dl> <dt><b>MIXERLINE_COMPONENTTYPE_SRC_AUXILIARY</b></dt> </dl>
    ///</td> <td width="60%"> Audio line is a source originating from the auxiliary audio line. This line type is
    ///intended as a source with gain or attenuation that can be routed to the MIXERLINE_COMPONENTTYPE_DST_SPEAKERS
    ///destination and/or recorded from the MIXERLINE_COMPONENTTYPE_DST_WAVEIN destination. </td> </tr> <tr> <td
    ///width="40%"><a id="MIXERLINE_COMPONENTTYPE_SRC_COMPACTDISC"></a><a
    ///id="mixerline_componenttype_src_compactdisc"></a><dl> <dt><b>MIXERLINE_COMPONENTTYPE_SRC_COMPACTDISC</b></dt>
    ///</dl> </td> <td width="60%"> Audio line is a source originating from the output of an internal audio CD. This
    ///component type is provided for audio cards that provide an audio source line intended to be connected to an audio
    ///CD (or CD-ROM playing an audio CD). </td> </tr> <tr> <td width="40%"><a
    ///id="MIXERLINE_COMPONENTTYPE_SRC_DIGITAL"></a><a id="mixerline_componenttype_src_digital"></a><dl>
    ///<dt><b>MIXERLINE_COMPONENTTYPE_SRC_DIGITAL</b></dt> </dl> </td> <td width="60%"> Audio line is a digital source
    ///(for example, digital output from a DAT or audio CD). </td> </tr> <tr> <td width="40%"><a
    ///id="MIXERLINE_COMPONENTTYPE_SRC_LINE"></a><a id="mixerline_componenttype_src_line"></a><dl>
    ///<dt><b>MIXERLINE_COMPONENTTYPE_SRC_LINE</b></dt> </dl> </td> <td width="60%"> Audio line is a line-level source
    ///(for example, line-level input from an external stereo) that can be used as an optional recording source. Because
    ///most audio cards for personal computers provide some sort of gain for the recording source line, the mixer device
    ///will use the MIXERLINE_COMPONENTTYPE_SRC_AUXILIARY type. </td> </tr> <tr> <td width="40%"><a
    ///id="MIXERLINE_COMPONENTTYPE_SRC_MICROPHONE"></a><a id="mixerline_componenttype_src_microphone"></a><dl>
    ///<dt><b>MIXERLINE_COMPONENTTYPE_SRC_MICROPHONE</b></dt> </dl> </td> <td width="60%"> Audio line is a microphone
    ///recording source. Most audio cards for personal computers provide at least two types of recording sources: an
    ///auxiliary audio line and microphone input. A microphone audio line typically provides some sort of gain. Audio
    ///cards that use a single input for use with a microphone or auxiliary audio line should use the
    ///MIXERLINE_COMPONENTTYPE_SRC_MICROPHONE component type. </td> </tr> <tr> <td width="40%"><a
    ///id="MIXERLINE_COMPONENTTYPE_SRC_PCSPEAKER"></a><a id="mixerline_componenttype_src_pcspeaker"></a><dl>
    ///<dt><b>MIXERLINE_COMPONENTTYPE_SRC_PCSPEAKER</b></dt> </dl> </td> <td width="60%"> Audio line is a source
    ///originating from personal computer speaker. Several audio cards for personal computers provide the ability to mix
    ///what would typically be played on the internal speaker with the output of an audio card. Some audio cards support
    ///the ability to use this output as a recording source. </td> </tr> <tr> <td width="40%"><a
    ///id="MIXERLINE_COMPONENTTYPE_SRC_SYNTHESIZER"></a><a id="mixerline_componenttype_src_synthesizer"></a><dl>
    ///<dt><b>MIXERLINE_COMPONENTTYPE_SRC_SYNTHESIZER</b></dt> </dl> </td> <td width="60%"> Audio line is a source
    ///originating from the output of an internal synthesizer. Most audio cards for personal computers provide some sort
    ///of MIDI synthesizer. </td> </tr> <tr> <td width="40%"><a id="MIXERLINE_COMPONENTTYPE_SRC_TELEPHONE"></a><a
    ///id="mixerline_componenttype_src_telephone"></a><dl> <dt><b>MIXERLINE_COMPONENTTYPE_SRC_TELEPHONE</b></dt> </dl>
    ///</td> <td width="60%"> Audio line is a source originating from an incoming telephone line. </td> </tr> <tr> <td
    ///width="40%"><a id="MIXERLINE_COMPONENTTYPE_SRC_UNDEFINED"></a><a
    ///id="mixerline_componenttype_src_undefined"></a><dl> <dt><b>MIXERLINE_COMPONENTTYPE_SRC_UNDEFINED</b></dt> </dl>
    ///</td> <td width="60%"> Audio line is a source that cannot be defined by one of the standard component types. A
    ///mixer device is required to use this component type for line component types that have not been defined by
    ///Microsoft Corporation. </td> </tr> <tr> <td width="40%"><a id="MIXERLINE_COMPONENTTYPE_SRC_WAVEOUT"></a><a
    ///id="mixerline_componenttype_src_waveout"></a><dl> <dt><b>MIXERLINE_COMPONENTTYPE_SRC_WAVEOUT</b></dt> </dl> </td>
    ///<td width="60%"> Audio line is a source originating from the waveform-audio output digital-to-analog converter
    ///(DAC). Most audio cards for personal computers provide this component type as a source to the
    ///MIXERLINE_COMPONENTTYPE_DST_SPEAKERS destination. Some cards also allow this source to be routed to the
    ///MIXERLINE_COMPONENTTYPE_DST_WAVEIN destination. </td> </tr> </table>
    uint     dwComponentType;
    ///Maximum number of separate channels that can be manipulated independently for the audio line. The minimum value
    ///for this field is 1 because a line must have at least one channel. Most modern audio cards for personal computers
    ///are stereo devices; for them, the value of this member is 2. Channel 1 is assumed to be the left channel; channel
    ///2 is assumed to be the right channel. A multichannel line might have one or more uniform controls (controls that
    ///affect all channels of a line uniformly) associated with it.
    uint     cChannels;
    ///Number of connections that are associated with the audio line. This member is used only for audio destination
    ///lines and specifies the number of audio source lines that are associated with it. This member is always zero for
    ///source lines and for destination lines that do not have any audio source lines associated with them.
    uint     cConnections;
    ///Number of controls associated with the audio line. This value can be zero. If no controls are associated with the
    ///line, the line is likely to be a source that might be selected in a MIXERCONTROL_CONTROLTYPE_MUX or
    ///MIXERCONTROL_CONTROLTYPE_MIXER but allows no manipulation of the signal.
    uint     cControls;
    ///Short string that describes the audio mixer line specified in the <b>dwLineID</b> member. This description should
    ///be appropriate as a concise label for the line.
    byte[16] szShortName;
    ///String that describes the audio mixer line specified in the <b>dwLineID</b> member. This description should be
    ///appropriate as a complete description for the line.
    byte[64] szName;
struct Target
    {
    align (1):
        uint     dwType;
        uint     dwDeviceID;
        ushort   wMid;
        ushort   wPid;
        uint     vDriverVersion;
        byte[32] szPname;
    }
}

///The <b>MIXERLINE</b> structure describes the state and metrics of an audio line.
struct MIXERLINEW
{
align (1):
    ///Size, in bytes, of the <b>MIXERLINE</b> structure. This member must be initialized before calling the
    ///mixerGetLineInfo function. The size specified in this member must be large enough to contain the <b>MIXERLINE</b>
    ///structure. When <b>mixerGetLineInfo</b> returns, this member contains the actual size of the information
    ///returned. The returned information will not exceed the requested size.
    uint       cbStruct;
    ///Destination line index. This member ranges from zero to one less than the value specified in the
    ///<b>cDestinations</b> member of the MIXERCAPS structure retrieved by the mixerGetDevCaps function. When the
    ///mixerGetLineInfo function is called with the MIXER_GETLINEINFOF_DESTINATION flag, properties for the destination
    ///line are returned. (The <b>dwSource</b> member must be set to zero in this case.) When called with the
    ///MIXER_GETLINEINFOF_SOURCE flag, the properties for the source given by the <b>dwSource</b> member that is
    ///associated with the <b>dwDestination</b> member are returned.
    uint       dwDestination;
    ///Index for the audio source line associated with the <b>dwDestination</b> member. That is, this member specifies
    ///the <i>n</i>th audio source line associated with the specified audio destination line. This member is not used
    ///for destination lines and must be set to zero when MIXER_GETLINEINFOF_DESTINATION is specified in the
    ///mixerGetLineInfo function. When the MIXER_GETLINEINFOF_SOURCE flag is specified, this member ranges from zero to
    ///one less than the value specified in the <b>cConnections</b> member for the audio destination line given in the
    ///<b>dwDestination</b> member.
    uint       dwSource;
    ///An identifier defined by the mixer device that uniquely refers to the audio line described by the
    ///<b>MIXERLINE</b> structure. This identifier is unique for each mixer device and can be in any format. An
    ///application should use this identifier only as an abstract handle.
    uint       dwLineID;
    ///Status and support flags for the audio line. This member is always returned to the application and requires no
    ///initialization. <table> <tr> <th>Name</th> <th>Description</th> </tr> <tr> <td width="40%"><a
    ///id="MIXERLINE_LINEF_ACTIVE"></a><a id="mixerline_linef_active"></a><dl> <dt><b>MIXERLINE_LINEF_ACTIVE</b></dt>
    ///</dl> </td> <td width="60%"> Audio line is active. An active line indicates that a signal is probably passing
    ///through the line. </td> </tr> <tr> <td width="40%"><a id="MIXERLINE_LINEF_DISCONNECTED"></a><a
    ///id="mixerline_linef_disconnected"></a><dl> <dt><b>MIXERLINE_LINEF_DISCONNECTED</b></dt> </dl> </td> <td
    ///width="60%"> Audio line is disconnected. A disconnected line's associated controls can still be modified, but the
    ///changes have no effect until the line is connected. </td> </tr> <tr> <td width="40%"><a
    ///id="MIXERLINE_LINEF_SOURCE"></a><a id="mixerline_linef_source"></a><dl> <dt><b>MIXERLINE_LINEF_SOURCE</b></dt>
    ///</dl> </td> <td width="60%"> Audio line is an audio source line associated with a single audio destination line.
    ///If this flag is not set, this line is an audio destination line associated with zero or more audio source lines.
    ///</td> </tr> </table> If an application is not using a waveform-audio output device, the audio line associated
    ///with that device would not be active (that is, the MIXERLINE_LINEF_ACTIVE flag would not be set). If the
    ///waveform-audio output device is opened, then the audio line is considered active and the MIXERLINE_LINEF_ACTIVE
    ///flag will be set. A paused or starved waveform-audio output device is still considered active. In other words, if
    ///the waveform-audio output device is opened by an application regardless of whether data is being played, the
    ///associated audio line is considered active. If a line cannot be strictly defined as active, the mixer device will
    ///always set the MIXERLINE_LINEF_ACTIVE flag.
    uint       fdwLine;
    ///Instance data defined by the audio device for the line. This member is intended for custom mixer applications
    ///designed specifically for the mixer device returning this information. Other applications should ignore this
    ///data.
    size_t     dwUser;
    ///Component type for this audio line. An application can use this information to display tailored graphics or to
    ///search for a particular component. If an application does not use component types, this member should be ignored.
    ///This member can be one of the following values: <table> <tr> <th>Name</th> <th>Description</th> </tr> <tr> <td
    ///width="40%"><a id="MIXERLINE_COMPONENTTYPE_DST_DIGITAL"></a><a id="mixerline_componenttype_dst_digital"></a><dl>
    ///<dt><b>MIXERLINE_COMPONENTTYPE_DST_DIGITAL</b></dt> </dl> </td> <td width="60%"> Audio line is a digital
    ///destination (for example, digital input to a DAT or CD audio device). </td> </tr> <tr> <td width="40%"><a
    ///id="MIXERLINE_COMPONENTTYPE_DST_HEADPHONES"></a><a id="mixerline_componenttype_dst_headphones"></a><dl>
    ///<dt><b>MIXERLINE_COMPONENTTYPE_DST_HEADPHONES</b></dt> </dl> </td> <td width="60%"> Audio line is an adjustable
    ///(gain and/or attenuation) destination intended to drive headphones. Most audio cards use the same audio
    ///destination line for speakers and headphones, in which case the mixer device simply uses the
    ///MIXERLINE_COMPONENTTYPE_DST_SPEAKERS type. </td> </tr> <tr> <td width="40%"><a
    ///id="MIXERLINE_COMPONENTTYPE_DST_LINE"></a><a id="mixerline_componenttype_dst_line"></a><dl>
    ///<dt><b>MIXERLINE_COMPONENTTYPE_DST_LINE</b></dt> </dl> </td> <td width="60%"> Audio line is a line level
    ///destination (for example, line level input from a CD audio device) that will be the final recording source for
    ///the analog-to-digital converter (ADC). Because most audio cards for personal computers provide some sort of gain
    ///for the recording audio source line, the mixer device will use the MIXERLINE_COMPONENTTYPE_DST_WAVEIN type. </td>
    ///</tr> <tr> <td width="40%"><a id="MIXERLINE_COMPONENTTYPE_DST_MONITOR"></a><a
    ///id="mixerline_componenttype_dst_monitor"></a><dl> <dt><b>MIXERLINE_COMPONENTTYPE_DST_MONITOR</b></dt> </dl> </td>
    ///<td width="60%"> Audio line is a destination used for a monitor. </td> </tr> <tr> <td width="40%"><a
    ///id="MIXERLINE_COMPONENTTYPE_DST_SPEAKERS"></a><a id="mixerline_componenttype_dst_speakers"></a><dl>
    ///<dt><b>MIXERLINE_COMPONENTTYPE_DST_SPEAKERS</b></dt> </dl> </td> <td width="60%"> Audio line is an adjustable
    ///(gain and/or attenuation) destination intended to drive speakers. This is the typical component type for the
    ///audio output of audio cards for personal computers. </td> </tr> <tr> <td width="40%"><a
    ///id="MIXERLINE_COMPONENTTYPE_DST_TELEPHONE"></a><a id="mixerline_componenttype_dst_telephone"></a><dl>
    ///<dt><b>MIXERLINE_COMPONENTTYPE_DST_TELEPHONE</b></dt> </dl> </td> <td width="60%"> Audio line is a destination
    ///that will be routed to a telephone line. </td> </tr> <tr> <td width="40%"><a
    ///id="MIXERLINE_COMPONENTTYPE_DST_UNDEFINED"></a><a id="mixerline_componenttype_dst_undefined"></a><dl>
    ///<dt><b>MIXERLINE_COMPONENTTYPE_DST_UNDEFINED</b></dt> </dl> </td> <td width="60%"> Audio line is a destination
    ///that cannot be defined by one of the standard component types. A mixer device is required to use this component
    ///type for line component types that have not been defined by Microsoft Corporation. </td> </tr> <tr> <td
    ///width="40%"><a id="MIXERLINE_COMPONENTTYPE_DST_VOICEIN"></a><a id="mixerline_componenttype_dst_voicein"></a><dl>
    ///<dt><b>MIXERLINE_COMPONENTTYPE_DST_VOICEIN</b></dt> </dl> </td> <td width="60%"> Audio line is a destination that
    ///will be the final recording source for voice input. This component type is exactly like
    ///MIXERLINE_COMPONENTTYPE_DST_WAVEIN but is intended specifically for settings used during voice
    ///recording/recognition. Support for this line is optional for a mixer device. Many mixer devices provide only
    ///MIXERLINE_COMPONENTTYPE_DST_WAVEIN. </td> </tr> <tr> <td width="40%"><a
    ///id="MIXERLINE_COMPONENTTYPE_DST_WAVEIN"></a><a id="mixerline_componenttype_dst_wavein"></a><dl>
    ///<dt><b>MIXERLINE_COMPONENTTYPE_DST_WAVEIN</b></dt> </dl> </td> <td width="60%"> Audio line is a destination that
    ///will be the final recording source for the waveform-audio input (ADC). This line typically provides some sort of
    ///gain or attenuation. This is the typical component type for the recording line of most audio cards for personal
    ///computers. </td> </tr> <tr> <td width="40%"><a id="MIXERLINE_COMPONENTTYPE_SRC_ANALOG"></a><a
    ///id="mixerline_componenttype_src_analog"></a><dl> <dt><b>MIXERLINE_COMPONENTTYPE_SRC_ANALOG</b></dt> </dl> </td>
    ///<td width="60%"> Audio line is an analog source (for example, analog output from a video-cassette tape). </td>
    ///</tr> <tr> <td width="40%"><a id="MIXERLINE_COMPONENTTYPE_SRC_AUXILIARY"></a><a
    ///id="mixerline_componenttype_src_auxiliary"></a><dl> <dt><b>MIXERLINE_COMPONENTTYPE_SRC_AUXILIARY</b></dt> </dl>
    ///</td> <td width="60%"> Audio line is a source originating from the auxiliary audio line. This line type is
    ///intended as a source with gain or attenuation that can be routed to the MIXERLINE_COMPONENTTYPE_DST_SPEAKERS
    ///destination and/or recorded from the MIXERLINE_COMPONENTTYPE_DST_WAVEIN destination. </td> </tr> <tr> <td
    ///width="40%"><a id="MIXERLINE_COMPONENTTYPE_SRC_COMPACTDISC"></a><a
    ///id="mixerline_componenttype_src_compactdisc"></a><dl> <dt><b>MIXERLINE_COMPONENTTYPE_SRC_COMPACTDISC</b></dt>
    ///</dl> </td> <td width="60%"> Audio line is a source originating from the output of an internal audio CD. This
    ///component type is provided for audio cards that provide an audio source line intended to be connected to an audio
    ///CD (or CD-ROM playing an audio CD). </td> </tr> <tr> <td width="40%"><a
    ///id="MIXERLINE_COMPONENTTYPE_SRC_DIGITAL"></a><a id="mixerline_componenttype_src_digital"></a><dl>
    ///<dt><b>MIXERLINE_COMPONENTTYPE_SRC_DIGITAL</b></dt> </dl> </td> <td width="60%"> Audio line is a digital source
    ///(for example, digital output from a DAT or audio CD). </td> </tr> <tr> <td width="40%"><a
    ///id="MIXERLINE_COMPONENTTYPE_SRC_LINE"></a><a id="mixerline_componenttype_src_line"></a><dl>
    ///<dt><b>MIXERLINE_COMPONENTTYPE_SRC_LINE</b></dt> </dl> </td> <td width="60%"> Audio line is a line-level source
    ///(for example, line-level input from an external stereo) that can be used as an optional recording source. Because
    ///most audio cards for personal computers provide some sort of gain for the recording source line, the mixer device
    ///will use the MIXERLINE_COMPONENTTYPE_SRC_AUXILIARY type. </td> </tr> <tr> <td width="40%"><a
    ///id="MIXERLINE_COMPONENTTYPE_SRC_MICROPHONE"></a><a id="mixerline_componenttype_src_microphone"></a><dl>
    ///<dt><b>MIXERLINE_COMPONENTTYPE_SRC_MICROPHONE</b></dt> </dl> </td> <td width="60%"> Audio line is a microphone
    ///recording source. Most audio cards for personal computers provide at least two types of recording sources: an
    ///auxiliary audio line and microphone input. A microphone audio line typically provides some sort of gain. Audio
    ///cards that use a single input for use with a microphone or auxiliary audio line should use the
    ///MIXERLINE_COMPONENTTYPE_SRC_MICROPHONE component type. </td> </tr> <tr> <td width="40%"><a
    ///id="MIXERLINE_COMPONENTTYPE_SRC_PCSPEAKER"></a><a id="mixerline_componenttype_src_pcspeaker"></a><dl>
    ///<dt><b>MIXERLINE_COMPONENTTYPE_SRC_PCSPEAKER</b></dt> </dl> </td> <td width="60%"> Audio line is a source
    ///originating from personal computer speaker. Several audio cards for personal computers provide the ability to mix
    ///what would typically be played on the internal speaker with the output of an audio card. Some audio cards support
    ///the ability to use this output as a recording source. </td> </tr> <tr> <td width="40%"><a
    ///id="MIXERLINE_COMPONENTTYPE_SRC_SYNTHESIZER"></a><a id="mixerline_componenttype_src_synthesizer"></a><dl>
    ///<dt><b>MIXERLINE_COMPONENTTYPE_SRC_SYNTHESIZER</b></dt> </dl> </td> <td width="60%"> Audio line is a source
    ///originating from the output of an internal synthesizer. Most audio cards for personal computers provide some sort
    ///of MIDI synthesizer. </td> </tr> <tr> <td width="40%"><a id="MIXERLINE_COMPONENTTYPE_SRC_TELEPHONE"></a><a
    ///id="mixerline_componenttype_src_telephone"></a><dl> <dt><b>MIXERLINE_COMPONENTTYPE_SRC_TELEPHONE</b></dt> </dl>
    ///</td> <td width="60%"> Audio line is a source originating from an incoming telephone line. </td> </tr> <tr> <td
    ///width="40%"><a id="MIXERLINE_COMPONENTTYPE_SRC_UNDEFINED"></a><a
    ///id="mixerline_componenttype_src_undefined"></a><dl> <dt><b>MIXERLINE_COMPONENTTYPE_SRC_UNDEFINED</b></dt> </dl>
    ///</td> <td width="60%"> Audio line is a source that cannot be defined by one of the standard component types. A
    ///mixer device is required to use this component type for line component types that have not been defined by
    ///Microsoft Corporation. </td> </tr> <tr> <td width="40%"><a id="MIXERLINE_COMPONENTTYPE_SRC_WAVEOUT"></a><a
    ///id="mixerline_componenttype_src_waveout"></a><dl> <dt><b>MIXERLINE_COMPONENTTYPE_SRC_WAVEOUT</b></dt> </dl> </td>
    ///<td width="60%"> Audio line is a source originating from the waveform-audio output digital-to-analog converter
    ///(DAC). Most audio cards for personal computers provide this component type as a source to the
    ///MIXERLINE_COMPONENTTYPE_DST_SPEAKERS destination. Some cards also allow this source to be routed to the
    ///MIXERLINE_COMPONENTTYPE_DST_WAVEIN destination. </td> </tr> </table>
    uint       dwComponentType;
    ///Maximum number of separate channels that can be manipulated independently for the audio line. The minimum value
    ///for this field is 1 because a line must have at least one channel. Most modern audio cards for personal computers
    ///are stereo devices; for them, the value of this member is 2. Channel 1 is assumed to be the left channel; channel
    ///2 is assumed to be the right channel. A multichannel line might have one or more uniform controls (controls that
    ///affect all channels of a line uniformly) associated with it.
    uint       cChannels;
    ///Number of connections that are associated with the audio line. This member is used only for audio destination
    ///lines and specifies the number of audio source lines that are associated with it. This member is always zero for
    ///source lines and for destination lines that do not have any audio source lines associated with them.
    uint       cConnections;
    ///Number of controls associated with the audio line. This value can be zero. If no controls are associated with the
    ///line, the line is likely to be a source that might be selected in a MIXERCONTROL_CONTROLTYPE_MUX or
    ///MIXERCONTROL_CONTROLTYPE_MIXER but allows no manipulation of the signal.
    uint       cControls;
    ///Short string that describes the audio mixer line specified in the <b>dwLineID</b> member. This description should
    ///be appropriate as a concise label for the line.
    ushort[16] szShortName;
    ///String that describes the audio mixer line specified in the <b>dwLineID</b> member. This description should be
    ///appropriate as a complete description for the line.
    ushort[64] szName;
struct Target
    {
    align (1):
        uint       dwType;
        uint       dwDeviceID;
        ushort     wMid;
        ushort     wPid;
        uint       vDriverVersion;
        ushort[32] szPname;
    }
}

///The <b>MIXERCONTROL</b> structure describes the state and metrics of a single control for an audio line.
struct MIXERCONTROLA
{
align (1):
    ///Size, in bytes, of the <b>MIXERCONTROL</b> structure.
    uint     cbStruct;
    ///Audio mixer-defined identifier that uniquely refers to the control described by the <b>MIXERCONTROL</b>
    ///structure. This identifier can be in any format supported by the mixer device. An application should use this
    ///identifier only as an abstract handle. No two controls for a single mixer device can ever have the same control
    ///identifier.
    uint     dwControlID;
    ///Class of the control for which the identifier is specified in <b>dwControlID</b>. An application must use this
    ///information to display the appropriate control for input from the user. An application can also display tailored
    ///graphics based on the control class or search for a particular control class on a specific line. If an
    ///application does not know about a control class, this control must be ignored. There are eight control class
    ///classifications, each with one or more standard control types: <table> <tr> <th>Name</th> <th>Descriptions</th>
    ///</tr> <tr> <td width="40%"><a id="MIXERCONTROL_CT_CLASS_CUSTOM"></a><a id="mixercontrol_ct_class_custom"></a><dl>
    ///<dt><b>MIXERCONTROL_CT_CLASS_CUSTOM</b></dt> </dl> </td> <td width="60%"> MIXERCONTROL_CONTROLTYPE_CUSTOM </td>
    ///</tr> <tr> <td width="40%"><a id="MIXERCONTROL_CT_CLASS_FADER"></a><a id="mixercontrol_ct_class_fader"></a><dl>
    ///<dt><b>MIXERCONTROL_CT_CLASS_FADER</b></dt> </dl> </td> <td width="60%"> MIXERCONTROL_CONTROLTYPE_BASS
    ///MIXERCONTROL_CONTROLTYPE_EQUALIZER MIXERCONTROL_CONTROLTYPE_FADER MIXERCONTROL_CONTROLTYPE_TREBLE
    ///MIXERCONTROL_CONTROLTYPE_VOLUME </td> </tr> <tr> <td width="40%"><a id="MIXERCONTROL_CT_CLASS_LIST"></a><a
    ///id="mixercontrol_ct_class_list"></a><dl> <dt><b>MIXERCONTROL_CT_CLASS_LIST</b></dt> </dl> </td> <td width="60%">
    ///MIXERCONTROL_CONTROLTYPE_MIXER MIXERCONTROL_CONTROLTYPE_MULTIPLESELECT MIXERCONTROL_CONTROLTYPE_MUX
    ///MIXERCONTROL_CONTROLTYPE_SINGLESELECT </td> </tr> <tr> <td width="40%"><a id="MIXERCONTROL_CT_CLASS_METER"></a><a
    ///id="mixercontrol_ct_class_meter"></a><dl> <dt><b>MIXERCONTROL_CT_CLASS_METER</b></dt> </dl> </td> <td
    ///width="60%"> MIXERCONTROL_CONTROLTYPE_BOOLEANMETER MIXERCONTROL_CONTROLTYPE_PEAKMETER
    ///MIXERCONTROL_CONTROLTYPE_SIGNEDMETER MIXERCONTROL_CONTROLTYPE_UNSIGNEDMETER </td> </tr> <tr> <td width="40%"><a
    ///id="MIXERCONTROL_CT_CLASS_NUMBER"></a><a id="mixercontrol_ct_class_number"></a><dl>
    ///<dt><b>MIXERCONTROL_CT_CLASS_NUMBER</b></dt> </dl> </td> <td width="60%"> MIXERCONTROL_CONTROLTYPE_DECIBELS
    ///MIXERCONTROL_CONTROLTYPE_PERCENT MIXERCONTROL_CONTROLTYPE_SIGNED MIXERCONTROL_CONTROLTYPE_UNSIGNED </td> </tr>
    ///<tr> <td width="40%"><a id="MIXERCONTROL_CT_CLASS_SLIDER"></a><a id="mixercontrol_ct_class_slider"></a><dl>
    ///<dt><b>MIXERCONTROL_CT_CLASS_SLIDER</b></dt> </dl> </td> <td width="60%"> MIXERCONTROL_CONTROLTYPE_PAN
    ///MIXERCONTROL_CONTROLTYPE_QSOUNDPAN MIXERCONTROL_CONTROLTYPE_SLIDER </td> </tr> <tr> <td width="40%"><a
    ///id="MIXERCONTROL_CT_CLASS_SWITCH"></a><a id="mixercontrol_ct_class_switch"></a><dl>
    ///<dt><b>MIXERCONTROL_CT_CLASS_SWITCH</b></dt> </dl> </td> <td width="60%"> MIXERCONTROL_CONTROLTYPE_BOOLEAN
    ///MIXERCONTROL_CONTROLTYPE_BUTTON MIXERCONTROL_CONTROLTYPE_LOUDNESS MIXERCONTROL_CONTROLTYPE_MONO
    ///MIXERCONTROL_CONTROLTYPE_MUTE MIXERCONTROL_CONTROLTYPE_ONOFF MIXERCONTROL_CONTROLTYPE_STEREOENH </td> </tr> <tr>
    ///<td width="40%"><a id="MIXERCONTROL_CT_CLASS_TIME"></a><a id="mixercontrol_ct_class_time"></a><dl>
    ///<dt><b>MIXERCONTROL_CT_CLASS_TIME</b></dt> </dl> </td> <td width="60%"> MIXERCONTROL_CONTROLTYPE_MICROTIME
    ///MIXERCONTROL_CONTROLTYPE_MILLITIME </td> </tr> </table>
    uint     dwControlType;
    ///Status and support flags for the audio line control. The following values are defined: <table> <tr> <th>Name</th>
    ///<th>Description</th> </tr> <tr> <td width="40%"><a id="MIXERCONTROL_CONTROLF_DISABLED"></a><a
    ///id="mixercontrol_controlf_disabled"></a><dl> <dt><b>MIXERCONTROL_CONTROLF_DISABLED</b></dt> </dl> </td> <td
    ///width="60%"> The control is disabled, perhaps due to other settings for the mixer hardware, and cannot be used.
    ///An application can read current settings from a disabled control, but it cannot apply settings. </td> </tr> <tr>
    ///<td width="40%"><a id="MIXERCONTROL_CONTROLF_MULTIPLE"></a><a id="mixercontrol_controlf_multiple"></a><dl>
    ///<dt><b>MIXERCONTROL_CONTROLF_MULTIPLE</b></dt> </dl> </td> <td width="60%"> The control has two or more settings
    ///per channel. An equalizer, for example, requires this flag because each frequency band can be set to a different
    ///value. An equalizer that affects both channels of a stereo line in a uniform fashion will also specify the
    ///MIXERCONTROL_CONTROLF_UNIFORM flag. </td> </tr> <tr> <td width="40%"><a id="MIXERCONTROL_CONTROLF_UNIFORM"></a><a
    ///id="mixercontrol_controlf_uniform"></a><dl> <dt><b>MIXERCONTROL_CONTROLF_UNIFORM</b></dt> </dl> </td> <td
    ///width="60%"> The control acts on all channels of a multichannel line in a uniform fashion. For example, a control
    ///that mutes both channels of a stereo line would set this flag. Most MIXERCONTROL_CONTROLTYPE_MUX and
    ///MIXERCONTROL_CONTROLTYPE_MIXER controls also specify the MIXERCONTROL_CONTROLF_UNIFORM flag. </td> </tr> </table>
    uint     fdwControl;
    ///Number of items per channel that make up a MIXERCONTROL_CONTROLF_MULTIPLE control. This number is always two or
    ///greater for multiple-item controls. If the control is not a multiple-item control, do not use this member; it
    ///will be zero.
    uint     cMultipleItems;
    ///Short string that describes the audio line control specified by <b>dwControlID</b>. This description should be
    ///appropriate to use as a concise label for the control.
    byte[16] szShortName;
    ///String that describes the audio line control specified by <b>dwControlID</b>. This description should be
    ///appropriate to use as a complete description for the control.
    byte[64] szName;
union Bounds
    {
    align (1):
struct
        {
        align (1):
            int lMinimum;
            int lMaximum;
        }
struct
        {
        align (1):
            uint dwMinimum;
            uint dwMaximum;
        }
        uint[6] dwReserved;
    }
union Metrics
    {
    align (1):
        uint    cSteps;
        uint    cbCustomData;
        uint[6] dwReserved;
    }
}

///The <b>MIXERCONTROL</b> structure describes the state and metrics of a single control for an audio line.
struct MIXERCONTROLW
{
align (1):
    ///Size, in bytes, of the <b>MIXERCONTROL</b> structure.
    uint       cbStruct;
    ///Audio mixer-defined identifier that uniquely refers to the control described by the <b>MIXERCONTROL</b>
    ///structure. This identifier can be in any format supported by the mixer device. An application should use this
    ///identifier only as an abstract handle. No two controls for a single mixer device can ever have the same control
    ///identifier.
    uint       dwControlID;
    ///Class of the control for which the identifier is specified in <b>dwControlID</b>. An application must use this
    ///information to display the appropriate control for input from the user. An application can also display tailored
    ///graphics based on the control class or search for a particular control class on a specific line. If an
    ///application does not know about a control class, this control must be ignored. There are eight control class
    ///classifications, each with one or more standard control types: <table> <tr> <th>Name</th> <th>Descriptions</th>
    ///</tr> <tr> <td width="40%"><a id="MIXERCONTROL_CT_CLASS_CUSTOM"></a><a id="mixercontrol_ct_class_custom"></a><dl>
    ///<dt><b>MIXERCONTROL_CT_CLASS_CUSTOM</b></dt> </dl> </td> <td width="60%"> MIXERCONTROL_CONTROLTYPE_CUSTOM </td>
    ///</tr> <tr> <td width="40%"><a id="MIXERCONTROL_CT_CLASS_FADER"></a><a id="mixercontrol_ct_class_fader"></a><dl>
    ///<dt><b>MIXERCONTROL_CT_CLASS_FADER</b></dt> </dl> </td> <td width="60%"> MIXERCONTROL_CONTROLTYPE_BASS
    ///MIXERCONTROL_CONTROLTYPE_EQUALIZER MIXERCONTROL_CONTROLTYPE_FADER MIXERCONTROL_CONTROLTYPE_TREBLE
    ///MIXERCONTROL_CONTROLTYPE_VOLUME </td> </tr> <tr> <td width="40%"><a id="MIXERCONTROL_CT_CLASS_LIST"></a><a
    ///id="mixercontrol_ct_class_list"></a><dl> <dt><b>MIXERCONTROL_CT_CLASS_LIST</b></dt> </dl> </td> <td width="60%">
    ///MIXERCONTROL_CONTROLTYPE_MIXER MIXERCONTROL_CONTROLTYPE_MULTIPLESELECT MIXERCONTROL_CONTROLTYPE_MUX
    ///MIXERCONTROL_CONTROLTYPE_SINGLESELECT </td> </tr> <tr> <td width="40%"><a id="MIXERCONTROL_CT_CLASS_METER"></a><a
    ///id="mixercontrol_ct_class_meter"></a><dl> <dt><b>MIXERCONTROL_CT_CLASS_METER</b></dt> </dl> </td> <td
    ///width="60%"> MIXERCONTROL_CONTROLTYPE_BOOLEANMETER MIXERCONTROL_CONTROLTYPE_PEAKMETER
    ///MIXERCONTROL_CONTROLTYPE_SIGNEDMETER MIXERCONTROL_CONTROLTYPE_UNSIGNEDMETER </td> </tr> <tr> <td width="40%"><a
    ///id="MIXERCONTROL_CT_CLASS_NUMBER"></a><a id="mixercontrol_ct_class_number"></a><dl>
    ///<dt><b>MIXERCONTROL_CT_CLASS_NUMBER</b></dt> </dl> </td> <td width="60%"> MIXERCONTROL_CONTROLTYPE_DECIBELS
    ///MIXERCONTROL_CONTROLTYPE_PERCENT MIXERCONTROL_CONTROLTYPE_SIGNED MIXERCONTROL_CONTROLTYPE_UNSIGNED </td> </tr>
    ///<tr> <td width="40%"><a id="MIXERCONTROL_CT_CLASS_SLIDER"></a><a id="mixercontrol_ct_class_slider"></a><dl>
    ///<dt><b>MIXERCONTROL_CT_CLASS_SLIDER</b></dt> </dl> </td> <td width="60%"> MIXERCONTROL_CONTROLTYPE_PAN
    ///MIXERCONTROL_CONTROLTYPE_QSOUNDPAN MIXERCONTROL_CONTROLTYPE_SLIDER </td> </tr> <tr> <td width="40%"><a
    ///id="MIXERCONTROL_CT_CLASS_SWITCH"></a><a id="mixercontrol_ct_class_switch"></a><dl>
    ///<dt><b>MIXERCONTROL_CT_CLASS_SWITCH</b></dt> </dl> </td> <td width="60%"> MIXERCONTROL_CONTROLTYPE_BOOLEAN
    ///MIXERCONTROL_CONTROLTYPE_BUTTON MIXERCONTROL_CONTROLTYPE_LOUDNESS MIXERCONTROL_CONTROLTYPE_MONO
    ///MIXERCONTROL_CONTROLTYPE_MUTE MIXERCONTROL_CONTROLTYPE_ONOFF MIXERCONTROL_CONTROLTYPE_STEREOENH </td> </tr> <tr>
    ///<td width="40%"><a id="MIXERCONTROL_CT_CLASS_TIME"></a><a id="mixercontrol_ct_class_time"></a><dl>
    ///<dt><b>MIXERCONTROL_CT_CLASS_TIME</b></dt> </dl> </td> <td width="60%"> MIXERCONTROL_CONTROLTYPE_MICROTIME
    ///MIXERCONTROL_CONTROLTYPE_MILLITIME </td> </tr> </table>
    uint       dwControlType;
    ///Status and support flags for the audio line control. The following values are defined: <table> <tr> <th>Name</th>
    ///<th>Description</th> </tr> <tr> <td width="40%"><a id="MIXERCONTROL_CONTROLF_DISABLED"></a><a
    ///id="mixercontrol_controlf_disabled"></a><dl> <dt><b>MIXERCONTROL_CONTROLF_DISABLED</b></dt> </dl> </td> <td
    ///width="60%"> The control is disabled, perhaps due to other settings for the mixer hardware, and cannot be used.
    ///An application can read current settings from a disabled control, but it cannot apply settings. </td> </tr> <tr>
    ///<td width="40%"><a id="MIXERCONTROL_CONTROLF_MULTIPLE"></a><a id="mixercontrol_controlf_multiple"></a><dl>
    ///<dt><b>MIXERCONTROL_CONTROLF_MULTIPLE</b></dt> </dl> </td> <td width="60%"> The control has two or more settings
    ///per channel. An equalizer, for example, requires this flag because each frequency band can be set to a different
    ///value. An equalizer that affects both channels of a stereo line in a uniform fashion will also specify the
    ///MIXERCONTROL_CONTROLF_UNIFORM flag. </td> </tr> <tr> <td width="40%"><a id="MIXERCONTROL_CONTROLF_UNIFORM"></a><a
    ///id="mixercontrol_controlf_uniform"></a><dl> <dt><b>MIXERCONTROL_CONTROLF_UNIFORM</b></dt> </dl> </td> <td
    ///width="60%"> The control acts on all channels of a multichannel line in a uniform fashion. For example, a control
    ///that mutes both channels of a stereo line would set this flag. Most MIXERCONTROL_CONTROLTYPE_MUX and
    ///MIXERCONTROL_CONTROLTYPE_MIXER controls also specify the MIXERCONTROL_CONTROLF_UNIFORM flag. </td> </tr> </table>
    uint       fdwControl;
    ///Number of items per channel that make up a MIXERCONTROL_CONTROLF_MULTIPLE control. This number is always two or
    ///greater for multiple-item controls. If the control is not a multiple-item control, do not use this member; it
    ///will be zero.
    uint       cMultipleItems;
    ///Short string that describes the audio line control specified by <b>dwControlID</b>. This description should be
    ///appropriate to use as a concise label for the control.
    ushort[16] szShortName;
    ///String that describes the audio line control specified by <b>dwControlID</b>. This description should be
    ///appropriate to use as a complete description for the control.
    ushort[64] szName;
union Bounds
    {
    align (1):
struct
        {
        align (1):
            int lMinimum;
            int lMaximum;
        }
struct
        {
        align (1):
            uint dwMinimum;
            uint dwMaximum;
        }
        uint[6] dwReserved;
    }
union Metrics
    {
    align (1):
        uint    cSteps;
        uint    cbCustomData;
        uint[6] dwReserved;
    }
}

///The <b>MIXERLINECONTROLS</b> structure contains information about the controls of an audio line.
struct MIXERLINECONTROLSA
{
align (1):
    ///Size, in bytes, of the <b>MIXERLINECONTROLS</b> structure. This member must be initialized before calling the
    ///mixerGetLineControls function. The size specified in this member must be large enough to contain the
    ///<b>MIXERLINECONTROLS</b> structure. When <b>mixerGetLineControls</b> returns, this member contains the actual
    ///size of the information returned. The returned information will not exceed the requested size, nor will it be
    ///smaller than the <b>MIXERLINECONTROLS</b> structure.
    uint           cbStruct;
    ///Line identifier for which controls are being queried. This member is not used if the
    ///MIXER_GETLINECONTROLSF_ONEBYID flag is specified for the mixerGetLineControls function, but the mixer device
    ///still returns this member in this case. The <b>dwControlID</b> and <b>dwControlType</b> members are not used when
    ///MIXER_GETLINECONTROLSF_ALL is specified.
    uint           dwLineID;
union
    {
    align (1):
        uint dwControlID;
        uint dwControlType;
    }
    ///Number of MIXERCONTROL structure elements to retrieve. This member must be initialized by the application before
    ///calling the mixerGetLineControls function. This member can be 1 only if MIXER_GETLINECONTROLSF_ONEBYID or
    ///MIXER_GETLINECONTROLSF_ONEBYTYPE is specified or the value returned in the <b>cControls</b> member of the
    ///MIXERLINE structure returned for an audio line. This member cannot be zero. If an audio line specifies that it
    ///has no controls, <b>mixerGetLineControls</b> should not be called.
    uint           cControls;
    ///Size, in bytes, of a single MIXERCONTROL structure. The size specified in this member must be at least large
    ///enough to contain the base <b>MIXERCONTROL</b> structure. The total size, in bytes, required for the buffer
    ///pointed to by the <b>pamxctrl</b> member is the product of the <b>cbmxctrl</b> and <b>cControls</b> members of
    ///the <b>MIXERLINECONTROLS</b> structure.
    uint           cbmxctrl;
    ///Pointer to one or more MIXERCONTROL structures to receive the properties of the requested audio line controls.
    ///This member cannot be <b>NULL</b> and must be initialized before calling the mixerGetLineControls function. Each
    ///element of the array of controls must be at least large enough to contain a base <b>MIXERCONTROL</b> structure.
    ///The <b>cbmxctrl</b> member must specify the size, in bytes, of each element in this array. No initialization of
    ///the buffer pointed to by this member is required by the application. All members are filled in by the mixer
    ///device (including the <b>cbStruct</b> member of each <b>MIXERCONTROL</b> structure) upon returning successfully.
    MIXERCONTROLA* pamxctrl;
}

///The <b>MIXERLINECONTROLS</b> structure contains information about the controls of an audio line.
struct MIXERLINECONTROLSW
{
align (1):
    ///Size, in bytes, of the <b>MIXERLINECONTROLS</b> structure. This member must be initialized before calling the
    ///mixerGetLineControls function. The size specified in this member must be large enough to contain the
    ///<b>MIXERLINECONTROLS</b> structure. When <b>mixerGetLineControls</b> returns, this member contains the actual
    ///size of the information returned. The returned information will not exceed the requested size, nor will it be
    ///smaller than the <b>MIXERLINECONTROLS</b> structure.
    uint           cbStruct;
    ///Line identifier for which controls are being queried. This member is not used if the
    ///MIXER_GETLINECONTROLSF_ONEBYID flag is specified for the mixerGetLineControls function, but the mixer device
    ///still returns this member in this case. The <b>dwControlID</b> and <b>dwControlType</b> members are not used when
    ///MIXER_GETLINECONTROLSF_ALL is specified.
    uint           dwLineID;
union
    {
    align (1):
        uint dwControlID;
        uint dwControlType;
    }
    ///Number of MIXERCONTROL structure elements to retrieve. This member must be initialized by the application before
    ///calling the mixerGetLineControls function. This member can be 1 only if MIXER_GETLINECONTROLSF_ONEBYID or
    ///MIXER_GETLINECONTROLSF_ONEBYTYPE is specified or the value returned in the <b>cControls</b> member of the
    ///MIXERLINE structure returned for an audio line. This member cannot be zero. If an audio line specifies that it
    ///has no controls, <b>mixerGetLineControls</b> should not be called.
    uint           cControls;
    ///Size, in bytes, of a single MIXERCONTROL structure. The size specified in this member must be at least large
    ///enough to contain the base <b>MIXERCONTROL</b> structure. The total size, in bytes, required for the buffer
    ///pointed to by the <b>pamxctrl</b> member is the product of the <b>cbmxctrl</b> and <b>cControls</b> members of
    ///the <b>MIXERLINECONTROLS</b> structure.
    uint           cbmxctrl;
    ///Pointer to one or more MIXERCONTROL structures to receive the properties of the requested audio line controls.
    ///This member cannot be <b>NULL</b> and must be initialized before calling the mixerGetLineControls function. Each
    ///element of the array of controls must be at least large enough to contain a base <b>MIXERCONTROL</b> structure.
    ///The <b>cbmxctrl</b> member must specify the size, in bytes, of each element in this array. No initialization of
    ///the buffer pointed to by this member is required by the application. All members are filled in by the mixer
    ///device (including the <b>cbStruct</b> member of each <b>MIXERCONTROL</b> structure) upon returning successfully.
    MIXERCONTROLW* pamxctrl;
}

///The <b>MIXERCONTROLDETAILS</b> structure refers to control-detail structures, retrieving or setting state information
///of an audio mixer control. All members of this structure must be initialized before calling the
///mixerGetControlDetails and mixerSetControlDetails functions.
struct MIXERCONTROLDETAILS
{
align (1):
    ///Size, in bytes, of the <b>MIXERCONTROLDETAILS</b> structure. The size must be large enough to contain the base
    ///<b>MIXERCONTROLDETAILS</b> structure. When mixerGetControlDetails returns, this member contains the actual size
    ///of the information returned. The returned information will not exceed the requested size, nor will it be smaller
    ///than the base <b>MIXERCONTROLDETAILS</b> structure.
    uint  cbStruct;
    ///Control identifier on which to get or set properties.
    uint  dwControlID;
    ///Number of channels on which to get or set control properties. The following values are defined: <table> <tr>
    ///<th>Name</th> <th>Description</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td>
    ///<td width="60%"> Use this value when the control is a MIXERCONTROL_CONTROLTYPE_CUSTOM control. </td> </tr> <tr>
    ///<td width="40%"><a id="1"></a><dl> <dt><b>1</b></dt> </dl> </td> <td width="60%"> Use this value when the control
    ///is a MIXERCONTROL_CONTROLF_UNIFORM control or when an application needs to get and set all channels as if they
    ///were uniform. </td> </tr> <tr> <td width="40%"><a id="MIXERLINE_cChannels"></a><a id="mixerline_cchannels"></a><a
    ///id="MIXERLINE_CCHANNELS"></a><dl> <dt><b>MIXERLINE cChannels</b></dt> </dl> </td> <td width="60%"> Use this value
    ///when the properties for the control are expected on all channels for a line. </td> </tr> </table> An application
    ///cannot specify a value that falls between 1 and the number of channels for the audio line. For example,
    ///specifying 2 or 3 for a four-channel line is not valid. This member cannot be 0 for noncustom control types. This
    ///member cannot be 0 for noncustom control types.
    uint  cChannels;
union
    {
    align (1):
        HWND hwndOwner;
        uint cMultipleItems;
    }
    ///Size, in bytes, of one of the following details structures being used: <table> <tr> <th>Name</th>
    ///<th>Description</th> </tr> <tr> <td width="40%"><a id="MIXERCONTROLDETAILS_BOOLEAN"></a><a
    ///id="mixercontroldetails_boolean"></a><dl> <dt><b>MIXERCONTROLDETAILS_BOOLEAN</b></dt> </dl> </td> <td
    ///width="60%"> Boolean value for an audio line control. </td> </tr> <tr> <td width="40%"><a
    ///id="MIXERCONTROLDETAILS_LISTTEXT"></a><a id="mixercontroldetails_listtext"></a><dl>
    ///<dt><b>MIXERCONTROLDETAILS_LISTTEXT</b></dt> </dl> </td> <td width="60%"> List text buffer for an audio line
    ///control. For information about the appropriate details structure for a specific control, see Control Types. </td>
    ///</tr> <tr> <td width="40%"><a id="MIXERCONTROLDETAILS_SIGNED"></a><a id="mixercontroldetails_signed"></a><dl>
    ///<dt><b>MIXERCONTROLDETAILS_SIGNED</b></dt> </dl> </td> <td width="60%"> Signed value for an audio line control.
    ///</td> </tr> <tr> <td width="40%"><a id="MIXERCONTROLDETAILS_UNSIGNED"></a><a
    ///id="mixercontroldetails_unsigned"></a><dl> <dt><b>MIXERCONTROLDETAILS_UNSIGNED</b></dt> </dl> </td> <td
    ///width="60%"> Unsigned value for an audio line control. </td> </tr> </table>
    uint  cbDetails;
    ///Pointer to an array of one or more structures in which properties for the specified control are retrieved or set.
    ///For MIXERCONTROL_CONTROLF_MULTIPLE controls, the size of this buffer should be the product of the
    ///<b>cChannels</b>, <b>cMultipleItems</b> and <b>cbDetails</b> members of the <b>MIXERCONTROLDETAILS</b> structure.
    ///For controls other than MIXERCONTROL_CONTROLF_MULTIPLE types, the size of this buffer is the product of the
    ///<b>cChannels</b> and <b>cbDetails</b> members of the <b>MIXERCONTROLDETAILS</b> structure. For controls other
    ///than MIXERCONTROL_CONTROLF_MULTIPLE types, the size of this buffer is the product of the <b>cChannels</b> and
    ///<b>cbDetails</b> members of the <b>MIXERCONTROLDETAILS</b> structure. For controls other than
    ///MIXERCONTROL_CONTROLF_MULTIPLE types, the size of this buffer is the product of the <b>cChannels</b> and
    ///<b>cbDetails</b> members of the <b>MIXERCONTROLDETAILS</b> structure. For controls that are
    ///MIXERCONTROL_CONTROLF_MULTIPLE types, the array can be treated as a two-dimensional array that is channel major.
    ///That is, all multiple items for the left channel are given, then all multiple items for the right channel, and so
    ///on. For controls other than MIXERCONTROL_CONTROLF_MULTIPLE types, each element index is equivalent to the
    ///zero-based channel that it affects. That is, paDetails[0] is for the left channel and paDetails[1] is for the
    ///right channel. If the control is a MIXERCONTROL_CONTROLTYPE_CUSTOM control, this member must point to a buffer
    ///that is at least large enough to contain the size, in bytes, specified by the cbCustomData member of the
    ///MIXERCONTROL structure.
    void* paDetails;
}

///The MIXERCONTROLDETAILS_LISTTEXT structure retrieves list text, label text, and/or band-range information for
///multiple-item controls. This structure is used when the MIXER_GETCONTROLDETAILSF_LISTTEXT flag is specified in the
///mixerGetControlDetails function.
struct MIXERCONTROLDETAILS_LISTTEXTA
{
align (1):
    ///Control class-specific values. The following control types are listed with their corresponding values: | Name |
    ///Description | |------------|-------------| | EQUALIZER | MIXERCONTROL. Bounds dwMinimum member.| | MIXER and MUX
    ///| MIXERLINEdwLineID member.| | MULTIPLESELECT and SINGLESELECT | Undefined; must be zero |
    uint     dwParam1;
    ///See dwParam1.
    uint     dwParam2;
    ///Name describing a single item in a multiple-item control. This text can be used as a label or item text,
    ///depending on the control class.
    byte[64] szName;
}

///The MIXERCONTROLDETAILS_LISTTEXT structure retrieves list text, label text, and/or band-range information for
///multiple-item controls. This structure is used when the MIXER_GETCONTROLDETAILSF_LISTTEXT flag is specified in the
///mixerGetControlDetails function.
struct MIXERCONTROLDETAILS_LISTTEXTW
{
align (1):
    ///Control class-specific values. The following control types are listed with their corresponding values: | Name |
    ///Description | |------------|-------------| | EQUALIZER | MIXERCONTROL. Bounds dwMinimum member.| | MIXER and MUX
    ///| MIXERLINEdwLineID member.| | MULTIPLESELECT and SINGLESELECT | Undefined; must be zero |
    uint       dwParam1;
    ///See dwParam1.
    uint       dwParam2;
    ///Name describing a single item in a multiple-item control. This text can be used as a label or item text,
    ///depending on the control class.
    ushort[64] szName;
}

///The **MIXERCONTROLDETAILS_BOOLEAN** structure retrieves and sets Boolean control properties for an audio mixer
///control
struct MIXERCONTROLDETAILS_BOOLEAN
{
align (1):
    ///Boolean value for a single item or channel. This value is assumed to be zero for a FALSE state (such as off or
    ///disabled), and nonzero for a TRUE state (such as on or enabled).
    int fValue;
}

///The MIXERCONTROLDETAILS_SIGNED structure retrieves and sets signed type control properties for an audio mixer
///control.
struct MIXERCONTROLDETAILS_SIGNED
{
align (1):
    ///Signed integer value for a single item or channel. This value must be inclusively within the bounds given in the
    ///Bounds member of this structure for signed integer controls.
    int lValue;
}

///The MIXERCONTROLDETAILS_UNSIGNED structure retrieves and sets unsigned type control properties for an audio mixer
///control.
struct MIXERCONTROLDETAILS_UNSIGNED
{
align (1):
    ///Unsigned integer value for a single item or channel. This value must be inclusively within the bounds given in
    ///the Bounds structure member of the MIXERCONTROL structure for unsigned integer controls.
    uint dwValue;
}

///The <b>TIMECAPS</b> structure contains information about the resolution of the timer.
struct TIMECAPS
{
align (1):
    ///The minimum supported resolution, in milliseconds.
    uint wPeriodMin;
    ///The maximum supported resolution, in milliseconds.
    uint wPeriodMax;
}

///The <b>JOYCAPS</b> structure contains information about the joystick capabilities.
struct JOYCAPSA
{
align (1):
    ///Manufacturer identifier. Manufacturer identifiers are defined in Manufacturer and Product Identifiers.
    ushort    wMid;
    ///Product identifier. Product identifiers are defined in Manufacturer and Product Identifiers.
    ushort    wPid;
    ///Null-terminated string containing the joystick product name.
    byte[32]  szPname;
    ///Minimum X-coordinate.
    uint      wXmin;
    ///Maximum X-coordinate.
    uint      wXmax;
    ///Minimum Y-coordinate.
    uint      wYmin;
    ///Maximum Y-coordinate.
    uint      wYmax;
    ///Minimum Z-coordinate.
    uint      wZmin;
    ///Maximum Z-coordinate.
    uint      wZmax;
    ///Number of joystick buttons.
    uint      wNumButtons;
    ///Smallest polling frequency supported when captured by the joySetCapture function.
    uint      wPeriodMin;
    ///Largest polling frequency supported when captured by <b>joySetCapture</b>.
    uint      wPeriodMax;
    ///Minimum rudder value. The rudder is a fourth axis of movement.
    uint      wRmin;
    ///Maximum rudder value. The rudder is a fourth axis of movement.
    uint      wRmax;
    ///Minimum u-coordinate (fifth axis) values.
    uint      wUmin;
    ///Maximum u-coordinate (fifth axis) values.
    uint      wUmax;
    ///Minimum v-coordinate (sixth axis) values.
    uint      wVmin;
    ///Maximum v-coordinate (sixth axis) values.
    uint      wVmax;
    ///Joystick capabilities The following flags define individual capabilities that a joystick might have: <table> <tr>
    ///<th>Flag</th> <th>Description</th> </tr> <tr> <td>JOYCAPS_HASZ</td> <td>Joystick has z-coordinate
    ///information.</td> </tr> <tr> <td>JOYCAPS_HASR</td> <td>Joystick has rudder (fourth axis) information.</td> </tr>
    ///<tr> <td>JOYCAPS_HASU</td> <td>Joystick has u-coordinate (fifth axis) information.</td> </tr> <tr>
    ///<td>JOYCAPS_HASV</td> <td>Joystick has v-coordinate (sixth axis) information.</td> </tr> <tr>
    ///<td>JOYCAPS_HASPOV</td> <td>Joystick has point-of-view information.</td> </tr> <tr> <td>JOYCAPS_POV4DIR</td>
    ///<td>Joystick point-of-view supports discrete values (centered, forward, backward, left, and right).</td> </tr>
    ///<tr> <td>JOYCAPS_POVCTS</td> <td>Joystick point-of-view supports continuous degree bearings.</td> </tr> </table>
    uint      wCaps;
    ///Maximum number of axes supported by the joystick.
    uint      wMaxAxes;
    ///Number of axes currently in use by the joystick.
    uint      wNumAxes;
    ///Maximum number of buttons supported by the joystick.
    uint      wMaxButtons;
    ///Null-terminated string containing the registry key for the joystick.
    byte[32]  szRegKey;
    ///Null-terminated string identifying the joystick driver OEM.
    byte[260] szOEMVxD;
}

///The <b>JOYCAPS</b> structure contains information about the joystick capabilities.
struct JOYCAPSW
{
align (1):
    ///Manufacturer identifier. Manufacturer identifiers are defined in Manufacturer and Product Identifiers.
    ushort      wMid;
    ///Product identifier. Product identifiers are defined in Manufacturer and Product Identifiers.
    ushort      wPid;
    ///Null-terminated string containing the joystick product name.
    ushort[32]  szPname;
    ///Minimum X-coordinate.
    uint        wXmin;
    ///Maximum X-coordinate.
    uint        wXmax;
    ///Minimum Y-coordinate.
    uint        wYmin;
    ///Maximum Y-coordinate.
    uint        wYmax;
    ///Minimum Z-coordinate.
    uint        wZmin;
    ///Maximum Z-coordinate.
    uint        wZmax;
    ///Number of joystick buttons.
    uint        wNumButtons;
    ///Smallest polling frequency supported when captured by the joySetCapture function.
    uint        wPeriodMin;
    ///Largest polling frequency supported when captured by <b>joySetCapture</b>.
    uint        wPeriodMax;
    ///Minimum rudder value. The rudder is a fourth axis of movement.
    uint        wRmin;
    ///Maximum rudder value. The rudder is a fourth axis of movement.
    uint        wRmax;
    ///Minimum u-coordinate (fifth axis) values.
    uint        wUmin;
    ///Maximum u-coordinate (fifth axis) values.
    uint        wUmax;
    ///Minimum v-coordinate (sixth axis) values.
    uint        wVmin;
    ///Maximum v-coordinate (sixth axis) values.
    uint        wVmax;
    ///Joystick capabilities The following flags define individual capabilities that a joystick might have: <table> <tr>
    ///<th>Flag</th> <th>Description</th> </tr> <tr> <td>JOYCAPS_HASZ</td> <td>Joystick has z-coordinate
    ///information.</td> </tr> <tr> <td>JOYCAPS_HASR</td> <td>Joystick has rudder (fourth axis) information.</td> </tr>
    ///<tr> <td>JOYCAPS_HASU</td> <td>Joystick has u-coordinate (fifth axis) information.</td> </tr> <tr>
    ///<td>JOYCAPS_HASV</td> <td>Joystick has v-coordinate (sixth axis) information.</td> </tr> <tr>
    ///<td>JOYCAPS_HASPOV</td> <td>Joystick has point-of-view information.</td> </tr> <tr> <td>JOYCAPS_POV4DIR</td>
    ///<td>Joystick point-of-view supports discrete values (centered, forward, backward, left, and right).</td> </tr>
    ///<tr> <td>JOYCAPS_POVCTS</td> <td>Joystick point-of-view supports continuous degree bearings.</td> </tr> </table>
    uint        wCaps;
    ///Maximum number of axes supported by the joystick.
    uint        wMaxAxes;
    ///Number of axes currently in use by the joystick.
    uint        wNumAxes;
    ///Maximum number of buttons supported by the joystick.
    uint        wMaxButtons;
    ///Null-terminated string containing the registry key for the joystick.
    ushort[32]  szRegKey;
    ///Null-terminated string identifying the joystick driver OEM.
    ushort[260] szOEMVxD;
}

struct JOYCAPS2A
{
align (1):
    ushort    wMid;
    ushort    wPid;
    byte[32]  szPname;
    uint      wXmin;
    uint      wXmax;
    uint      wYmin;
    uint      wYmax;
    uint      wZmin;
    uint      wZmax;
    uint      wNumButtons;
    uint      wPeriodMin;
    uint      wPeriodMax;
    uint      wRmin;
    uint      wRmax;
    uint      wUmin;
    uint      wUmax;
    uint      wVmin;
    uint      wVmax;
    uint      wCaps;
    uint      wMaxAxes;
    uint      wNumAxes;
    uint      wMaxButtons;
    byte[32]  szRegKey;
    byte[260] szOEMVxD;
    GUID      ManufacturerGuid;
    GUID      ProductGuid;
    GUID      NameGuid;
}

struct JOYCAPS2W
{
align (1):
    ushort      wMid;
    ushort      wPid;
    ushort[32]  szPname;
    uint        wXmin;
    uint        wXmax;
    uint        wYmin;
    uint        wYmax;
    uint        wZmin;
    uint        wZmax;
    uint        wNumButtons;
    uint        wPeriodMin;
    uint        wPeriodMax;
    uint        wRmin;
    uint        wRmax;
    uint        wUmin;
    uint        wUmax;
    uint        wVmin;
    uint        wVmax;
    uint        wCaps;
    uint        wMaxAxes;
    uint        wNumAxes;
    uint        wMaxButtons;
    ushort[32]  szRegKey;
    ushort[260] szOEMVxD;
    GUID        ManufacturerGuid;
    GUID        ProductGuid;
    GUID        NameGuid;
}

///The <b>JOYINFO</b> structure contains information about the joystick position and button state.
struct JOYINFO
{
align (1):
    ///Current X-coordinate.
    uint wXpos;
    ///Current Y-coordinate.
    uint wYpos;
    ///Current Z-coordinate.
    uint wZpos;
    ///Current state of joystick buttons described by one or more of the following values: <table> <tr> <th>Button</th>
    ///<th>Description</th> </tr> <tr> <td>JOY_BUTTON1</td> <td>First joystick button is pressed.</td> </tr> <tr>
    ///<td>JOY_BUTTON2</td> <td>Second joystick button is pressed.</td> </tr> <tr> <td>JOY_BUTTON3</td> <td>Third
    ///joystick button is pressed.</td> </tr> <tr> <td>JOY_BUTTON4</td> <td>Fourth joystick button is pressed.</td>
    ///</tr> </table>
    uint wButtons;
}

///The <b>JOYINFOEX</b> structure contains extended information about the joystick position, point-of-view position, and
///button state.
struct JOYINFOEX
{
align (1):
    ///Size, in bytes, of this structure.
    uint dwSize;
    ///Flags indicating the valid information returned in this structure. Members that do not contain valid information
    ///are set to zero. The following flags are defined: <table> <tr> <th>Flag</th> <th>Description</th> </tr> <tr>
    ///<td>JOY_RETURNALL</td> <td>Equivalent to setting all of the JOY_RETURN bits except JOY_RETURNRAWDATA.</td> </tr>
    ///<tr> <td>JOY_RETURNBUTTONS</td> <td>The <b>dwButtons</b> member contains valid information about the state of
    ///each joystick button.</td> </tr> <tr> <td>JOY_RETURNCENTERED</td> <td>Centers the joystick neutral position to
    ///the middle value of each axis of movement.</td> </tr> <tr> <td>JOY_RETURNPOV</td> <td>The <b>dwPOV</b> member
    ///contains valid information about the point-of-view control, expressed in discrete units.</td> </tr> <tr>
    ///<td>JOY_RETURNPOVCTS</td> <td>The <b>dwPOV</b> member contains valid information about the point-of-view control
    ///expressed in continuous, one-hundredth degree units.</td> </tr> <tr> <td>JOY_RETURNR</td> <td>The <b>dwRpos</b>
    ///member contains valid rudder pedal data. This information represents another (fourth) axis.</td> </tr> <tr>
    ///<td>JOY_RETURNRAWDATA</td> <td>Data stored in this structure is uncalibrated joystick readings.</td> </tr> <tr>
    ///<td>JOY_RETURNU</td> <td>The <b>dwUpos</b> member contains valid data for a fifth axis of the joystick, if such
    ///an axis is available, or returns zero otherwise.</td> </tr> <tr> <td>JOY_RETURNV</td> <td>The <b>dwVpos</b>
    ///member contains valid data for a sixth axis of the joystick, if such an axis is available, or returns zero
    ///otherwise.</td> </tr> <tr> <td>JOY_RETURNX</td> <td>The <b>dwXpos</b> member contains valid data for the
    ///x-coordinate of the joystick.</td> </tr> <tr> <td>JOY_RETURNY</td> <td>The <b>dwYpos</b> member contains valid
    ///data for the y-coordinate of the joystick.</td> </tr> <tr> <td>JOY_RETURNZ</td> <td>The <b>dwZpos</b> member
    ///contains valid data for the z-coordinate of the joystick.</td> </tr> </table> The following flags provide data to
    ///calibrate a joystick and are intended for custom calibration applications. <table> <tr> <th>Flag</th>
    ///<th>Description</th> </tr> <tr> <td>JOY_CAL_READ3</td> <td>Read the x-, y-, and z-coordinates and store the raw
    ///values in <b>dwXpos</b>, <b>dwYpos</b>, and <b>dwZpos</b>.</td> </tr> <tr> <td>JOY_CAL_READ4</td> <td>Read the
    ///rudder information and the x-, y-, and z-coordinates and store the raw values in <b>dwXpos</b>, <b>dwYpos</b>,
    ///<b>dwZpos</b>, and <b>dwRpos</b>.</td> </tr> <tr> <td>JOY_CAL_READ5</td> <td>Read the rudder information and the
    ///x-, y-, z-, and u-coordinates and store the raw values in <b>dwXpos</b>, <b>dwYpos</b>, <b>dwZpos</b>,
    ///<b>dwRpos</b>, and <b>dwUpos</b>.</td> </tr> <tr> <td>JOY_CAL_READ6</td> <td>Read the raw v-axis data if a
    ///joystick mini driver is present that will provide the data. Returns zero otherwise.</td> </tr> <tr>
    ///<td>JOY_CAL_READALWAYS</td> <td>Read the joystick port even if the driver does not detect a device.</td> </tr>
    ///<tr> <td>JOY_CAL_READRONLY</td> <td>Read the rudder information if a joystick mini-driver is present that will
    ///provide the data and store the raw value in <b>dwRpos</b>. Return zero otherwise.</td> </tr> <tr>
    ///<td>JOY_CAL_READXONLY</td> <td>Read the x-coordinate and store the raw (uncalibrated) value in
    ///<b>dwXpos</b>.</td> </tr> <tr> <td>JOY_CAL_READXYONLY</td> <td>Reads the x- and y-coordinates and place the raw
    ///values in <b>dwXpos</b> and <b>dwYpos</b>.</td> </tr> <tr> <td>JOY_CAL_READYONLY</td> <td>Reads the y-coordinate
    ///and store the raw value in <b>dwYpos</b>.</td> </tr> <tr> <td>JOY_CAL_READZONLY</td> <td>Read the z-coordinate
    ///and store the raw value in <b>dwZpos</b>.</td> </tr> <tr> <td>JOY_CAL_READUONLY</td> <td>Read the u-coordinate if
    ///a joystick mini-driver is present that will provide the data and store the raw value in <b>dwUpos</b>. Return
    ///zero otherwise.</td> </tr> <tr> <td>JOY_CAL_READVONLY</td> <td>Read the v-coordinate if a joystick mini-driver is
    ///present that will provide the data and store the raw value in <b>dwVpos</b>. Return zero otherwise.</td> </tr>
    ///</table>
    uint dwFlags;
    ///Current X-coordinate.
    uint dwXpos;
    ///Current Y-coordinate.
    uint dwYpos;
    ///Current Z-coordinate.
    uint dwZpos;
    ///Current position of the rudder or fourth joystick axis.
    uint dwRpos;
    ///Current fifth axis position.
    uint dwUpos;
    ///Current sixth axis position.
    uint dwVpos;
    ///Current state of the 32 joystick buttons. The value of this member can be set to any combination of JOY_BUTTON
    ///<i>n</i> flags, where <i>n</i> is a value in the range of 1 through 32 corresponding to the button that is
    ///pressed.
    uint dwButtons;
    ///Current button number that is pressed.
    uint dwButtonNumber;
    ///Current position of the point-of-view control. Values for this member are in the range 0 through 35,900. These
    ///values represent the angle, in degrees, of each view multiplied by 100.
    uint dwPOV;
    ///Reserved; do not use.
    uint dwReserved1;
    ///Reserved; do not use.
    uint dwReserved2;
}

///The <b>WAVEFORMATEXTENSIBLE</b> structure defines the format of waveform-audio data for formats having more than two
///channels or higher sample resolutions than allowed by WAVEFORMATEX. It can also be used to define any format that can
///be defined by <b>WAVEFORMATEX</b>.
struct WAVEFORMATEXTENSIBLE
{
align (1):
    ///WAVEFORMATEX structure that specifies the basic format. The <b>wFormatTag</b> member must be
    ///WAVE_FORMAT_EXTENSIBLE. The <b>cbSize</b> member must be at least 22.
    WAVEFORMATEX Format;
union Samples
    {
    align (1):
        ushort wValidBitsPerSample;
        ushort wSamplesPerBlock;
        ushort wReserved;
    }
    ///Bitmask specifying the assignment of channels in the stream to speaker positions.
    uint         dwChannelMask;
    ///Subformat of the data, such as KSDATAFORMAT_SUBTYPE_PCM. The subformat information is similar to that provided by
    ///the tag in the WAVEFORMATEX structure's <b>wFormatTag</b> member.
    GUID         SubFormat;
}

struct ADPCMCOEFSET
{
align (1):
    short iCoef1;
    short iCoef2;
}

struct ADPCMWAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wSamplesPerBlock;
    ushort       wNumCoef;
    ADPCMCOEFSET aCoef;
}

struct DRMWAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wReserved;
    uint         ulContentId;
    WAVEFORMATEX wfxSecure;
}

struct DVIADPCMWAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wSamplesPerBlock;
}

struct IMAADPCMWAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wSamplesPerBlock;
}

struct MEDIASPACEADPCMWAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wRevision;
}

struct SIERRAADPCMWAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wRevision;
}

struct G723_ADPCMWAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       cbExtraSize;
    ushort       nAuxBlockSize;
}

struct DIGISTDWAVEFORMAT
{
    WAVEFORMATEX wfx;
}

struct DIGIFIXWAVEFORMAT
{
    WAVEFORMATEX wfx;
}

struct DIALOGICOKIADPCMWAVEFORMAT
{
    WAVEFORMATEX ewf;
}

struct YAMAHA_ADPCMWAVEFORMAT
{
    WAVEFORMATEX wfx;
}

struct SONARCWAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wCompType;
}

struct TRUESPEECHWAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wRevision;
    ushort       nSamplesPerBlock;
    ubyte[28]    abReserved;
}

struct ECHOSC1WAVEFORMAT
{
    WAVEFORMATEX wfx;
}

struct AUDIOFILE_AF36WAVEFORMAT
{
    WAVEFORMATEX wfx;
}

struct APTXWAVEFORMAT
{
    WAVEFORMATEX wfx;
}

struct AUDIOFILE_AF10WAVEFORMAT
{
    WAVEFORMATEX wfx;
}

struct DOLBYAC2WAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       nAuxBitsCode;
}

struct GSM610WAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wSamplesPerBlock;
}

struct ADPCMEWAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wSamplesPerBlock;
}

struct CONTRESVQLPCWAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wSamplesPerBlock;
}

struct DIGIREALWAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wSamplesPerBlock;
}

struct DIGIADPCMWAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wSamplesPerBlock;
}

struct CONTRESCR10WAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wSamplesPerBlock;
}

struct NMS_VBXADPCMWAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wSamplesPerBlock;
}

struct G721_ADPCMWAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       nAuxBlockSize;
}

struct MSAUDIO1WAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wSamplesPerBlock;
    ushort       wEncodeOptions;
}

struct WMAUDIO2WAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    uint         dwSamplesPerBlock;
    ushort       wEncodeOptions;
    uint         dwSuperBlockAlign;
}

struct WMAUDIO3WAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wValidBitsPerSample;
    uint         dwChannelMask;
    uint         dwReserved1;
    uint         dwReserved2;
    ushort       wEncodeOptions;
    ushort       wReserved3;
}

struct CREATIVEADPCMWAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wRevision;
}

struct CREATIVEFASTSPEECH8WAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wRevision;
}

struct CREATIVEFASTSPEECH10WAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wRevision;
}

struct FMTOWNS_SND_WAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wRevision;
}

struct OLIGSMWAVEFORMAT
{
    WAVEFORMATEX wfx;
}

struct OLIADPCMWAVEFORMAT
{
    WAVEFORMATEX wfx;
}

struct OLICELPWAVEFORMAT
{
    WAVEFORMATEX wfx;
}

struct OLISBCWAVEFORMAT
{
    WAVEFORMATEX wfx;
}

struct OLIOPRWAVEFORMAT
{
    WAVEFORMATEX wfx;
}

struct CSIMAADPCMWAVEFORMAT
{
    WAVEFORMATEX wfx;
}

///The <b>WAVEFILTER</b> structure defines a filter for waveform-audio data. Only filter information common to all
///waveform-audio data filters is included in this structure. For filters that require additional information, this
///structure is included as the first member in another structure along with the additional information.
struct WAVEFILTER
{
align (1):
    ///Size, in bytes, of the <b>WAVEFILTER</b> structure. The size specified in this member must be large enough to
    ///contain the base <b>WAVEFILTER</b> structure.
    uint    cbStruct;
    ///Waveform-audio filter type. Filter tags are registered with Microsoft Corporation for various filter algorithms.
    uint    dwFilterTag;
    ///Flags for the <b>dwFilterTag</b> member. The flags defined for this member are universal to all filters.
    ///Currently, no flags are defined.
    uint    fdwFilter;
    ///Reserved for system use; should not be examined or modified by an application.
    uint[5] dwReserved;
}

struct VOLUMEWAVEFILTER
{
align (1):
    WAVEFILTER wfltr;
    uint       dwVolume;
}

struct ECHOWAVEFILTER
{
align (1):
    WAVEFILTER wfltr;
    uint       dwVolume;
    uint       dwDelay;
}

struct s_RIFFWAVE_inst
{
    ubyte bUnshiftedNote;
    byte  chFineTune;
    byte  chGain;
    ubyte bLowNote;
    ubyte bHighNote;
    ubyte bLowVelocity;
    ubyte bHighVelocity;
}

struct tag_s_RIFFWAVE_INST
{
}

struct EXBMINFOHEADER
{
align (1):
    BITMAPINFOHEADER bmi;
    uint             biExtDataOffset;
}

struct JPEGINFOHEADER
{
align (1):
    uint JPEGSize;
    uint JPEGProcess;
    uint JPEGColorSpaceID;
    uint JPEGBitsPerSample;
    uint JPEGHSubSampling;
    uint JPEGVSubSampling;
}

///The <b>MCI_DGV_RECT_PARMS</b> structure contains parameters for the MCI_FREEZE, MCI_PUT, MCI_UNFREEZE, and MCI_WHERE
///commands for digital-video devices.
struct MCI_DGV_RECT_PARMS
{
align (1):
    ///The low-order word specifies a window handle used for the MCI_NOTIFY flag.
    size_t dwCallback;
    ///Rectangle containing positioning information. RECT structures are handled differently in MCI than in other parts
    ///of Windows; in MCI, <b>rc.right</b> contains the width of the rectangle and <b>rc.bottom</b> contains its height.
    RECT   rc;
}

///The <b>MCI_DGV_CAPTURE_PARMS</b> structure contains parameters for the MCI_CAPTURE command for digital-video devices.
struct MCI_DGV_CAPTURE_PARMSA
{
align (1):
    ///The low-order word specifies a window handle used for the MCI_NOTIFY flag.
    size_t dwCallback;
    ///Pointer to a null-terminated string specifying the destination path and filename for the file that receives the
    ///captured data.
    PSTR   lpstrFileName;
    ///Rectangle containing positioning information. RECT structures are handled differently in MCI than in other parts
    ///of Windows; in MCI, <b>rc.right</b> contains the width of the rectangle and <b>rc.bottom</b> contains its height.
    RECT   rc;
}

///The <b>MCI_DGV_CAPTURE_PARMS</b> structure contains parameters for the MCI_CAPTURE command for digital-video devices.
struct MCI_DGV_CAPTURE_PARMSW
{
align (1):
    ///The low-order word specifies a window handle used for the MCI_NOTIFY flag.
    size_t dwCallback;
    ///Pointer to a null-terminated string specifying the destination path and filename for the file that receives the
    ///captured data.
    PWSTR  lpstrFileName;
    ///Rectangle containing positioning information. RECT structures are handled differently in MCI than in other parts
    ///of Windows; in MCI, <b>rc.right</b> contains the width of the rectangle and <b>rc.bottom</b> contains its height.
    RECT   rc;
}

///The <b>MCI_DGV_COPY_PARMS</b> structure contains parameters for the MCI_COPY command for digital-video devices.
struct MCI_DGV_COPY_PARMS
{
align (1):
    ///The low-order word specifies a window handle used for the MCI_NOTIFY flag.
    size_t dwCallback;
    ///Starting position for copy.
    uint   dwFrom;
    ///Ending position for copy.
    uint   dwTo;
    ///Rectangle describing area to be copied. Be aware that RECT structures are handled differently in MCI than in
    ///other parts of Windows; in MCI, <b>rc.right</b> contains the width of the rectangle and <b>rc.bottom</b> contains
    ///its height.
    RECT   rc;
    ///Audio stream.
    uint   dwAudioStream;
    ///Video stream.
    uint   dwVideoStream;
}

///The <b>MCI_DGV_CUE_PARMS</b> structure contains parameters for the MCI_CUE command for digital-video devices.
struct MCI_DGV_CUE_PARMS
{
align (1):
    ///The low-order word specifies a window handle used for the MCI_NOTIFY flag.
    size_t dwCallback;
    ///Cue position.
    uint   dwTo;
}

///The <b>MCI_DGV_CUT_PARMS</b> structure contains parameters for the MCI_CUT command for digital-video devices.
struct MCI_DGV_CUT_PARMS
{
align (1):
    ///The low-order word specifies a window handle used for the MCI_NOTIFY flag.
    size_t dwCallback;
    ///Starting position for cut.
    uint   dwFrom;
    ///Ending position for cut.
    uint   dwTo;
    ///Rectangle describing area to be cut. RECT structures are handled differently in MCI than in other parts of
    ///Windows; in MCI, <b>rc.right</b> contains the width of the rectangle and <b>rc.bottom</b> contains its height.
    RECT   rc;
    ///Audio stream.
    uint   dwAudioStream;
    ///Video stream.
    uint   dwVideoStream;
}

///The <b>MCI_DGV_DELETE_PARMS</b> structure contains parameters for the MCI_DELETE command for digital-video devices.
struct MCI_DGV_DELETE_PARMS
{
align (1):
    ///The low-order word specifies a window handle used for the MCI_NOTIFY flag.
    size_t dwCallback;
    ///Starting position for delete.
    uint   dwFrom;
    ///Ending position for delete.
    uint   dwTo;
    ///Rectangle describing area to delete. RECT structures are handled differently in MCI than in other parts of
    ///Windows; in MCI, <b>rc.right</b> contains the width of the rectangle and <b>rc.bottom</b> contains its height.
    RECT   rc;
    ///Audio stream.
    uint   dwAudioStream;
    uint   dwVideoStream;
}

///The <b>MCI_DGV_INFO_PARMS</b> structure contains parameters for the MCI_INFO command for digital-video devices.
struct MCI_DGV_INFO_PARMSA
{
align (1):
    ///The low-order word specifies a window handle used for the MCI_NOTIFY flag.
    size_t dwCallback;
    ///Pointer to buffer for return string.
    PSTR   lpstrReturn;
    ///Size, in bytes, of return buffer.
    uint   dwRetSize;
    ///Constant describing information to return.
    uint   dwItem;
}

///The <b>MCI_DGV_INFO_PARMS</b> structure contains parameters for the MCI_INFO command for digital-video devices.
struct MCI_DGV_INFO_PARMSW
{
align (1):
    ///The low-order word specifies a window handle used for the MCI_NOTIFY flag.
    size_t dwCallback;
    ///Pointer to buffer for return string.
    PWSTR  lpstrReturn;
    ///Size, in bytes, of return buffer.
    uint   dwRetSize;
    ///Constant describing information to return.
    uint   dwItem;
}

///The <b>MCI_DGV_LIST_PARMS</b> structure contains the information for the MCI_LIST command for digital-video devices.
struct MCI_DGV_LIST_PARMSA
{
align (1):
    ///The low-order word specifies a window handle used for the MCI_NOTIFY flag.
    size_t dwCallback;
    ///Buffer for return string.
    PSTR   lpstrReturn;
    ///Length, in bytes, of buffer.
    uint   dwLength;
    ///Index of item in list.
    uint   dwNumber;
    ///Type of list item.
    uint   dwItem;
    ///String containing algorithm name.
    PSTR   lpstrAlgorithm;
}

///The <b>MCI_DGV_LIST_PARMS</b> structure contains the information for the MCI_LIST command for digital-video devices.
struct MCI_DGV_LIST_PARMSW
{
align (1):
    ///The low-order word specifies a window handle used for the MCI_NOTIFY flag.
    size_t dwCallback;
    ///Buffer for return string.
    PWSTR  lpstrReturn;
    ///Length, in bytes, of buffer.
    uint   dwLength;
    ///Index of item in list.
    uint   dwNumber;
    ///Type of list item.
    uint   dwItem;
    ///String containing algorithm name.
    PWSTR  lpstrAlgorithm;
}

///The <b>MCI_DGV_MONITOR_PARMS</b> structure contains parameters for the MCI_MONITOR command.
struct MCI_DGV_MONITOR_PARMS
{
align (1):
    ///The low-order word specifies a window handle used for the MCI_NOTIFY flag.
    size_t dwCallback;
    ///One of the following flags for the monitor source: <table> <tr> <th>Name</th> <th>Description</th> </tr> <tr> <td
    ///width="40%"><a id="MCI_DGV_MONITOR_FILE"></a><a id="mci_dgv_monitor_file"></a><dl>
    ///<dt><b>MCI_DGV_MONITOR_FILE</b></dt> </dl> </td> <td width="60%"> The workspace is the presentation source. (This
    ///is the default source.) If this flag is used during recording, the recording pauses. If the MCI_MONITOR command
    ///changes the presentation source, recording or playing stops and the current position is the value returned by the
    ///MCI_STATUS command for the start position. </td> </tr> <tr> <td width="40%"><a id="MCI_DGV_MONITOR_INPUT"></a><a
    ///id="mci_dgv_monitor_input"></a><dl> <dt><b>MCI_DGV_MONITOR_INPUT</b></dt> </dl> </td> <td width="60%"> The
    ///external input is the presentation source. Playback is paused before the input is selected. If the MCI_SETVIDEO
    ///command has been enabled using the MCI_SET_ON flag, this flag displays a default hidden window. Device drivers
    ///might limit what other device instances can do while monitoring input. </td> </tr> </table>
    uint   dwSource;
    ///One of the following constants for the type of monitoring: <table> <tr> <th>Name</th> <th>Description</th> </tr>
    ///<tr> <td width="40%"><a id="MCI_DGV_METHOD_DIRECT"></a><a id="mci_dgv_method_direct"></a><dl>
    ///<dt><b>MCI_DGV_METHOD_DIRECT</b></dt> </dl> </td> <td width="60%"> The device should be configured for optimum
    ///display quality during monitoring. Direct monitoring might be incompatible with motion-video recording. </td>
    ///</tr> <tr> <td width="40%"><a id="MCI_DGV_METHOD_POST"></a><a id="mci_dgv_method_post"></a><dl>
    ///<dt><b>MCI_DGV_METHOD_POST</b></dt> </dl> </td> <td width="60%"> The device should show the external input after
    ///compression. Post monitoring supports motion-video recording. </td> </tr> <tr> <td width="40%"><a
    ///id="MCI_DGV_METHOD_PRE"></a><a id="mci_dgv_method_pre"></a><dl> <dt><b>MCI_DGV_METHOD_PRE</b></dt> </dl> </td>
    ///<td width="60%"> The device should show the external input prior to compression. </td> </tr> </table>
    uint   dwMethod;
}

///The <b>MCI_DGV_OPEN_PARMS</b> structure contains information for the MCI_OPEN command for digital-video devices.
struct MCI_DGV_OPEN_PARMSA
{
align (1):
    ///The low-order word specifies a window handle used for the MCI_NOTIFY flag.
    size_t dwCallback;
    ///Device ID returned to user.
    uint   wDeviceID;
    ///Name or constant ID of device type.
    PSTR   lpstrDeviceType;
    ///Optional device alias.
    PSTR   lpstrElementName;
    ///Optional device alias.
    PSTR   lpstrAlias;
    ///Window style.
    uint   dwStyle;
    ///Handle to parent window.
    HWND   hWndParent;
}

///The <b>MCI_DGV_OPEN_PARMS</b> structure contains information for the MCI_OPEN command for digital-video devices.
struct MCI_DGV_OPEN_PARMSW
{
align (1):
    ///The low-order word specifies a window handle used for the MCI_NOTIFY flag.
    size_t dwCallback;
    ///Device ID returned to user.
    uint   wDeviceID;
    ///Name or constant ID of device type.
    PWSTR  lpstrDeviceType;
    ///Optional device alias.
    PWSTR  lpstrElementName;
    ///Optional device alias.
    PWSTR  lpstrAlias;
    ///Window style.
    uint   dwStyle;
    ///Handle to parent window.
    HWND   hWndParent;
}

///The <b>MCI_DGV_PASTE_PARMS</b> structure contains parameters for the MCI_PASTE command for digital-video devices.
struct MCI_DGV_PASTE_PARMS
{
align (1):
    ///The low-order word specifies a window handle used for the MCI_NOTIFY flag.
    size_t dwCallback;
    ///Starting position for paste.
    uint   dwTo;
    ///Rectangle containing positioning information. RECT structures are handled differently in MCI than in other parts
    ///of Windows; in MCI, <b>rc.right</b> contains the width of the rectangle and <b>rc.bottom</b> contains its height.
    RECT   rc;
    ///Audio stream.
    uint   dwAudioStream;
    ///Video stream.
    uint   dwVideoStream;
}

///The <b>MCI_DGV_QUALITY_PARMS</b> structure contains parameters for the MCI_QUALITY command for digital-video devices.
struct MCI_DGV_QUALITY_PARMSA
{
align (1):
    ///The low-order word specifies a window handle used for the MCI_NOTIFY flag.
    size_t dwCallback;
    ///One of the following constants indicating the type of algorithm: <table> <tr> <th>Name</th> <th>Description</th>
    ///</tr> <tr> <td width="40%"><a id="MCI_QUALITY_ITEM_AUDIO"></a><a id="mci_quality_item_audio"></a><dl>
    ///<dt><b>MCI_QUALITY_ITEM_AUDIO</b></dt> </dl> </td> <td width="60%"> Definitions are for an audio compression
    ///algorithm. </td> </tr> <tr> <td width="40%"><a id="MCI_QUALITY_ITEM_STILL"></a><a
    ///id="mci_quality_item_still"></a><dl> <dt><b>MCI_QUALITY_ITEM_STILL</b></dt> </dl> </td> <td width="60%">
    ///Definitions are for a still video compression algorithm. </td> </tr> <tr> <td width="40%"><a
    ///id="MCI_QUALITY_ITEM_VIDEO"></a><a id="mci_quality_item_video"></a><dl> <dt><b>MCI_QUALITY_ITEM_VIDEO</b></dt>
    ///</dl> </td> <td width="60%"> Definitions are for a video compression algorithm. </td> </tr> </table>
    uint   dwItem;
    ///String naming description.
    PSTR   lpstrName;
    ///String naming algorithm.
    uint   lpstrAlgorithm;
    ///Handle to a structure containing information describing the quality attributes.
    uint   dwHandle;
}

///The <b>MCI_DGV_QUALITY_PARMS</b> structure contains parameters for the MCI_QUALITY command for digital-video devices.
struct MCI_DGV_QUALITY_PARMSW
{
align (1):
    ///The low-order word specifies a window handle used for the MCI_NOTIFY flag.
    size_t dwCallback;
    ///One of the following constants indicating the type of algorithm: <table> <tr> <th>Name</th> <th>Description</th>
    ///</tr> <tr> <td width="40%"><a id="MCI_QUALITY_ITEM_AUDIO"></a><a id="mci_quality_item_audio"></a><dl>
    ///<dt><b>MCI_QUALITY_ITEM_AUDIO</b></dt> </dl> </td> <td width="60%"> Definitions are for an audio compression
    ///algorithm. </td> </tr> <tr> <td width="40%"><a id="MCI_QUALITY_ITEM_STILL"></a><a
    ///id="mci_quality_item_still"></a><dl> <dt><b>MCI_QUALITY_ITEM_STILL</b></dt> </dl> </td> <td width="60%">
    ///Definitions are for a still video compression algorithm. </td> </tr> <tr> <td width="40%"><a
    ///id="MCI_QUALITY_ITEM_VIDEO"></a><a id="mci_quality_item_video"></a><dl> <dt><b>MCI_QUALITY_ITEM_VIDEO</b></dt>
    ///</dl> </td> <td width="60%"> Definitions are for a video compression algorithm. </td> </tr> </table>
    uint   dwItem;
    ///String naming description.
    PWSTR  lpstrName;
    ///String naming algorithm.
    uint   lpstrAlgorithm;
    ///Handle to a structure containing information describing the quality attributes.
    uint   dwHandle;
}

///The <b>MCI_DGV_RECORD_PARMS</b> structure contains parameters for the MCI_RECORD command for digital-video devices.
struct MCI_DGV_RECORD_PARMS
{
align (1):
    ///The low-order word specifies a window handle used for the MCI_NOTIFY flag.
    size_t dwCallback;
    ///Position to record from.
    uint   dwFrom;
    ///Position to record to.
    uint   dwTo;
    ///The region of the frame buffer used as the source for the pixels compressed and saved. RECT structures are
    ///handled differently in MCI than in other parts of Windows; in MCI, <b>rc.right</b> contains the width of the
    ///rectangle and <b>rc.bottom</b> contains its height.
    RECT   rc;
    ///Audio stream.
    uint   dwAudioStream;
    ///Video stream.
    uint   dwVideoStream;
}

///The <b>MCI_DGV_RESERVE_PARMS</b> structure contains information for the MCI_RESERVE command for digital-video
///devices.
struct MCI_DGV_RESERVE_PARMSA
{
align (1):
    ///The low-order word specifies a window handle used for the MCI_NOTIFY flag.
    size_t dwCallback;
    ///Pointer to a null-terminated string containing the location of a temporary file. The buffer contains only the
    ///drive and directory path of the file used to hold recorded data; the filename is specified by the device driver.
    PSTR   lpstrPath;
    ///Size of reserved disk space.
    uint   dwSize;
}

///The <b>MCI_DGV_RESERVE_PARMS</b> structure contains information for the MCI_RESERVE command for digital-video
///devices.
struct MCI_DGV_RESERVE_PARMSW
{
align (1):
    ///The low-order word specifies a window handle used for the MCI_NOTIFY flag.
    size_t dwCallback;
    ///Pointer to a null-terminated string containing the location of a temporary file. The buffer contains only the
    ///drive and directory path of the file used to hold recorded data; the filename is specified by the device driver.
    PWSTR  lpstrPath;
    ///Size of reserved disk space.
    uint   dwSize;
}

///The <b>MCI_DGV_RESTORE_PARMS</b> structure contains information for the MCI_RESTORE command for digital-video
///devices.
struct MCI_DGV_RESTORE_PARMSA
{
align (1):
    ///The low-order word specifies a window handle used for the MCI_NOTIFY flag.
    size_t dwCallback;
    ///Pointer to a null-terminated string containing the filename from which the frame buffer information will be
    ///restored.
    PSTR   lpstrFileName;
    ///Rectangle containing positioning information. RECT structures are handled differently in MCI than in other parts
    ///of Windows; in MCI, <b>rc.right</b> contains the width of the rectangle and <b>rc.bottom</b> contains its height.
    RECT   rc;
}

///The <b>MCI_DGV_RESTORE_PARMS</b> structure contains information for the MCI_RESTORE command for digital-video
///devices.
struct MCI_DGV_RESTORE_PARMSW
{
align (1):
    ///The low-order word specifies a window handle used for the MCI_NOTIFY flag.
    size_t dwCallback;
    ///Pointer to a null-terminated string containing the filename from which the frame buffer information will be
    ///restored.
    PWSTR  lpstrFileName;
    ///Rectangle containing positioning information. RECT structures are handled differently in MCI than in other parts
    ///of Windows; in MCI, <b>rc.right</b> contains the width of the rectangle and <b>rc.bottom</b> contains its height.
    RECT   rc;
}

///The <b>MCI_DGV_SAVE_PARMS</b> structure contains information for the MCI_SAVE command for digital-video devices.
struct MCI_DGV_SAVE_PARMSA
{
align (1):
    ///The low-order word specifies a window handle used for the MCI_NOTIFY flag.
    size_t dwCallback;
    ///String for filename to save.
    PSTR   lpstrFileName;
    ///Rectangle containing positioning information. RECT structures are handled differently in MCI than in other parts
    ///of Windows; in MCI, <b>rc.right</b> contains the width of the rectangle and <b>rc.bottom</b> contains its height.
    RECT   rc;
}

///The <b>MCI_DGV_SAVE_PARMS</b> structure contains information for the MCI_SAVE command for digital-video devices.
struct MCI_DGV_SAVE_PARMSW
{
align (1):
    ///The low-order word specifies a window handle used for the MCI_NOTIFY flag.
    size_t dwCallback;
    ///String for filename to save.
    PWSTR  lpstrFileName;
    ///Rectangle containing positioning information. RECT structures are handled differently in MCI than in other parts
    ///of Windows; in MCI, <b>rc.right</b> contains the width of the rectangle and <b>rc.bottom</b> contains its height.
    RECT   rc;
}

///The <b>MCI_DGV_SET_PARMS</b> structure contains parameters for the MCI_SET command for digital-video devices.
struct MCI_DGV_SET_PARMS
{
align (1):
    ///The low-order word specifies a window handle used for the MCI_NOTIFY flag.
    size_t dwCallback;
    ///Time format of device.
    uint   dwTimeFormat;
    ///Channel for audio output.
    uint   dwAudio;
    ///File format.
    uint   dwFileFormat;
    ///Playback speed.
    uint   dwSpeed;
}

///The <b>MCI_DGV_SETAUDIO_PARMS</b> structure contains parameters for the MCI_SETAUDIO command for digital-video
///devices.
struct MCI_DGV_SETAUDIO_PARMSA
{
align (1):
    ///The low-order word specifies a window handle used for the MCI_NOTIFY flag.
    size_t dwCallback;
    ///Constant indicating the target adjustment. For a list of possible values, see the MCI_SETAUDIO command.
    uint   dwItem;
    ///Adjustment level.
    uint   dwValue;
    ///Transmission length.
    uint   dwOver;
    ///Pointer to a null-terminated string containing the name of the audio-compression algorithm.
    PSTR   lpstrAlgorithm;
    ///Pointer to a null-terminated string containing a descriptor of the audio-compression algorithm.
    PSTR   lpstrQuality;
}

///The <b>MCI_DGV_SETAUDIO_PARMS</b> structure contains parameters for the MCI_SETAUDIO command for digital-video
///devices.
struct MCI_DGV_SETAUDIO_PARMSW
{
align (1):
    ///The low-order word specifies a window handle used for the MCI_NOTIFY flag.
    size_t dwCallback;
    ///Constant indicating the target adjustment. For a list of possible values, see the MCI_SETAUDIO command.
    uint   dwItem;
    ///Adjustment level.
    uint   dwValue;
    ///Transmission length.
    uint   dwOver;
    ///Pointer to a null-terminated string containing the name of the audio-compression algorithm.
    PWSTR  lpstrAlgorithm;
    ///Pointer to a null-terminated string containing a descriptor of the audio-compression algorithm.
    PWSTR  lpstrQuality;
}

///The <b>MCI_DGV_SIGNAL_PARMS</b> structure contains parameters for the MCI_SIGNAL command for digital-video devices.
struct MCI_DGV_SIGNAL_PARMS
{
align (1):
    ///The low-order word specifies a window handle used for the MCI_NOTIFY flag.
    size_t dwCallback;
    ///Position to be marked.
    uint   dwPosition;
    ///Interval of the position marks.
    uint   dwPeriod;
    ///User value associated with signals.
    uint   dwUserParm;
}

///The <b>MCI_DGV_SETVIDEO_PARMS</b> structure contains parameters for the MCI_SETVIDEO command for digital-video
///devices.
struct MCI_DGV_SETVIDEO_PARMSA
{
align (1):
    ///The low-order word specifies a window handle used for the MCI_NOTIFY flag.
    size_t dwCallback;
    ///Constant indicating the target adjustment.
    uint   dwItem;
    ///Adjustment level.
    uint   dwValue;
    ///Transmission length.
    uint   dwOver;
    ///Pointer to a null-terminated string containing the name of the video-compression algorithm.
    PSTR   lpstrAlgorithm;
    ///Pointer to a null-terminated string containing a descriptor of the video-compression algorithm.
    PSTR   lpstrQuality;
    ///Index of input source.
    uint   dwSourceNumber;
}

///The <b>MCI_DGV_SETVIDEO_PARMS</b> structure contains parameters for the MCI_SETVIDEO command for digital-video
///devices.
struct MCI_DGV_SETVIDEO_PARMSW
{
align (1):
    ///The low-order word specifies a window handle used for the MCI_NOTIFY flag.
    size_t dwCallback;
    ///Constant indicating the target adjustment.
    uint   dwItem;
    ///Adjustment level.
    uint   dwValue;
    ///Transmission length.
    uint   dwOver;
    ///Pointer to a null-terminated string containing the name of the video-compression algorithm.
    PWSTR  lpstrAlgorithm;
    ///Pointer to a null-terminated string containing a descriptor of the video-compression algorithm.
    PWSTR  lpstrQuality;
    ///Index of input source.
    uint   dwSourceNumber;
}

///The <b>MCI_DGV_STATUS_PARMS</b> structure contains parameters for the MCI_STATUS command for digital-video devices.
struct MCI_DGV_STATUS_PARMSA
{
align (1):
    ///The low-order word specifies a window handle used for the MCI_NOTIFY flag.
    size_t dwCallback;
    ///Buffer for return information.
    size_t dwReturn;
    ///Identifies capability being queried.
    uint   dwItem;
    ///Length or number of tracks.
    uint   dwTrack;
    ///Specifies the approximate amount of disk space that can be obtained by the MCI_RESERVE command.
    PSTR   lpstrDrive;
    ///Specifies the approximate location of the nearest previous intraframe-encoded image.
    uint   dwReference;
}

///The <b>MCI_DGV_STATUS_PARMS</b> structure contains parameters for the MCI_STATUS command for digital-video devices.
struct MCI_DGV_STATUS_PARMSW
{
align (1):
    ///The low-order word specifies a window handle used for the MCI_NOTIFY flag.
    size_t dwCallback;
    ///Buffer for return information.
    size_t dwReturn;
    ///Identifies capability being queried.
    uint   dwItem;
    ///Length or number of tracks.
    uint   dwTrack;
    ///Specifies the approximate amount of disk space that can be obtained by the MCI_RESERVE command.
    PWSTR  lpstrDrive;
    ///Specifies the approximate location of the nearest previous intraframe-encoded image.
    uint   dwReference;
}

///The <b>MCI_DGV_STEP_PARMS</b> structure contains parameters for the MCI_STEP command for digital-video devices.
struct MCI_DGV_STEP_PARMS
{
align (1):
    ///The low-order word specifies a window handle used for the MCI_NOTIFY flag.
    size_t dwCallback;
    ///Number of frames to step.
    uint   dwFrames;
}

///The <b>MCI_DGV_UPDATE_PARMS</b> structure contains parameters for the MCI_UPDATE command.
struct MCI_DGV_UPDATE_PARMS
{
align (1):
    ///The low-order word specifies a window handle used for the MCI_NOTIFY flag.
    size_t dwCallback;
    ///Rectangle containing positioning information. RECT structures are handled differently in MCI than in other parts
    ///of Windows; in MCI, <b>rc.right</b> contains the width of the rectangle and <b>rc.bottom</b> contains its height.
    RECT   rc;
    ///Handle to display context.
    HDC    hDC;
}

///The <b>MCI_DGV_WINDOW_PARMS</b> structure contains parameters for MCI_WINDOW command for digital-video devices.
struct MCI_DGV_WINDOW_PARMSA
{
align (1):
    ///The low-order word specifies a window handle used for the MCI_NOTIFY flag.
    size_t dwCallback;
    ///Handle to the display window. If this member is MCI_DGV_WINDOW_HWND, the system uses a default window.
    HWND   hWnd;
    ///Window-display command.
    uint   nCmdShow;
    ///Window caption.
    PSTR   lpstrText;
}

///The <b>MCI_DGV_WINDOW_PARMS</b> structure contains parameters for MCI_WINDOW command for digital-video devices.
struct MCI_DGV_WINDOW_PARMSW
{
align (1):
    ///The low-order word specifies a window handle used for the MCI_NOTIFY flag.
    size_t dwCallback;
    ///Handle to the display window. If this member is MCI_DGV_WINDOW_HWND, the system uses a default window.
    HWND   hWnd;
    ///Window-display command.
    uint   nCmdShow;
    ///Window caption.
    PWSTR  lpstrText;
}

struct HACMDRIVERID__
{
align (1):
    int unused;
}

struct HACMDRIVER__
{
align (1):
    int unused;
}

struct HACMSTREAM__
{
align (1):
    int unused;
}

struct HACMOBJ__
{
align (1):
    int unused;
}

struct tACMDRIVERDETAILSA
{
align (1):
    uint      cbStruct;
    uint      fccType;
    uint      fccComp;
    ushort    wMid;
    ushort    wPid;
    uint      vdwACM;
    uint      vdwDriver;
    uint      fdwSupport;
    uint      cFormatTags;
    uint      cFilterTags;
    HICON     hicon;
    byte[32]  szShortName;
    byte[128] szLongName;
    byte[80]  szCopyright;
    byte[128] szLicensing;
    byte[512] szFeatures;
}

struct tACMDRIVERDETAILSW
{
align (1):
    uint        cbStruct;
    uint        fccType;
    uint        fccComp;
    ushort      wMid;
    ushort      wPid;
    uint        vdwACM;
    uint        vdwDriver;
    uint        fdwSupport;
    uint        cFormatTags;
    uint        cFilterTags;
    HICON       hicon;
    ushort[32]  szShortName;
    ushort[128] szLongName;
    ushort[80]  szCopyright;
    ushort[128] szLicensing;
    ushort[512] szFeatures;
}

struct tACMFORMATTAGDETAILSA
{
align (1):
    uint     cbStruct;
    uint     dwFormatTagIndex;
    uint     dwFormatTag;
    uint     cbFormatSize;
    uint     fdwSupport;
    uint     cStandardFormats;
    byte[48] szFormatTag;
}

struct tACMFORMATTAGDETAILSW
{
align (1):
    uint       cbStruct;
    uint       dwFormatTagIndex;
    uint       dwFormatTag;
    uint       cbFormatSize;
    uint       fdwSupport;
    uint       cStandardFormats;
    ushort[48] szFormatTag;
}

struct tACMFORMATDETAILSA
{
align (1):
    uint          cbStruct;
    uint          dwFormatIndex;
    uint          dwFormatTag;
    uint          fdwSupport;
    WAVEFORMATEX* pwfx;
    uint          cbwfx;
    byte[128]     szFormat;
}

struct tACMFORMATDETAILSW
{
align (1):
    uint          cbStruct;
    uint          dwFormatIndex;
    uint          dwFormatTag;
    uint          fdwSupport;
    WAVEFORMATEX* pwfx;
    uint          cbwfx;
    ushort[128]   szFormat;
}

struct tACMFORMATCHOOSEA
{
align (1):
    uint          cbStruct;
    uint          fdwStyle;
    HWND          hwndOwner;
    WAVEFORMATEX* pwfx;
    uint          cbwfx;
    const(PSTR)   pszTitle;
    byte[48]      szFormatTag;
    byte[128]     szFormat;
    PSTR          pszName;
    uint          cchName;
    uint          fdwEnum;
    WAVEFORMATEX* pwfxEnum;
    HINSTANCE     hInstance;
    const(PSTR)   pszTemplateName;
    LPARAM        lCustData;
    ACMFORMATCHOOSEHOOKPROCA pfnHook;
}

struct tACMFORMATCHOOSEW
{
align (1):
    uint          cbStruct;
    uint          fdwStyle;
    HWND          hwndOwner;
    WAVEFORMATEX* pwfx;
    uint          cbwfx;
    const(PWSTR)  pszTitle;
    ushort[48]    szFormatTag;
    ushort[128]   szFormat;
    PWSTR         pszName;
    uint          cchName;
    uint          fdwEnum;
    WAVEFORMATEX* pwfxEnum;
    HINSTANCE     hInstance;
    const(PWSTR)  pszTemplateName;
    LPARAM        lCustData;
    ACMFORMATCHOOSEHOOKPROCW pfnHook;
}

struct tACMFILTERTAGDETAILSA
{
align (1):
    uint     cbStruct;
    uint     dwFilterTagIndex;
    uint     dwFilterTag;
    uint     cbFilterSize;
    uint     fdwSupport;
    uint     cStandardFilters;
    byte[48] szFilterTag;
}

struct tACMFILTERTAGDETAILSW
{
align (1):
    uint       cbStruct;
    uint       dwFilterTagIndex;
    uint       dwFilterTag;
    uint       cbFilterSize;
    uint       fdwSupport;
    uint       cStandardFilters;
    ushort[48] szFilterTag;
}

struct tACMFILTERDETAILSA
{
align (1):
    uint        cbStruct;
    uint        dwFilterIndex;
    uint        dwFilterTag;
    uint        fdwSupport;
    WAVEFILTER* pwfltr;
    uint        cbwfltr;
    byte[128]   szFilter;
}

struct tACMFILTERDETAILSW
{
align (1):
    uint        cbStruct;
    uint        dwFilterIndex;
    uint        dwFilterTag;
    uint        fdwSupport;
    WAVEFILTER* pwfltr;
    uint        cbwfltr;
    ushort[128] szFilter;
}

struct tACMFILTERCHOOSEA
{
align (1):
    uint        cbStruct;
    uint        fdwStyle;
    HWND        hwndOwner;
    WAVEFILTER* pwfltr;
    uint        cbwfltr;
    const(PSTR) pszTitle;
    byte[48]    szFilterTag;
    byte[128]   szFilter;
    PSTR        pszName;
    uint        cchName;
    uint        fdwEnum;
    WAVEFILTER* pwfltrEnum;
    HINSTANCE   hInstance;
    const(PSTR) pszTemplateName;
    LPARAM      lCustData;
    ACMFILTERCHOOSEHOOKPROCA pfnHook;
}

struct tACMFILTERCHOOSEW
{
align (1):
    uint         cbStruct;
    uint         fdwStyle;
    HWND         hwndOwner;
    WAVEFILTER*  pwfltr;
    uint         cbwfltr;
    const(PWSTR) pszTitle;
    ushort[48]   szFilterTag;
    ushort[128]  szFilter;
    PWSTR        pszName;
    uint         cchName;
    uint         fdwEnum;
    WAVEFILTER*  pwfltrEnum;
    HINSTANCE    hInstance;
    const(PWSTR) pszTemplateName;
    LPARAM       lCustData;
    ACMFILTERCHOOSEHOOKPROCW pfnHook;
}

///The <b>ACMSTREAMHEADER</b> structure defines the header used to identify an ACM conversion source and destination
///buffer pair for a conversion stream.
struct ACMSTREAMHEADER
{
align (1):
    ///Size, in bytes, of the <b>ACMSTREAMHEADER</b> structure. This member must be initialized before the application
    ///calls any ACM stream functions using this structure. The size specified in this member must be large enough to
    ///contain the base <b>ACMSTREAMHEADER</b> structure.
    uint     cbStruct;
    ///Flags giving information about the conversion buffers. This member must be initialized to zero before the
    ///application calls the acmStreamPrepareHeader function and should not be modified by the application while the
    ///stream header remains prepared. <table> <tr> <th>Name</th> <th>Description</th> </tr> <tr> <td width="40%"><a
    ///id="ACMSTREAMHEADER_STATUSF_DONE"></a><a id="acmstreamheader_statusf_done"></a><dl>
    ///<dt><b>ACMSTREAMHEADER_STATUSF_DONE</b></dt> </dl> </td> <td width="60%"> Set by the ACM or driver to indicate
    ///that it is finished with the conversion and is returning the buffers to the application. </td> </tr> <tr> <td
    ///width="40%"><a id="ACMSTREAMHEADER_STATUSF_INQUEUE"></a><a id="acmstreamheader_statusf_inqueue"></a><dl>
    ///<dt><b>ACMSTREAMHEADER_STATUSF_INQUEUE</b></dt> </dl> </td> <td width="60%"> Set by the ACM or driver to indicate
    ///that the buffers are queued for conversion. </td> </tr> <tr> <td width="40%"><a
    ///id="ACMSTREAMHEADER_STATUSF_PREPARED"></a><a id="acmstreamheader_statusf_prepared"></a><dl>
    ///<dt><b>ACMSTREAMHEADER_STATUSF_PREPARED</b></dt> </dl> </td> <td width="60%"> Set by the ACM to indicate that the
    ///buffers have been prepared by using the acmStreamPrepareHeader function. </td> </tr> </table>
    uint     fdwStatus;
    ///User data. This can be any instance data specified by the application.
    size_t   dwUser;
    ///Pointer to the source buffer. This pointer must always refer to the same location while the stream header remains
    ///prepared. If an application needs to change the source location, it must unprepare the header and reprepare it
    ///with the alternate location.
    ubyte*   pbSrc;
    ///Length, in bytes, of the source buffer pointed to by <b>pbSrc</b>. When the header is prepared, this member must
    ///specify the maximum size that will be used in the source buffer. Conversions can be performed on source lengths
    ///less than or equal to the original prepared size. However, this member must be reset to the original size when an
    ///application unprepares the header.
    uint     cbSrcLength;
    ///Amount of data, in bytes, used for the conversion. This member is not valid until the conversion is complete.
    ///This value can be less than or equal to <b>cbSrcLength</b>. An application must use the <b>cbSrcLengthUsed</b>
    ///member when advancing to the next piece of source data for the conversion stream.
    uint     cbSrcLengthUsed;
    ///User data. This can be any instance data specified by the application.
    size_t   dwSrcUser;
    ///Pointer to the destination buffer. This pointer must always refer to the same location while the stream header
    ///remains prepared. If an application needs to change the destination location, it must unprepare the header and
    ///reprepare it with the alternate location.
    ubyte*   pbDst;
    ///Length, in bytes, of the destination buffer pointed to by <b>pbDst</b>. When the header is prepared, this member
    ///must specify the maximum size that will be used in the destination buffer.
    uint     cbDstLength;
    ///Amount of data, in bytes, returned by a conversion. This member is not valid until the conversion is complete.
    ///This value can be less than or equal to <b>cbDstLength</b>. An application must use the <b>cbDstLengthUsed</b>
    ///member when advancing to the next destination location for the conversion stream.
    uint     cbDstLengthUsed;
    ///User data. This can be any instance data specified by the application.
    size_t   dwDstUser;
    ///Reserved; do not use. This member requires no initialization by the application and should never be modified
    ///while the header remains prepared.
    uint[10] dwReservedDriver;
}

struct HIC__
{
    int unused;
}

///The <b>ICOPEN</b> structure contains information about the data stream being compressed or decompressed, the version
///number of the driver, and how the driver is used.
struct ICOPEN
{
    ///Size, in bytes, of the structure.
    uint    dwSize;
    ///Four-character code indicating the type of stream being compressed or decompressed. Specify "VIDC" for video
    ///streams.
    uint    fccType;
    ///Four-character code identifying a specific compressor.
    uint    fccHandler;
    ///Version of the installable driver interface used to open the driver.
    uint    dwVersion;
    ///Applicable flags indicating why the driver is opened. The following values are defined: <table> <tr>
    ///<th>Name</th> <th>Description</th> </tr> <tr> <td width="40%"><a id="ICMODE_COMPRESS"></a><a
    ///id="icmode_compress"></a><dl> <dt><b>ICMODE_COMPRESS</b></dt> </dl> </td> <td width="60%"> Driver is opened to
    ///compress data. </td> </tr> <tr> <td width="40%"><a id="ICMODE_DECOMPRESS"></a><a id="icmode_decompress"></a><dl>
    ///<dt><b>ICMODE_DECOMPRESS</b></dt> </dl> </td> <td width="60%"> Driver is opened to decompress data. </td> </tr>
    ///<tr> <td width="40%"><a id="ICMODE_DRAW"></a><a id="icmode_draw"></a><dl> <dt><b>ICMODE_DRAW</b></dt> </dl> </td>
    ///<td width="60%"> Device driver is opened to decompress data directly to hardware. </td> </tr> <tr> <td
    ///width="40%"><a id="ICMODE_QUERY"></a><a id="icmode_query"></a><dl> <dt><b>ICMODE_QUERY</b></dt> </dl> </td> <td
    ///width="60%"> Driver is opened for informational purposes, rather than for compression. </td> </tr> </table>
    uint    dwFlags;
    LRESULT dwError;
    ///Reserved; do not use.
    void*   pV1Reserved;
    ///Reserved; do not use.
    void*   pV2Reserved;
    ///Device node for plug and play devices.
    uint    dnDevNode;
}

///The <b>ICINFO</b> structure contains compression parameters supplied by a video compression driver. The driver fills
///or updates the structure when it receives the ICM_GETINFO message.
struct ICINFO
{
    ///Size, in bytes, of the <b>ICINFO</b> structure.
    uint        dwSize;
    ///Four-character code indicating the type of stream being compressed or decompressed. Specify "VIDC" for video
    ///streams.
    uint        fccType;
    ///A four-character code identifying a specific compressor.
    uint        fccHandler;
    ///Applicable flags. Zero or more of the following flags can be set: <table> <tr> <th>Name</th> <th>Description</th>
    ///</tr> <tr> <td width="40%"><a id="VIDCF_COMPRESSFRAMES"></a><a id="vidcf_compressframes"></a><dl>
    ///<dt><b>VIDCF_COMPRESSFRAMES</b></dt> </dl> </td> <td width="60%"> Driver is requesting to compress all frames.
    ///For information about compressing all frames, see the ICM_COMPRESS_FRAMES_INFO message. </td> </tr> <tr> <td
    ///width="40%"><a id="VIDCF_CRUNCH"></a><a id="vidcf_crunch"></a><dl> <dt><b>VIDCF_CRUNCH</b></dt> </dl> </td> <td
    ///width="60%"> Driver supports compressing to a frame size. </td> </tr> <tr> <td width="40%"><a
    ///id="VIDCF_DRAW"></a><a id="vidcf_draw"></a><dl> <dt><b>VIDCF_DRAW</b></dt> </dl> </td> <td width="60%"> Driver
    ///supports drawing. </td> </tr> <tr> <td width="40%"><a id="VIDCF_FASTTEMPORALC"></a><a
    ///id="vidcf_fasttemporalc"></a><dl> <dt><b>VIDCF_FASTTEMPORALC</b></dt> </dl> </td> <td width="60%"> Driver can
    ///perform temporal compression and maintains its own copy of the current frame. When compressing a stream of frame
    ///data, the driver doesn't need image data from the previous frame. </td> </tr> <tr> <td width="40%"><a
    ///id="VIDCF_FASTTEMPORALD"></a><a id="vidcf_fasttemporald"></a><dl> <dt><b>VIDCF_FASTTEMPORALD</b></dt> </dl> </td>
    ///<td width="60%"> Driver can perform temporal decompression and maintains its own copy of the current frame. When
    ///decompressing a stream of frame data, the driver doesn't need image data from the previous frame. </td> </tr>
    ///<tr> <td width="40%"><a id="VIDCF_QUALITY"></a><a id="vidcf_quality"></a><dl> <dt><b>VIDCF_QUALITY</b></dt> </dl>
    ///</td> <td width="60%"> Driver supports quality values. </td> </tr> <tr> <td width="40%"><a
    ///id="VIDCF_TEMPORAL"></a><a id="vidcf_temporal"></a><dl> <dt><b>VIDCF_TEMPORAL</b></dt> </dl> </td> <td
    ///width="60%"> Driver supports inter-frame compression. </td> </tr> </table>
    uint        dwFlags;
    ///Version number of the driver.
    uint        dwVersion;
    ///Version of VCM supported by the driver. This member should be set to ICVERSION.
    uint        dwVersionICM;
    ///Short version of the compressor name. The name in the null-terminated string should be suitable for use in list
    ///boxes.
    ushort[16]  szName;
    ///Long version of the compressor name.
    ushort[128] szDescription;
    ///Name of the module containing VCM compression driver. Normally, a driver does not need to fill this out.
    ushort[128] szDriver;
}

///The <b>ICCOMPRESS</b> structure contains compression parameters used with the ICM_COMPRESS message.
struct ICCOMPRESS
{
    ///Flags used for compression. The following value is defined: <table> <tr> <th>Name</th> <th>Description</th> </tr>
    ///<tr> <td width="40%"><a id="ICCOMPRESS_KEYFRAME"></a><a id="iccompress_keyframe"></a><dl>
    ///<dt><b>ICCOMPRESS_KEYFRAME</b></dt> </dl> </td> <td width="60%"> Input data should be treated as a key frame.
    ///</td> </tr> </table>
    uint              dwFlags;
    ///Pointer to a BITMAPINFOHEADER structure containing the output (compressed) format. The <b>biSizeImage</b> member
    ///must contain the size of the compressed data.
    BITMAPINFOHEADER* lpbiOutput;
    ///Pointer to the buffer where the driver should write the compressed data.
    void*             lpOutput;
    ///Pointer to a BITMAPINFOHEADER structure containing the input (uncompressed) format.
    BITMAPINFOHEADER* lpbiInput;
    ///Pointer to the buffer containing input data.
    void*             lpInput;
    ///Address to contain the chunk identifier for data in the AVI file. If the value of this member is not <b>NULL</b>,
    ///the driver should specify a two-character code for the chunk identifier corresponding to the chunk identifier
    ///used in the AVI file.
    uint*             lpckid;
    ///Address to contain flags for the AVI index. If the returned frame is a key frame, the driver should set the
    ///<b>AVIIF_KEYFRAME</b> flag.
    uint*             lpdwFlags;
    ///Number of the frame to compress.
    int               lFrameNum;
    ///Desired maximum size, in bytes, for compressing this frame. The size value is used for compression methods that
    ///can make tradeoffs between compressed image size and image quality. Specify zero for this member to use the
    ///default setting.
    uint              dwFrameSize;
    ///Quality setting.
    uint              dwQuality;
    ///Pointer to a BITMAPINFOHEADER structure containing the format of the previous frame, which is typically the same
    ///as the input format.
    BITMAPINFOHEADER* lpbiPrev;
    ///Pointer to the buffer containing input data of the previous frame.
    void*             lpPrev;
}

///The <b>ICCOMPRESSFRAMES</b> structure contains compression parameters used with the ICM_COMPRESS_FRAMES_INFO message.
struct ICCOMPRESSFRAMES
{
    ///Applicable flags. The following value is defined: <b>ICCOMPRESSFRAMES_PADDING</b>. If this value is used, padding
    ///is used with the frame.
    uint              dwFlags;
    ///Pointer to a BITMAPINFOHEADER structure containing the output format.
    BITMAPINFOHEADER* lpbiOutput;
    ///Reserved; do not use.
    LPARAM            lOutput;
    ///Pointer to a BITMAPINFOHEADER structure containing the input format.
    BITMAPINFOHEADER* lpbiInput;
    ///Reserved; do not use.
    LPARAM            lInput;
    ///Number of the first frame to compress.
    int               lStartFrame;
    ///Number of frames to compress.
    int               lFrameCount;
    ///Quality setting.
    int               lQuality;
    ///Maximum data rate, in bytes per second.
    int               lDataRate;
    ///Maximum number of frames between consecutive key frames.
    int               lKeyRate;
    ///Compression rate in an integer format. To obtain the rate in frames per second, divide this value by the value in
    ///<b>dwScale</b>.
    uint              dwRate;
    ///Value used to scale <b>dwRate</b> to frames per second.
    uint              dwScale;
    ///Reserved; do not use.
    uint              dwOverheadPerFrame;
    ///Reserved; do not use.
    uint              dwReserved2;
    ///Reserved; do not use.
    ptrdiff_t         GetData;
    ///Reserved; do not use.
    ptrdiff_t         PutData;
}

///The <b>ICSETSTATUSPROC</b> structure contains status information used with the ICM_SET_STATUS_PROC message.
struct ICSETSTATUSPROC
{
    ///Reserved; set to zero.
    uint      dwFlags;
    ///Parameter that contains a constant to pass to the status procedure.
    LPARAM    lParam;
    ptrdiff_t Status;
}

///The <b>ICDECOMPRESS</b> structure contains decompression parameters used with the ICM_DECOMPRESS message.
struct ICDECOMPRESS
{
    ///Applicable flags. The following values are defined: <table> <tr> <th>Name</th> <th>Description</th> </tr> <tr>
    ///<td width="40%"><a id="ICDECOMPRESS_HURRYUP"></a><a id="icdecompress_hurryup"></a><dl>
    ///<dt><b>ICDECOMPRESS_HURRYUP</b></dt> </dl> </td> <td width="60%"> Tries to decompress at a faster rate. When an
    ///application uses this flag, the driver should buffer the decompressed data but not draw the image. </td> </tr>
    ///<tr> <td width="40%"><a id="ICDECOMPRESS_NOTKEYFRAME"></a><a id="icdecompress_notkeyframe"></a><dl>
    ///<dt><b>ICDECOMPRESS_NOTKEYFRAME</b></dt> </dl> </td> <td width="60%"> Current frame is not a key frame. </td>
    ///</tr> <tr> <td width="40%"><a id="ICDECOMPRESS_NULLFRAME"></a><a id="icdecompress_nullframe"></a><dl>
    ///<dt><b>ICDECOMPRESS_NULLFRAME</b></dt> </dl> </td> <td width="60%"> Current frame does not contain data and the
    ///decompressed image should be left the same. </td> </tr> <tr> <td width="40%"><a id="ICDECOMPRESS_PREROLL"></a><a
    ///id="icdecompress_preroll"></a><dl> <dt><b>ICDECOMPRESS_PREROLL</b></dt> </dl> </td> <td width="60%"> Current
    ///frame precedes the point in the movie where playback starts and, therefore, will not be drawn. </td> </tr> <tr>
    ///<td width="40%"><a id="ICDECOMPRESS_UPDATE"></a><a id="icdecompress_update"></a><dl>
    ///<dt><b>ICDECOMPRESS_UPDATE</b></dt> </dl> </td> <td width="60%"> Screen is being updated or refreshed. </td>
    ///</tr> </table>
    uint              dwFlags;
    ///Pointer to a BITMAPINFOHEADER structure containing the input format.
    BITMAPINFOHEADER* lpbiInput;
    ///Pointer to a buffer containing the input data.
    void*             lpInput;
    ///Pointer to a BITMAPINFOHEADER structure containing the output format.
    BITMAPINFOHEADER* lpbiOutput;
    ///Pointer to a buffer where the driver should write the decompressed image.
    void*             lpOutput;
    ///Chunk identifier from the AVI file.
    uint              ckid;
}

///The <b>ICDECOMPRESSEX</b> structure contains decompression parameters used with the ICM_DECOMPRESSEX message
struct ICDECOMPRESSEX
{
    ///Applicable flags. The following values are defined: <table> <tr> <th>Name</th> <th>Description</th> </tr> <tr>
    ///<td width="40%"><a id="ICDECOMPRESS_HURRYUP"></a><a id="icdecompress_hurryup"></a><dl>
    ///<dt><b>ICDECOMPRESS_HURRYUP</b></dt> </dl> </td> <td width="60%"> Tries to decompress at a faster rate. When an
    ///application uses this flag, the driver should buffer the decompressed data but not draw the image. </td> </tr>
    ///<tr> <td width="40%"><a id="ICDECOMPRESS_NOTKEYFRAME"></a><a id="icdecompress_notkeyframe"></a><dl>
    ///<dt><b>ICDECOMPRESS_NOTKEYFRAME</b></dt> </dl> </td> <td width="60%"> Current frame is not a key frame. </td>
    ///</tr> <tr> <td width="40%"><a id="ICDECOMPRESS_NULLFRAME"></a><a id="icdecompress_nullframe"></a><dl>
    ///<dt><b>ICDECOMPRESS_NULLFRAME</b></dt> </dl> </td> <td width="60%"> Current frame does not contain data and the
    ///decompressed image should be left the same. </td> </tr> <tr> <td width="40%"><a id="ICDECOMPRESS_PREROLL"></a><a
    ///id="icdecompress_preroll"></a><dl> <dt><b>ICDECOMPRESS_PREROLL</b></dt> </dl> </td> <td width="60%"> Current
    ///frame precedes the point in the movie where playback starts and, therefore, will not be drawn. </td> </tr> <tr>
    ///<td width="40%"><a id="ICDECOMPRESS_UPDATE"></a><a id="icdecompress_update"></a><dl>
    ///<dt><b>ICDECOMPRESS_UPDATE</b></dt> </dl> </td> <td width="60%"> Screen is being updated or refreshed. </td>
    ///</tr> </table>
    uint              dwFlags;
    ///Pointer to a BITMAPINFOHEADER structure containing the input format.
    BITMAPINFOHEADER* lpbiSrc;
    ///Pointer to a buffer containing the input data.
    void*             lpSrc;
    ///Pointer to a BITMAPINFOHEADER structure containing the output format.
    BITMAPINFOHEADER* lpbiDst;
    ///Pointer to a buffer where the driver should write the decompressed image.
    void*             lpDst;
    ///The x-coordinate of the destination rectangle within the DIB specified by <b>lpbiDst</b>.
    int               xDst;
    ///The y-coordinate of the destination rectangle within the DIB specified by <b>lpbiDst</b>.
    int               yDst;
    ///Width of the destination rectangle.
    int               dxDst;
    ///Height of the destination rectangle.
    int               dyDst;
    ///The x-coordinate of the source rectangle within the DIB specified by <b>lpbiSrc</b>.
    int               xSrc;
    ///The y-coordinate of the source rectangle within the DIB specified by <b>lpbiSrc</b>.
    int               ySrc;
    ///Width of the source rectangle.
    int               dxSrc;
    ///Height of the source rectangle.
    int               dySrc;
}

///The <b>ICDRAWBEGIN</b> structure contains decompression parameters used with the ICM_DRAW_BEGIN message.
struct ICDRAWBEGIN
{
    ///Applicable flags. The following values are defined: <table> <tr> <th>Name</th> <th>Description</th> </tr> <tr>
    ///<td width="40%"><a id="ICDRAW_ANIMATE"></a><a id="icdraw_animate"></a><dl> <dt><b>ICDRAW_ANIMATE</b></dt> </dl>
    ///</td> <td width="60%"> Application can animate the palette. </td> </tr> <tr> <td width="40%"><a
    ///id="ICDRAW_BUFFER"></a><a id="icdraw_buffer"></a><dl> <dt><b>ICDRAW_BUFFER</b></dt> </dl> </td> <td width="60%">
    ///Buffers this data off-screen; it will need to be updated. </td> </tr> <tr> <td width="40%"><a
    ///id="ICDRAW_CONTINUE"></a><a id="icdraw_continue"></a><dl> <dt><b>ICDRAW_CONTINUE</b></dt> </dl> </td> <td
    ///width="60%"> Drawing is a continuation of the previous frame. </td> </tr> <tr> <td width="40%"><a
    ///id="ICDRAW_FULLSCREEN"></a><a id="icdraw_fullscreen"></a><dl> <dt><b>ICDRAW_FULLSCREEN</b></dt> </dl> </td> <td
    ///width="60%"> Draws the decompressed data on the full screen. </td> </tr> <tr> <td width="40%"><a
    ///id="ICDRAW_HDC"></a><a id="icdraw_hdc"></a><dl> <dt><b>ICDRAW_HDC</b></dt> </dl> </td> <td width="60%"> Draws the
    ///decompressed data to a window or a DC. </td> </tr> <tr> <td width="40%"><a id="ICDRAW_MEMORYDC"></a><a
    ///id="icdraw_memorydc"></a><dl> <dt><b>ICDRAW_MEMORYDC</b></dt> </dl> </td> <td width="60%"> DC is off-screen.
    ///</td> </tr> <tr> <td width="40%"><a id="ICDRAW_QUERY"></a><a id="icdraw_query"></a><dl>
    ///<dt><b>ICDRAW_QUERY</b></dt> </dl> </td> <td width="60%"> Determines if the decompressor can handle the
    ///decompression. The driver does not actually decompress the data. </td> </tr> <tr> <td width="40%"><a
    ///id="ICDRAW_RENDER"></a><a id="icdraw_render"></a><dl> <dt><b>ICDRAW_RENDER</b></dt> </dl> </td> <td width="60%">
    ///Renders but does not draw the data. </td> </tr> <tr> <td width="40%"><a id="ICDRAW_UPDATING"></a><a
    ///id="icdraw_updating"></a><dl> <dt><b>ICDRAW_UPDATING</b></dt> </dl> </td> <td width="60%"> Current frame is being
    ///updated rather than played. </td> </tr> </table>
    uint              dwFlags;
    ///Handle to the palette used for drawing.
    HPALETTE          hpal;
    ///Handle to the window used for drawing.
    HWND              hwnd;
    ///Handle to the DC used for drawing. Specify <b>NULL</b> to use a DC associated with the specified window.
    HDC               hdc;
    ///The x-coordinate of the destination rectangle.
    int               xDst;
    ///The y-coordinate of the destination rectangle.
    int               yDst;
    ///Width of the destination rectangle.
    int               dxDst;
    ///Height of the destination rectangle.
    int               dyDst;
    ///Pointer to a BITMAPINFOHEADER structure containing the input format.
    BITMAPINFOHEADER* lpbi;
    ///The x-coordinate of the source rectangle.
    int               xSrc;
    ///The y-coordinate of the source rectangle.
    int               ySrc;
    ///Width of the source rectangle.
    int               dxSrc;
    ///Height of the source rectangle.
    int               dySrc;
    ///Decompression rate in an integer format. To obtain the rate in frames per second, divide this value by the value
    ///in <b>dwScale</b>.
    uint              dwRate;
    ///Value used to scale <b>dwRate</b> to frames per second.
    uint              dwScale;
}

///The <b>ICDRAW</b> structure contains parameters for drawing video data to the screen. This structure is used with the
///ICM_DRAW message.
struct ICDRAW
{
    ///Flags from the AVI file index. The following values are defined: <table> <tr> <th>Name</th> <th>Description</th>
    ///</tr> <tr> <td width="40%"><a id="ICDRAW_HURRYUP"></a><a id="icdraw_hurryup"></a><dl>
    ///<dt><b>ICDRAW_HURRYUP</b></dt> </dl> </td> <td width="60%"> Data is buffered and not drawn to the screen. Use
    ///this flag for fastest decompression. </td> </tr> <tr> <td width="40%"><a id="ICDRAW_NOTKEYFRAME"></a><a
    ///id="icdraw_notkeyframe"></a><dl> <dt><b>ICDRAW_NOTKEYFRAME</b></dt> </dl> </td> <td width="60%"> Current frame is
    ///not a key frame. </td> </tr> <tr> <td width="40%"><a id="ICDRAW_NULLFRAME"></a><a id="icdraw_nullframe"></a><dl>
    ///<dt><b>ICDRAW_NULLFRAME</b></dt> </dl> </td> <td width="60%"> Current frame does not contain any data, and the
    ///previous frame should be redrawn. </td> </tr> <tr> <td width="40%"><a id="ICDRAW_PREROLL"></a><a
    ///id="icdraw_preroll"></a><dl> <dt><b>ICDRAW_PREROLL</b></dt> </dl> </td> <td width="60%"> Current frame of video
    ///occurs before playback should start. For example, if playback will begin on frame 10, and frame 0 is the nearest
    ///previous key frame, frames 0 through 9 are sent to the driver with this flag set. The driver needs this data to
    ///display frame 10 properly. </td> </tr> <tr> <td width="40%"><a id="ICDRAW_UPDATE"></a><a
    ///id="icdraw_update"></a><dl> <dt><b>ICDRAW_UPDATE</b></dt> </dl> </td> <td width="60%"> Updates the screen based
    ///on data previously received. In this case, <b>lpData</b> should be ignored. </td> </tr> </table>
    uint  dwFlags;
    ///Pointer to a structure containing the data format. For video streams, this is a BITMAPINFOHEADER structure.
    void* lpFormat;
    ///Pointer to the data to render.
    void* lpData;
    ///Number of data bytes to render.
    uint  cbData;
    ///Time, in samples, when this data should be drawn. For video data this is normally a frame number.
    int   lTime;
}

///The <b>ICDRAWSUGGEST</b> structure contains compression parameters used with the ICM_DRAW_SUGGESTFORMAT message to
///suggest an appropriate input format.
struct ICDRAWSUGGEST
{
    ///Pointer to the structure containing the compressed input format.
    BITMAPINFOHEADER* lpbiIn;
    ///Pointer to a buffer to return a compatible input format for the renderer.
    BITMAPINFOHEADER* lpbiSuggest;
    ///Width of the source rectangle.
    int               dxSrc;
    ///Height of the source rectangle.
    int               dySrc;
    ///Width of the destination rectangle.
    int               dxDst;
    ///Height of the destination rectangle.
    int               dyDst;
    ///Handle to a decompressor that supports the format of data described in <b>lpbiIn</b>.
    HIC__*            hicDecompressor;
}

struct ICPALETTE
{
    uint          dwFlags;
    int           iStart;
    int           iLen;
    PALETTEENTRY* lppe;
}

///The <b>COMPVARS</b> structure describes compressor settings for functions such as ICCompressorChoose,
///ICSeqCompressFrame, and ICCompressorFree.
struct COMPVARS
{
    ///Size, in bytes, of this structure. This member must be set to validate the structure before calling any function
    ///using this structure.
    int         cbSize;
    ///Applicable flags. The following value is defined: <table> <tr> <th>Name</th> <th>Description</th> </tr> <tr> <td
    ///width="40%"><a id="ICMF_COMPVARS_VALID"></a><a id="icmf_compvars_valid"></a><dl>
    ///<dt><b>ICMF_COMPVARS_VALID</b></dt> </dl> </td> <td width="60%"> Data in this structure is valid and has been
    ///manually entered. Set this flag before you call any function if you fill this structure manually. Do not set this
    ///flag if you let ICCompressorChoose initialize this structure. </td> </tr> </table>
    uint        dwFlags;
    ///Handle to the compressor to use. You can open a compressor and obtain a handle of it by using the ICOpen
    ///function. You can also choose a compressor by using ICCompressorChoose. <b>ICCompressorChoose</b> opens the
    ///chosen compressor and returns the handle of the compressor in this member. You can close the compressor by using
    ///ICCompressorFree.
    HIC__*      hic;
    ///Type of compressor used. Currently only <b>ICTYPE_VIDEO</b> (VIDC) is supported. This member can be set to zero.
    uint        fccType;
    ///Four-character code of the compressor. Specify <b>NULL</b> to indicate the data is not to be recompressed.
    ///Specify "DIB" to indicate the data is an uncompressed, full frame. You can use this member to specify which
    ///compressor is selected by default when the dialog box is displayed.
    uint        fccHandler;
    ///Reserved; do not use.
    BITMAPINFO* lpbiIn;
    ///Pointer to a BITMAPINFO structure containing the image output format. You can specify a specific format to use or
    ///you can specify <b>NULL</b> to use the default compressor associated with the input format. You can also set the
    ///image output format by using ICCompressorChoose.
    BITMAPINFO* lpbiOut;
    ///Reserved; do not use.
    void*       lpBitsOut;
    ///Reserved; do not use.
    void*       lpBitsPrev;
    ///Reserved; do not use.
    int         lFrame;
    ///Key-frame rate. Specify an integer to indicate the frequency that key frames are to occur in the compressed
    ///sequence or zero to not use key frames. You can also let ICCompressorChoose set the key-frame rate selected in
    ///the dialog box. The ICSeqCompressFrameStart function uses the value of this member for making key frames.
    int         lKey;
    ///Data rate, in kilobytes per second. ICCompressorChoose copies the selected data rate from the dialog box to this
    ///member.
    int         lDataRate;
    ///Quality setting. Specify a quality setting of 1 to 10,000 or specify<b> ICQUALITY_DEFAULT</b> to use the default
    ///quality setting. You can also let ICCompressorChoose set the quality value selected in the dialog box.
    ///ICSeqCompressFrameStart uses the value of this member as its quality setting.
    int         lQ;
    ///Reserved; do not use.
    int         lKeyCount;
    ///Reserved; do not use.
    void*       lpState;
    ///Reserved; do not use.
    int         cbState;
}

///The <b>DRAWDIBTIME</b> structure contains elapsed timing information for performing a set of DrawDib operations. The
///DrawDibTime function resets the count and the elapsed time value for each operation each time it is called.
struct DRAWDIBTIME
{
    ///Number of times the following operations have been performed since DrawDibTime was last called: <ul> <li>Draw a
    ///bitmap on the screen.</li> <li>Decompress a bitmap.</li> <li>Dither a bitmap.</li> <li>Stretch a bitmap.</li>
    ///<li>Transfer bitmap data by using the BitBlt function.</li> <li>Transfer bitmap data by using the SetDIBits
    ///function.</li> </ul>
    int timeCount;
    ///Time to draw bitmaps.
    int timeDraw;
    ///Time to decompress bitmaps.
    int timeDecompress;
    ///Time to dither bitmaps.
    int timeDither;
    ///Time to stretch bitmaps.
    int timeStretch;
    ///Time to transfer bitmaps by using the BitBlt function.
    int timeBlt;
    ///Time to transfer bitmaps by using the SetDIBits function.
    int timeSetDIBits;
}

///The <b>AVISTREAMINFO</b> structure contains information for a single stream.
struct AVISTREAMINFOW
{
    ///Four-character code indicating the stream type. The following constants have been defined for the data commonly
    ///found in AVI streams: <table> <tr> <th>Constant</th> <th>Description</th> </tr> <tr> <td width="40%"><a
    ///id="streamtypeAUDIO"></a><a id="streamtypeaudio"></a><a id="STREAMTYPEAUDIO"></a><dl>
    ///<dt><b>streamtypeAUDIO</b></dt> </dl> </td> <td width="60%"> Indicates an audio stream. </td> </tr> <tr> <td
    ///width="40%"><a id="streamtypeMIDI"></a><a id="streamtypemidi"></a><a id="STREAMTYPEMIDI"></a><dl>
    ///<dt><b>streamtypeMIDI</b></dt> </dl> </td> <td width="60%"> Indicates a MIDI stream. </td> </tr> <tr> <td
    ///width="40%"><a id="streamtypeTEXT"></a><a id="streamtypetext"></a><a id="STREAMTYPETEXT"></a><dl>
    ///<dt><b>streamtypeTEXT</b></dt> </dl> </td> <td width="60%"> Indicates a text stream. </td> </tr> <tr> <td
    ///width="40%"><a id="streamtypeVIDEO"></a><a id="streamtypevideo"></a><a id="STREAMTYPEVIDEO"></a><dl>
    ///<dt><b>streamtypeVIDEO</b></dt> </dl> </td> <td width="60%"> Indicates a video stream. </td> </tr> </table>
    uint       fccType;
    ///Four-character code of the compressor handler that will compress this video stream when it is saved (for example,
    ///mmioFOURCC ('M','S','V','C')). This member is not used for audio streams.
    uint       fccHandler;
    ///Applicable flags for the stream. The bits in the high-order word of these flags are specific to the type of data
    ///contained in the stream. The following flags are defined: <table> <tr> <th>Name</th> <th>Description</th> </tr>
    ///<tr> <td width="40%"><a id="AVISTREAMINFO_DISABLED"></a><a id="avistreaminfo_disabled"></a><dl>
    ///<dt><b>AVISTREAMINFO_DISABLED</b></dt> </dl> </td> <td width="60%"> Indicates this stream should be rendered when
    ///explicitly enabled by the user. </td> </tr> <tr> <td width="40%"><a id="AVISTREAMINFO_FORMATCHANGES"></a><a
    ///id="avistreaminfo_formatchanges"></a><dl> <dt><b>AVISTREAMINFO_FORMATCHANGES</b></dt> </dl> </td> <td
    ///width="60%"> Indicates this video stream contains palette changes. This flag warns the playback software that it
    ///will need to animate the palette. </td> </tr> </table>
    uint       dwFlags;
    ///Capability flags; currently unused.
    uint       dwCaps;
    ///Priority of the stream.
    ushort     wPriority;
    ///Language of the stream.
    ushort     wLanguage;
    ///Time scale applicable for the stream. Dividing <b>dwRate</b> by <b>dwScale</b> gives the playback rate in number
    ///of samples per second. For video streams, this rate should be the frame rate. For audio streams, this rate should
    ///correspond to the audio block size (the <b>nBlockAlign</b> member of the WAVEFORMAT or PCMWAVEFORMAT structure),
    ///which for PCM (Pulse Code Modulation) audio reduces to the sample rate.
    uint       dwScale;
    ///Rate in an integer format. To obtain the rate in samples per second, divide this value by the value in
    ///<b>dwScale</b>.
    uint       dwRate;
    ///Sample number of the first frame of the AVI file. The units are defined by dwRate and <b>dwScale</b>. Normally,
    ///this is zero, but it can specify a delay time for a stream that does not start concurrently with the file. The
    ///1.0 release of the AVI tools does not support a nonzero starting time.
    uint       dwStart;
    ///Length of this stream. The units are defined by <b>dwRate</b> and <b>dwScale</b>.
    uint       dwLength;
    ///Audio skew. This member specifies how much to skew the audio data ahead of the video frames in interleaved files.
    ///Typically, this is about 0.75 seconds.
    uint       dwInitialFrames;
    ///Recommended buffer size, in bytes, for the stream. Typically, this member contains a value corresponding to the
    ///largest chunk in the stream. Using the correct buffer size makes playback more efficient. Use zero if you do not
    ///know the correct buffer size.
    uint       dwSuggestedBufferSize;
    ///Quality indicator of the video data in the stream. Quality is represented as a number between 0 and 10,000. For
    ///compressed data, this typically represents the value of the quality parameter passed to the compression software.
    ///If set to –1, drivers use the default quality value.
    uint       dwQuality;
    ///Size, in bytes, of a single data sample. If the value of this member is zero, the samples can vary in size and
    ///each data sample (such as a video frame) must be in a separate chunk. A nonzero value indicates that multiple
    ///samples of data can be grouped into a single chunk within the file. For video streams, this number is typically
    ///zero, although it can be nonzero if all video frames are the same size. For audio streams, this number should be
    ///the same as the <b>nBlockAlign</b> member of the WAVEFORMAT or WAVEFORMATEX structure describing the audio.
    uint       dwSampleSize;
    ///Dimensions of the video destination rectangle. The values represent the coordinates of upper left corner, the
    ///height, and the width of the rectangle.
    RECT       rcFrame;
    ///Number of times the stream has been edited. The stream handler maintains this count.
    uint       dwEditCount;
    ///Number of times the stream format has changed. The stream handler maintains this count.
    uint       dwFormatChangeCount;
    ///Null-terminated string containing a description of the stream.
    ushort[64] szName;
}

///The <b>AVISTREAMINFO</b> structure contains information for a single stream.
struct AVISTREAMINFOA
{
    ///Four-character code indicating the stream type. The following constants have been defined for the data commonly
    ///found in AVI streams: <table> <tr> <th>Constant</th> <th>Description</th> </tr> <tr> <td width="40%"><a
    ///id="streamtypeAUDIO"></a><a id="streamtypeaudio"></a><a id="STREAMTYPEAUDIO"></a><dl>
    ///<dt><b>streamtypeAUDIO</b></dt> </dl> </td> <td width="60%"> Indicates an audio stream. </td> </tr> <tr> <td
    ///width="40%"><a id="streamtypeMIDI"></a><a id="streamtypemidi"></a><a id="STREAMTYPEMIDI"></a><dl>
    ///<dt><b>streamtypeMIDI</b></dt> </dl> </td> <td width="60%"> Indicates a MIDI stream. </td> </tr> <tr> <td
    ///width="40%"><a id="streamtypeTEXT"></a><a id="streamtypetext"></a><a id="STREAMTYPETEXT"></a><dl>
    ///<dt><b>streamtypeTEXT</b></dt> </dl> </td> <td width="60%"> Indicates a text stream. </td> </tr> <tr> <td
    ///width="40%"><a id="streamtypeVIDEO"></a><a id="streamtypevideo"></a><a id="STREAMTYPEVIDEO"></a><dl>
    ///<dt><b>streamtypeVIDEO</b></dt> </dl> </td> <td width="60%"> Indicates a video stream. </td> </tr> </table>
    uint     fccType;
    ///Four-character code of the compressor handler that will compress this video stream when it is saved (for example,
    ///mmioFOURCC ('M','S','V','C')). This member is not used for audio streams.
    uint     fccHandler;
    ///Applicable flags for the stream. The bits in the high-order word of these flags are specific to the type of data
    ///contained in the stream. The following flags are defined: <table> <tr> <th>Name</th> <th>Description</th> </tr>
    ///<tr> <td width="40%"><a id="AVISTREAMINFO_DISABLED"></a><a id="avistreaminfo_disabled"></a><dl>
    ///<dt><b>AVISTREAMINFO_DISABLED</b></dt> </dl> </td> <td width="60%"> Indicates this stream should be rendered when
    ///explicitly enabled by the user. </td> </tr> <tr> <td width="40%"><a id="AVISTREAMINFO_FORMATCHANGES"></a><a
    ///id="avistreaminfo_formatchanges"></a><dl> <dt><b>AVISTREAMINFO_FORMATCHANGES</b></dt> </dl> </td> <td
    ///width="60%"> Indicates this video stream contains palette changes. This flag warns the playback software that it
    ///will need to animate the palette. </td> </tr> </table>
    uint     dwFlags;
    ///Capability flags; currently unused.
    uint     dwCaps;
    ///Priority of the stream.
    ushort   wPriority;
    ///Language of the stream.
    ushort   wLanguage;
    ///Time scale applicable for the stream. Dividing <b>dwRate</b> by <b>dwScale</b> gives the playback rate in number
    ///of samples per second. For video streams, this rate should be the frame rate. For audio streams, this rate should
    ///correspond to the audio block size (the <b>nBlockAlign</b> member of the WAVEFORMAT or PCMWAVEFORMAT structure),
    ///which for PCM (Pulse Code Modulation) audio reduces to the sample rate.
    uint     dwScale;
    ///Rate in an integer format. To obtain the rate in samples per second, divide this value by the value in
    ///<b>dwScale</b>.
    uint     dwRate;
    ///Sample number of the first frame of the AVI file. The units are defined by dwRate and <b>dwScale</b>. Normally,
    ///this is zero, but it can specify a delay time for a stream that does not start concurrently with the file. The
    ///1.0 release of the AVI tools does not support a nonzero starting time.
    uint     dwStart;
    ///Length of this stream. The units are defined by <b>dwRate</b> and <b>dwScale</b>.
    uint     dwLength;
    ///Audio skew. This member specifies how much to skew the audio data ahead of the video frames in interleaved files.
    ///Typically, this is about 0.75 seconds.
    uint     dwInitialFrames;
    ///Recommended buffer size, in bytes, for the stream. Typically, this member contains a value corresponding to the
    ///largest chunk in the stream. Using the correct buffer size makes playback more efficient. Use zero if you do not
    ///know the correct buffer size.
    uint     dwSuggestedBufferSize;
    ///Quality indicator of the video data in the stream. Quality is represented as a number between 0 and 10,000. For
    ///compressed data, this typically represents the value of the quality parameter passed to the compression software.
    ///If set to –1, drivers use the default quality value.
    uint     dwQuality;
    ///Size, in bytes, of a single data sample. If the value of this member is zero, the samples can vary in size and
    ///each data sample (such as a video frame) must be in a separate chunk. A nonzero value indicates that multiple
    ///samples of data can be grouped into a single chunk within the file. For video streams, this number is typically
    ///zero, although it can be nonzero if all video frames are the same size. For audio streams, this number should be
    ///the same as the <b>nBlockAlign</b> member of the WAVEFORMAT or WAVEFORMATEX structure describing the audio.
    uint     dwSampleSize;
    ///Dimensions of the video destination rectangle. The values represent the coordinates of upper left corner, the
    ///height, and the width of the rectangle.
    RECT     rcFrame;
    ///Number of times the stream has been edited. The stream handler maintains this count.
    uint     dwEditCount;
    ///Number of times the stream format has changed. The stream handler maintains this count.
    uint     dwFormatChangeCount;
    ///Null-terminated string containing a description of the stream.
    byte[64] szName;
}

///The <b>AVIFILEINFO</b> structure contains global information for an entire AVI file.
struct AVIFILEINFOW
{
    ///Approximate maximum data rate of the AVI file.
    uint       dwMaxBytesPerSec;
    ///A bitwise <b>OR</b> of zero or more flags. The following flags are defined: <table> <tr> <th>Name</th>
    ///<th>Description</th> </tr> <tr> <td width="40%"><a id="AVIFILEINFO_HASINDEX"></a><a
    ///id="avifileinfo_hasindex"></a><dl> <dt><b>AVIFILEINFO_HASINDEX</b></dt> </dl> </td> <td width="60%"> The AVI file
    ///has an index at the end of the file. For good performance, all AVI files should contain an index. </td> </tr>
    ///<tr> <td width="40%"><a id="AVIFILEINFO_MUSTUSEINDEX"></a><a id="avifileinfo_mustuseindex"></a><dl>
    ///<dt><b>AVIFILEINFO_MUSTUSEINDEX</b></dt> </dl> </td> <td width="60%"> The file index contains the playback order
    ///for the chunks in the file. Use the index rather than the physical ordering of the chunks when playing back the
    ///data. This could be used for creating a list of frames for editing. </td> </tr> <tr> <td width="40%"><a
    ///id="AVIFILEINFO_ISINTERLEAVED"></a><a id="avifileinfo_isinterleaved"></a><dl>
    ///<dt><b>AVIFILEINFO_ISINTERLEAVED</b></dt> </dl> </td> <td width="60%"> The AVI file is interleaved. </td> </tr>
    ///<tr> <td width="40%"><a id="AVIFILEINFO_WASCAPTUREFILE"></a><a id="avifileinfo_wascapturefile"></a><dl>
    ///<dt><b>AVIFILEINFO_WASCAPTUREFILE</b></dt> </dl> </td> <td width="60%"> The AVI file is a specially allocated
    ///file used for capturing real-time video. Applications should warn the user before writing over a file with this
    ///flag set because the user probably defragmented this file. </td> </tr> <tr> <td width="40%"><a
    ///id="AVIFILEINFO_COPYRIGHTED"></a><a id="avifileinfo_copyrighted"></a><dl> <dt><b>AVIFILEINFO_COPYRIGHTED</b></dt>
    ///</dl> </td> <td width="60%"> The AVI file contains copyrighted data and software. When this flag is used,
    ///software should not permit the data to be duplicated. </td> </tr> </table>
    uint       dwFlags;
    ///Capability flags. The following flags are defined: <table> <tr> <th>Name</th> <th>Description</th> </tr> <tr> <td
    ///width="40%"><a id="AVIFILECAPS_CANREAD"></a><a id="avifilecaps_canread"></a><dl>
    ///<dt><b>AVIFILECAPS_CANREAD</b></dt> </dl> </td> <td width="60%"> An application can open the AVI file with the
    ///read privilege. </td> </tr> <tr> <td width="40%"><a id="AVIFILECAPS_CANWRITE"></a><a
    ///id="avifilecaps_canwrite"></a><dl> <dt><b>AVIFILECAPS_CANWRITE</b></dt> </dl> </td> <td width="60%"> An
    ///application can open the AVI file with the write privilege. </td> </tr> <tr> <td width="40%"><a
    ///id="AVIFILECAPS_ALLKEYFRAMES"></a><a id="avifilecaps_allkeyframes"></a><dl>
    ///<dt><b>AVIFILECAPS_ALLKEYFRAMES</b></dt> </dl> </td> <td width="60%"> Every frame in the AVI file is a key frame.
    ///</td> </tr> <tr> <td width="40%"><a id="AVIFILECAPS_NOCOMPRESSION"></a><a id="avifilecaps_nocompression"></a><dl>
    ///<dt><b>AVIFILECAPS_NOCOMPRESSION</b></dt> </dl> </td> <td width="60%"> The AVI file does not use a compression
    ///method. </td> </tr> </table>
    uint       dwCaps;
    ///Number of streams in the file. For example, a file with audio and video has at least two streams.
    uint       dwStreams;
    ///Suggested buffer size, in bytes, for reading the file. Generally, this size should be large enough to contain the
    ///largest chunk in the file. For an interleaved file, this size should be large enough to read an entire record,
    ///not just a chunk. If the buffer size is too small or is set to zero, the playback software will have to
    ///reallocate memory during playback, reducing performance.
    uint       dwSuggestedBufferSize;
    ///Width, in pixels, of the AVI file.
    uint       dwWidth;
    ///Height, in pixels, of the AVI file.
    uint       dwHeight;
    ///Time scale applicable for the entire file. Dividing <b>dwRate</b> by <b>dwScale</b> gives the number of samples
    ///per second. Any stream can define its own time scale to supersede the file time scale.
    uint       dwScale;
    ///Rate in an integer format. To obtain the rate in samples per second, divide this value by the value in
    ///<b>dwScale</b>.
    uint       dwRate;
    ///Length of the AVI file. The units are defined by <b>dwRate</b> and <b>dwScale</b>.
    uint       dwLength;
    ///Number of streams that have been added to or deleted from the AVI file.
    uint       dwEditCount;
    ///Null-terminated string containing descriptive information for the file type.
    ushort[64] szFileType;
}

///The <b>AVIFILEINFO</b> structure contains global information for an entire AVI file.
struct AVIFILEINFOA
{
    ///Approximate maximum data rate of the AVI file.
    uint     dwMaxBytesPerSec;
    ///A bitwise <b>OR</b> of zero or more flags. The following flags are defined: <table> <tr> <th>Name</th>
    ///<th>Description</th> </tr> <tr> <td width="40%"><a id="AVIFILEINFO_HASINDEX"></a><a
    ///id="avifileinfo_hasindex"></a><dl> <dt><b>AVIFILEINFO_HASINDEX</b></dt> </dl> </td> <td width="60%"> The AVI file
    ///has an index at the end of the file. For good performance, all AVI files should contain an index. </td> </tr>
    ///<tr> <td width="40%"><a id="AVIFILEINFO_MUSTUSEINDEX"></a><a id="avifileinfo_mustuseindex"></a><dl>
    ///<dt><b>AVIFILEINFO_MUSTUSEINDEX</b></dt> </dl> </td> <td width="60%"> The file index contains the playback order
    ///for the chunks in the file. Use the index rather than the physical ordering of the chunks when playing back the
    ///data. This could be used for creating a list of frames for editing. </td> </tr> <tr> <td width="40%"><a
    ///id="AVIFILEINFO_ISINTERLEAVED"></a><a id="avifileinfo_isinterleaved"></a><dl>
    ///<dt><b>AVIFILEINFO_ISINTERLEAVED</b></dt> </dl> </td> <td width="60%"> The AVI file is interleaved. </td> </tr>
    ///<tr> <td width="40%"><a id="AVIFILEINFO_WASCAPTUREFILE"></a><a id="avifileinfo_wascapturefile"></a><dl>
    ///<dt><b>AVIFILEINFO_WASCAPTUREFILE</b></dt> </dl> </td> <td width="60%"> The AVI file is a specially allocated
    ///file used for capturing real-time video. Applications should warn the user before writing over a file with this
    ///flag set because the user probably defragmented this file. </td> </tr> <tr> <td width="40%"><a
    ///id="AVIFILEINFO_COPYRIGHTED"></a><a id="avifileinfo_copyrighted"></a><dl> <dt><b>AVIFILEINFO_COPYRIGHTED</b></dt>
    ///</dl> </td> <td width="60%"> The AVI file contains copyrighted data and software. When this flag is used,
    ///software should not permit the data to be duplicated. </td> </tr> </table>
    uint     dwFlags;
    ///Capability flags. The following flags are defined: <table> <tr> <th>Name</th> <th>Description</th> </tr> <tr> <td
    ///width="40%"><a id="AVIFILECAPS_CANREAD"></a><a id="avifilecaps_canread"></a><dl>
    ///<dt><b>AVIFILECAPS_CANREAD</b></dt> </dl> </td> <td width="60%"> An application can open the AVI file with the
    ///read privilege. </td> </tr> <tr> <td width="40%"><a id="AVIFILECAPS_CANWRITE"></a><a
    ///id="avifilecaps_canwrite"></a><dl> <dt><b>AVIFILECAPS_CANWRITE</b></dt> </dl> </td> <td width="60%"> An
    ///application can open the AVI file with the write privilege. </td> </tr> <tr> <td width="40%"><a
    ///id="AVIFILECAPS_ALLKEYFRAMES"></a><a id="avifilecaps_allkeyframes"></a><dl>
    ///<dt><b>AVIFILECAPS_ALLKEYFRAMES</b></dt> </dl> </td> <td width="60%"> Every frame in the AVI file is a key frame.
    ///</td> </tr> <tr> <td width="40%"><a id="AVIFILECAPS_NOCOMPRESSION"></a><a id="avifilecaps_nocompression"></a><dl>
    ///<dt><b>AVIFILECAPS_NOCOMPRESSION</b></dt> </dl> </td> <td width="60%"> The AVI file does not use a compression
    ///method. </td> </tr> </table>
    uint     dwCaps;
    ///Number of streams in the file. For example, a file with audio and video has at least two streams.
    uint     dwStreams;
    ///Suggested buffer size, in bytes, for reading the file. Generally, this size should be large enough to contain the
    ///largest chunk in the file. For an interleaved file, this size should be large enough to read an entire record,
    ///not just a chunk. If the buffer size is too small or is set to zero, the playback software will have to
    ///reallocate memory during playback, reducing performance.
    uint     dwSuggestedBufferSize;
    ///Width, in pixels, of the AVI file.
    uint     dwWidth;
    ///Height, in pixels, of the AVI file.
    uint     dwHeight;
    ///Time scale applicable for the entire file. Dividing <b>dwRate</b> by <b>dwScale</b> gives the number of samples
    ///per second. Any stream can define its own time scale to supersede the file time scale.
    uint     dwScale;
    ///Rate in an integer format. To obtain the rate in samples per second, divide this value by the value in
    ///<b>dwScale</b>.
    uint     dwRate;
    ///Length of the AVI file. The units are defined by <b>dwRate</b> and <b>dwScale</b>.
    uint     dwLength;
    ///Number of streams that have been added to or deleted from the AVI file.
    uint     dwEditCount;
    ///Null-terminated string containing descriptive information for the file type.
    byte[64] szFileType;
}

///The <b>AVICOMPRESSOPTIONS</b> structure contains information about a stream and how it is compressed and saved. This
///structure passes data to the AVIMakeCompressedStream function (or the AVISave function, which uses
///<b>AVIMakeCompressedStream</b>).
struct AVICOMPRESSOPTIONS
{
    ///Four-character code indicating the stream type. The following constants have been defined for the data commonly
    ///found in AVI streams: <table> <tr> <th>Constant</th> <th>Description</th> </tr> <tr> <td width="40%"><a
    ///id="streamtypeAUDIO"></a><a id="streamtypeaudio"></a><a id="STREAMTYPEAUDIO"></a><dl>
    ///<dt><b>streamtypeAUDIO</b></dt> </dl> </td> <td width="60%"> Indicates an audio stream. </td> </tr> <tr> <td
    ///width="40%"><a id="streamtypeMIDI"></a><a id="streamtypemidi"></a><a id="STREAMTYPEMIDI"></a><dl>
    ///<dt><b>streamtypeMIDI</b></dt> </dl> </td> <td width="60%"> Indicates a MIDI stream. </td> </tr> <tr> <td
    ///width="40%"><a id="streamtypeTEXT"></a><a id="streamtypetext"></a><a id="STREAMTYPETEXT"></a><dl>
    ///<dt><b>streamtypeTEXT</b></dt> </dl> </td> <td width="60%"> Indicates a text stream. </td> </tr> <tr> <td
    ///width="40%"><a id="streamtypeVIDEO"></a><a id="streamtypevideo"></a><a id="STREAMTYPEVIDEO"></a><dl>
    ///<dt><b>streamtypeVIDEO</b></dt> </dl> </td> <td width="60%"> Indicates a video stream. </td> </tr> </table>
    uint  fccType;
    ///Four-character code for the compressor handler that will compress this video stream when it is saved (for
    ///example, mmioFOURCC ('M','S','V','C')). This member is not used for audio streams.
    uint  fccHandler;
    ///Maximum period between video key frames. This member is used only if the AVICOMPRESSF_KEYFRAMES flag is set;
    ///otherwise every video frame is a key frame.
    uint  dwKeyFrameEvery;
    ///Quality value passed to a video compressor. This member is not used for an audio compressor.
    uint  dwQuality;
    ///Video compressor data rate. This member is used only if the AVICOMPRESSF_DATARATE flag is set.
    uint  dwBytesPerSecond;
    ///Flags used for compression. The following values are defined: <table> <tr> <th>Name</th> <th>Description</th>
    ///</tr> <tr> <td width="40%"><a id="AVICOMPRESSF_DATARATE"></a><a id="avicompressf_datarate"></a><dl>
    ///<dt><b>AVICOMPRESSF_DATARATE</b></dt> </dl> </td> <td width="60%"> Compresses this video stream using the data
    ///rate specified in <b>dwBytesPerSecond</b>. </td> </tr> <tr> <td width="40%"><a
    ///id="AVICOMPRESSF_INTERLEAVE"></a><a id="avicompressf_interleave"></a><dl> <dt><b>AVICOMPRESSF_INTERLEAVE</b></dt>
    ///</dl> </td> <td width="60%"> Interleaves this stream every <b>dwInterleaveEvery</b> frames with respect to the
    ///first stream. </td> </tr> <tr> <td width="40%"><a id="AVICOMPRESSF_KEYFRAMES"></a><a
    ///id="avicompressf_keyframes"></a><dl> <dt><b>AVICOMPRESSF_KEYFRAMES</b></dt> </dl> </td> <td width="60%"> Saves
    ///this video stream with key frames at least every <b>dwKeyFrameEvery</b> frames. By default, every frame will be a
    ///key frame. </td> </tr> <tr> <td width="40%"><a id="AVICOMPRESSF_VALID"></a><a id="avicompressf_valid"></a><dl>
    ///<dt><b>AVICOMPRESSF_VALID</b></dt> </dl> </td> <td width="60%"> Uses the data in this structure to set the
    ///default compression values for AVISaveOptions. If an empty structure is passed and this flag is not set, some
    ///defaults will be chosen. </td> </tr> </table>
    uint  dwFlags;
    ///Pointer to a structure defining the data format. For an audio stream, this is an <b>LPWAVEFORMAT</b> structure.
    void* lpFormat;
    ///Size, in bytes, of the data referenced by <b>lpFormat</b>.
    uint  cbFormat;
    ///Video-compressor-specific data; used internally.
    void* lpParms;
    ///Size, in bytes, of the data referenced by <b>lpParms</b>
    uint  cbParms;
    ///Interleave factor for interspersing stream data with data from the first stream. Used only if the
    ///AVICOMPRESSF_INTERLEAVE flag is set.
    uint  dwInterleaveEvery;
}

struct HVIDEO__
{
    int unused;
}

///The <b>VIDEOHDR</b> structure is used by the capVideoStreamCallback function.
struct VIDEOHDR
{
    ///Pointer to locked data buffer.
    ubyte*    lpData;
    ///Length of data buffer.
    uint      dwBufferLength;
    ///Bytes actually used.
    uint      dwBytesUsed;
    ///Milliseconds from start of stream.
    uint      dwTimeCaptured;
    ///User-defined data.
    size_t    dwUser;
    ///The flags are defined as follows. <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td>VHDR_DONE</td>
    ///<td>Done bit</td> </tr> <tr> <td>VHDR_PREPARED</td> <td>Set if this header has been prepared</td> </tr> <tr>
    ///<td>VHDR_INQUEUE</td> <td>Reserved for driver</td> </tr> <tr> <td>VHDR_KEYFRAME</td> <td>Key Frame</td> </tr>
    ///</table>
    uint      dwFlags;
    ///Reserved for driver.
    size_t[4] dwReserved;
}

struct channel_caps_tag
{
    uint dwFlags;
    uint dwSrcRectXMod;
    uint dwSrcRectYMod;
    uint dwSrcRectWidthMod;
    uint dwSrcRectHeightMod;
    uint dwDstRectXMod;
    uint dwDstRectYMod;
    uint dwDstRectWidthMod;
    uint dwDstRectHeightMod;
}

///The <b>CAPDRIVERCAPS</b> structure defines the capabilities of the capture driver. An application should use the
///WM_CAP_DRIVER_GET_CAPS message or capDriverGetCaps macro to place a copy of the driver capabilities in a
///<b>CAPDRIVERCAPS</b> structure whenever the application connects a capture window to a capture driver.
struct CAPDRIVERCAPS
{
    ///Index of the capture driver. An index value can range from 0 to 9.
    uint   wDeviceIndex;
    ///Video-overlay flag. The value of this member is <b>TRUE</b> if the device supports video overlay.
    BOOL   fHasOverlay;
    ///Video source dialog flag. The value of this member is <b>TRUE</b> if the device supports a dialog box for
    ///selecting and controlling the video source.
    BOOL   fHasDlgVideoSource;
    ///Video format dialog flag. The value of this member is <b>TRUE</b> if the device supports a dialog box for
    ///selecting the video format.
    BOOL   fHasDlgVideoFormat;
    ///Video display dialog flag. The value of this member is <b>TRUE</b> if the device supports a dialog box for
    ///controlling the redisplay of video from the capture frame buffer.
    BOOL   fHasDlgVideoDisplay;
    ///Capture initialization flag. The value of this member is <b>TRUE</b> if a capture device has been successfully
    ///connected.
    BOOL   fCaptureInitialized;
    ///Driver palette flag. The value of this member is <b>TRUE</b> if the driver can create palettes.
    BOOL   fDriverSuppliesPalettes;
    ///Not used in Win32 applications.
    HANDLE hVideoIn;
    ///Not used in Win32 applications.
    HANDLE hVideoOut;
    ///Not used in Win32 applications.
    HANDLE hVideoExtIn;
    ///Not used in Win32 applications.
    HANDLE hVideoExtOut;
}

///The <b>CAPSTATUS</b> structure defines the current state of the capture window.
struct CAPSTATUS
{
    ///Image width, in pixels.
    uint     uiImageWidth;
    ///Image height, in pixels
    uint     uiImageHeight;
    ///Live window flag. The value of this member is <b>TRUE</b> if the window is displaying video using the preview
    ///method.
    BOOL     fLiveWindow;
    ///Overlay window flag. The value of this member is <b>TRUE</b> if the window is displaying video using hardware
    ///overlay.
    BOOL     fOverlayWindow;
    ///Input scaling flag. The value of this member is <b>TRUE</b> if the window is scaling the input video to the
    ///client area when displaying video using preview. This parameter has no effect when displaying video using
    ///overlay.
    BOOL     fScale;
    ///The x- and y-offset of the pixel displayed in the upper left corner of the client area of the window.
    POINT    ptScroll;
    ///Default palette flag. The value of this member is <b>TRUE</b> if the capture driver is using its default palette.
    BOOL     fUsingDefaultPalette;
    ///Audio hardware flag. The value of this member is <b>TRUE</b> if the system has waveform-audio hardware installed.
    BOOL     fAudioHardware;
    ///Capture file flag. The value of this member is <b>TRUE</b> if a valid capture file has been generated.
    BOOL     fCapFileExists;
    ///Number of frames processed during the current (or most recent) streaming capture. This count includes dropped
    ///frames.
    uint     dwCurrentVideoFrame;
    ///Number of frames dropped during the current (or most recent) streaming capture. Dropped frames occur when the
    ///capture rate exceeds the rate at which frames can be saved to file. In this case, the capture driver has no
    ///buffers available for storing data. Dropping frames does not affect synchronization because the previous frame is
    ///displayed in place of the dropped frame.
    uint     dwCurrentVideoFramesDropped;
    ///Number of waveform-audio samples processed during the current (or most recent) streaming capture.
    uint     dwCurrentWaveSamples;
    ///Time, in milliseconds, since the start of the current (or most recent) streaming capture.
    uint     dwCurrentTimeElapsedMS;
    ///Handle to current palette.
    HPALETTE hPalCurrent;
    ///Capturing flag. The value of this member is <b>TRUE</b> when capturing is in progress.
    BOOL     fCapturingNow;
    ///Error return values. Use this member if your application does not support an error callback function.
    uint     dwReturn;
    ///Number of video buffers allocated. This value might be less than the number specified in the
    ///<b>wNumVideoRequested</b> member of the CAPTUREPARMS structure.
    uint     wNumVideoAllocated;
    ///Number of audio buffers allocated. This value might be less than the number specified in the
    ///<b>wNumAudioRequested</b> member of the CAPTUREPARMS structure.
    uint     wNumAudioAllocated;
}

///The <b>CAPTUREPARMS</b> structure contains parameters that control the streaming video capture process. This
///structure is used to get and set parameters that affect the capture rate, the number of buffers to use while
///capturing, and how capture is terminated.
struct CAPTUREPARMS
{
    ///Requested frame rate, in microseconds. The default value is 66667, which corresponds to 15 frames per second.
    uint dwRequestMicroSecPerFrame;
    ///User-initiated capture flag. If this member is <b>TRUE</b>, AVICap displays a dialog box prompting the user to
    ///initiate capture. The default value is <b>FALSE</b>.
    BOOL fMakeUserHitOKToCapture;
    ///Maximum allowable percentage of dropped frames during capture. Values range from 0 to 100. The default value is
    ///10.
    uint wPercentDropForError;
    ///Yield flag. If this member is <b>TRUE</b>, the capture window spawns a separate background thread to perform step
    ///and streaming capture. The default value is <b>FALSE</b>. Applications that set this flag must handle potential
    ///reentry issues because the controls in the application are not disabled while capture is in progress.
    BOOL fYield;
    ///Maximum number of index entries in an AVI file. Values range from 1800 to 324,000. If set to 0, a default value
    ///of 34,952 (32K frames plus a proportional number of audio buffers) is used. Each video frame or buffer of
    ///waveform-audio data uses one index entry. The value of this entry establishes a limit for the number of frames or
    ///audio buffers that can be captured.
    uint dwIndexSize;
    ///Logical block size, in bytes, of an AVI file. The value 0 indicates the current sector size is used as the
    ///granularity.
    uint wChunkGranularity;
    ///Not used in Win32 applications.
    BOOL fUsingDOSMemory;
    ///Maximum number of video buffers to allocate. The memory area to place the buffers is specified with
    ///<b>fUsingDOSMemory</b>. The actual number of buffers allocated might be lower if memory is unavailable.
    uint wNumVideoRequested;
    ///Capture audio flag. If this member is <b>TRUE</b>, audio is captured during streaming capture. This is the
    ///default value if audio hardware is installed.
    BOOL fCaptureAudio;
    ///Maximum number of audio buffers to allocate. The maximum number of buffers is 10.
    uint wNumAudioRequested;
    ///Virtual keycode used to terminate streaming capture. The default value is VK_ESCAPE. You must call the
    ///RegisterHotKey function before specifying a keystroke that can abort a capture session. You can combine keycodes
    ///that include CTRL and SHIFT keystrokes by using the logical OR operator with the keycodes for CTRL (0x8000) and
    ///SHIFT (0x4000).
    uint vKeyAbort;
    ///Abort flag for left mouse button. If this member is <b>TRUE</b>, streaming capture stops if the left mouse button
    ///is pressed. The default value is <b>TRUE</b>.
    BOOL fAbortLeftMouse;
    ///Abort flag for right mouse button. If this member is <b>TRUE</b>, streaming capture stops if the right mouse
    ///button is pressed. The default value is <b>TRUE</b>.
    BOOL fAbortRightMouse;
    ///Time limit enabled flag. If this member is <b>TRUE</b>, streaming capture stops after the number of seconds in
    ///<b>wTimeLimit</b> has elapsed. The default value is <b>FALSE</b>.
    BOOL fLimitEnabled;
    ///Time limit for capture, in seconds. This parameter is used only if <b>fLimitEnabled</b> is <b>TRUE</b>.
    uint wTimeLimit;
    ///MCI device capture flag. If this member is <b>TRUE</b>, AVICap controls an MCI-compatible video source during
    ///streaming capture. MCI-compatible video sources include VCRs and laserdiscs.
    BOOL fMCIControl;
    ///MCI device step capture flag. If this member is <b>TRUE</b>, step capture using an MCI device as a video source
    ///is enabled. If it is <b>FALSE</b>, real-time capture using an MCI device is enabled. (If <b>fMCIControl</b> is
    ///<b>FALSE</b>, this member is ignored.)
    BOOL fStepMCIDevice;
    ///Starting position, in milliseconds, of the MCI device for the capture sequence. (If <b>fMCIControl</b> is
    ///<b>FALSE</b>, this member is ignored.)
    uint dwMCIStartTime;
    ///Stopping position, in milliseconds, of the MCI device for the capture sequence. When this position in the content
    ///is reached, capture ends and the MCI device stops. (If <b>fMCIControl</b> is <b>FALSE</b>, this member is
    ///ignored.)
    uint dwMCIStopTime;
    ///Double-resolution step capture flag. If this member is <b>TRUE</b>, the capture hardware captures at twice the
    ///specified resolution. (The resolution for the height and width is doubled.) Enable this option if the hardware
    ///does not support hardware-based decimation and you are capturing in the RGB format.
    BOOL fStepCaptureAt2x;
    ///Number of times a frame is sampled when creating a frame based on the average sample. A typical value for the
    ///number of averages is 5.
    uint wStepCaptureAverageFrames;
    ///Audio buffer size. If the default value of zero is used, the size of each buffer will be the maximum of 0.5
    ///seconds of audio or 10K bytes.
    uint dwAudioBufferSize;
    ///Not used in Win32 applications.
    BOOL fDisableWriteCache;
    ///Indicates whether the audio stream controls the clock when writing an AVI file. If this member is set to
    ///AVSTREAMMASTER_AUDIO, the audio stream is considered the master stream and the video stream duration is forced to
    ///match the audio duration. If this member is set to AVSTREAMMASTER_NONE, the durations of audio and video streams
    ///can differ.
    uint AVStreamMaster;
}

///The <b>CAPINFOCHUNK</b> structure contains parameters that can be used to define an information chunk within an AVI
///capture file. The WM_CAP_FILE_SET_INFOCHUNK message or <b>capSetInfoChunk</b> macro is used to send a
///<b>CAPINFOCHUNK</b> structure to a capture window.
struct CAPINFOCHUNK
{
    ///Four-character code that identifies the representation of the chunk data. If this value is <b>NULL</b> and
    ///<b>lpData</b> is <b>NULL</b>, all accumulated information chunks are deleted.
    uint  fccInfoID;
    ///Pointer to the data. If this value is <b>NULL</b>, all <b>fccInfoID</b> information chunks are deleted.
    void* lpData;
    ///Size, in bytes, of the data pointed to by <b>lpData</b>. If <b>lpData</b> specifies a null-terminated string, use
    ///the string length incremented by one to save the <b>NULL</b> with the string.
    int   cbData;
}

struct DRVM_IOCTL_DATA
{
align (1):
    uint dwSize;
    uint dwCmd;
}

struct WAVEOPENDESC
{
align (1):
    ptrdiff_t   hWave;
    WAVEFORMAT* lpFormat;
    size_t      dwCallback;
    size_t      dwInstance;
    uint        uMappedDeviceID;
    size_t      dnDevNode;
}

struct midiopenstrmid_tag
{
align (1):
    uint dwStreamID;
    uint uDeviceID;
}

struct tMIXEROPENDESC
{
align (1):
    HMIXER hmx;
    void*  pReserved0;
    size_t dwCallback;
    size_t dwInstance;
    size_t dnDevNode;
}

struct timerevent_tag
{
align (1):
    ushort         wDelay;
    ushort         wResolution;
    LPTIMECALLBACK lpFunction;
    uint           dwUser;
    ushort         wFlags;
    ushort         wReserved1;
}

struct joypos_tag
{
align (1):
    uint dwX;
    uint dwY;
    uint dwZ;
    uint dwR;
    uint dwU;
    uint dwV;
}

struct joyrange_tag
{
    joypos_tag jpMin;
    joypos_tag jpMax;
    joypos_tag jpCenter;
}

struct joyreguservalues_tag
{
align (1):
    uint         dwTimeOut;
    joyrange_tag jrvRanges;
    joypos_tag   jpDeadZone;
}

struct joyreghwsettings_tag
{
align (1):
    uint dwFlags;
    uint dwNumButtons;
}

struct joyreghwconfig_tag
{
align (1):
    joyreghwsettings_tag hws;
    uint                 dwUsageSettings;
    JOYREGHWVALUES       hwv;
    uint                 dwType;
    uint                 dwReserved;
}

struct joycalibrate_tag
{
align (1):
    ushort wXbase;
    ushort wXdelta;
    ushort wYbase;
    ushort wYdelta;
    ushort wZbase;
    ushort wZdelta;
}

struct MCI_OPEN_DRIVER_PARMS
{
align (1):
    uint         wDeviceID;
    const(PWSTR) lpstrParams;
    uint         wCustomCommandTable;
    uint         wType;
}

// Functions

///The <b>joyConfigChanged</b> function informs the joystick driver that the configuration has changed and should be
///reloaded from the registry.
///Params:
///    dwFlags = Reserved for future use. Must equal zero.
///Returns:
///    Returns JOYERR_NOERROR if successful. Returns JOYERR_PARMS if the parameter is non-zero.
///    
@DllImport("WINMM")
uint joyConfigChanged(uint dwFlags);

///Closes an installable driver.
///Params:
///    hDriver = Handle of an installable driver instance. The handle must have been previously created by using the OpenDriver
///              function.
///    lParam1 = 32-bit driver-specific data.
///    lParam2 = 32-bit driver-specific data.
///Returns:
///    Returns nonzero if successful or zero otherwise.
///    
@DllImport("api-ms-win-mm-misc-l1-1-0")
LRESULT CloseDriver(ptrdiff_t hDriver, LPARAM lParam1, LPARAM lParam2);

///Opens an instance of an installable driver and initializes the instance using either the driver's default settings or
///a driver-specific value.
///Params:
///    szDriverName = Address of a null-terminated, wide-character string that specifies the filename of an installable driver or the
///                   name of a registry value associated with the installable driver. (This value must have been previously set when
///                   the driver was installed.)
///    szSectionName = Address of a null-terminated, wide-character string that specifies the name of the registry key containing the
///                    registry value given by the <i>lpDriverName</i> parameter. If <i>lpSectionName</i> is <b>NULL</b>, the registry
///                    key is assumed to be <b>Drivers32</b>.
///    lParam2 = 32-bit driver-specific value. This value is passed as the <i>lParam2</i> parameter to the DriverProc function of
///              the installable driver.
///Returns:
///    Returns the handle of the installable driver instance if successful or <b>NULL</b> otherwise.
///    
@DllImport("api-ms-win-mm-misc-l1-1-0")
ptrdiff_t OpenDriver(const(PWSTR) szDriverName, const(PWSTR) szSectionName, LPARAM lParam2);

///Sends the specified message to the installable driver.
///Params:
///    hDriver = Handle of the installable driver instance. The handle must been previously created by using the OpenDriver
///              function.
///    message = Driver message value. It can be a custom message value or one of these standard message values. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DRV_QUERYCONFIGURE"></a><a
///              id="drv_queryconfigure"></a><dl> <dt><b>DRV_QUERYCONFIGURE</b></dt> </dl> </td> <td width="60%"> Queries an
///              installable driver about whether it supports the <b>DRV_CONFIGURE</b> message and can display a configuration
///              dialog box. </td> </tr> <tr> <td width="40%"><a id="DRV_CONFIGURE"></a><a id="drv_configure"></a><dl>
///              <dt><b>DRV_CONFIGURE</b></dt> </dl> </td> <td width="60%"> Notifies an installable driver that it should display
///              a configuration dialog box. (This message should only be sent if the driver returns a nonzero value when the
///              DRV_QUERYCONFIGURE message is processed.) </td> </tr> <tr> <td width="40%"><a id="DRV_INSTALL"></a><a
///              id="drv_install"></a><dl> <dt><b>DRV_INSTALL</b></dt> </dl> </td> <td width="60%"> Notifies an installable driver
///              that it has been successfully installed. </td> </tr> <tr> <td width="40%"><a id="DRV_REMOVE"></a><a
///              id="drv_remove"></a><dl> <dt><b>DRV_REMOVE</b></dt> </dl> </td> <td width="60%"> Notifies an installable driver
///              that it is about to be removed from the system. </td> </tr> </table>
///    lParam1 = 32-bit message-dependent information.
///    lParam2 = 32-bit message-dependent information.
///Returns:
///    Returns nonzero if successful or zero otherwise.
///    
@DllImport("api-ms-win-mm-misc-l1-1-0")
LRESULT SendDriverMessage(ptrdiff_t hDriver, uint message, LPARAM lParam1, LPARAM lParam2);

///Retrieves the instance handle of the module that contains the installable driver. This function is provided for
///compatibility with previous versions of Windows.
///Params:
///    hDriver = Handle of the installable driver instance. The handle must have been previously created by using the OpenDriver
///              function.
///Returns:
///    Returns an instance handle of the driver module if successful or <b>NULL</b> otherwise.
///    
@DllImport("api-ms-win-mm-misc-l1-1-0")
ptrdiff_t DrvGetModuleHandle(ptrdiff_t hDriver);

///Retrieves the instance handle of the module that contains the installable driver.
///Params:
///    hDriver = Handle of the installable driver instance. The handle must have been previously created by using the OpenDriver
///              function.
///Returns:
///    Returns an instance handle of the driver module if successful or <b>NULL</b> otherwise.
///    
@DllImport("api-ms-win-mm-misc-l1-1-0")
ptrdiff_t GetDriverModuleHandle(ptrdiff_t hDriver);

///Provides default processing for any messages not processed by an installable driver. This function is intended to be
///used only within the DriverProc function of an installable driver.
///Params:
///    dwDriverIdentifier = Identifier of the installable driver.
///    hdrvr = Handle of the installable driver instance.
///    uMsg = Driver message value.
///    lParam1 = 32-bit message-dependent information.
///    lParam2 = 32-bit message-dependent information.
@DllImport("api-ms-win-mm-misc-l1-1-0")
LRESULT DefDriverProc(size_t dwDriverIdentifier, ptrdiff_t hdrvr, uint uMsg, LPARAM lParam1, LPARAM lParam2);

///Calls a callback function, sends a message to a window, or unblocks a thread. The action depends on the value of the
///notification flag. This function is intended to be used only within the DriverProc function of an installable driver.
///Params:
///    dwCallback = Address of the callback function, a window handle, or a task handle, depending on the flag specified in the
///                 <i>dwFlags</i> parameter.
///    dwFlags = Notification flags. It can be one of these values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///              width="40%"><a id="DCB_NOSWITCH"></a><a id="dcb_noswitch"></a><dl> <dt><b>DCB_NOSWITCH</b></dt> </dl> </td> <td
///              width="60%"> The system is prevented from switching stacks. This value is only used if enough stack space for the
///              callback function is known to exist. </td> </tr> <tr> <td width="40%"><a id="DCB_FUNCTION"></a><a
///              id="dcb_function"></a><dl> <dt><b>DCB_FUNCTION</b></dt> </dl> </td> <td width="60%"> The <i>dwCallback</i>
///              parameter is the address of an application-defined callback function. The system sends the callback message to
///              the callback function. </td> </tr> <tr> <td width="40%"><a id="DCB_WINDOW"></a><a id="dcb_window"></a><dl>
///              <dt><b>DCB_WINDOW</b></dt> </dl> </td> <td width="60%"> The <i>dwCallback</i> parameter is the handle of an
///              application-defined window. The system sends subsequent notifications to the window. </td> </tr> <tr> <td
///              width="40%"><a id="DCB_TASK"></a><a id="dcb_task"></a><dl> <dt><b>DCB_TASK</b></dt> </dl> </td> <td width="60%">
///              The <i>dwCallback</i> parameter is the handle of an application or task. The system sends subsequent
///              notifications to the application or task. </td> </tr> </table>
///    hDevice = Handle of the installable driver instance.
///    dwMsg = Message value.
///    dwUser = 32-bit user-instance data supplied by the application when the device was opened.
///    dwParam1 = 32-bit message-dependent parameter.
///    dwParam2 = 32-bit message-dependent parameter.
///Returns:
///    Returns <b>TRUE</b> if successful or <b>FALSE</b> if a parameter is invalid or the task's message queue is full.
///    
@DllImport("api-ms-win-mm-misc-l1-1-0")
BOOL DriverCallback(size_t dwCallback, uint dwFlags, ptrdiff_t hDevice, uint dwMsg, size_t dwUser, size_t dwParam1, 
                    size_t dwParam2);

///Opens the specified sound event.
///Params:
///    EventName = The name of the sound event.
///    AppName = The application associated with the sound event.
///    Flags = Flags for playing the sound. The following values are defined.
///    FileHandle = Receives the handle to the sound.
@DllImport("api-ms-win-mm-misc-l1-1-1")
int sndOpenSound(const(PWSTR) EventName, const(PWSTR) AppName, int Flags, HANDLE* FileHandle);

@DllImport("api-ms-win-mm-misc-l1-1-0")
uint mmDrvInstall(ptrdiff_t hDriver, const(PWSTR) wszDrvEntry, DRIVERMSGPROC drvMessage, uint wFlags);

///The <b>mmioStringToFOURCC</b> function converts a null-terminated string to a four-character code.
///Params:
///    sz = Pointer to a null-terminated string to convert to a four-character code.
///    uFlags = Flags for the conversion. The following value is defined: <table> <tr> <th>Value </th> <th>Meaning </th> </tr>
///             <tr> <td>MMIO_TOUPPER</td> <td>Converts all characters to uppercase.</td> </tr> </table>
///Returns:
///    Returns the four-character code created from the given string.
///    
@DllImport("api-ms-win-mm-misc-l1-1-0")
uint mmioStringToFOURCCA(const(PSTR) sz, uint uFlags);

///The <b>mmioStringToFOURCC</b> function converts a null-terminated string to a four-character code.
///Params:
///    sz = Pointer to a null-terminated string to convert to a four-character code.
///    uFlags = Flags for the conversion. The following value is defined: <table> <tr> <th>Value </th> <th>Meaning </th> </tr>
///             <tr> <td>MMIO_TOUPPER</td> <td>Converts all characters to uppercase.</td> </tr> </table>
///Returns:
///    Returns the four-character code created from the given string.
///    
@DllImport("api-ms-win-mm-misc-l1-1-0")
uint mmioStringToFOURCCW(const(PWSTR) sz, uint uFlags);

///The <b>mmioInstallIOProc</b> function installs or removes a custom I/O procedure. This function also locates an
///installed I/O procedure, using its corresponding four-character code.
///Params:
///    fccIOProc = Four-character code identifying the I/O procedure to install, remove, or locate. All characters in this code
///                should be uppercase.
///    pIOProc = Pointer to the I/O procedure to install. To remove or locate an I/O procedure, set this parameter to <b>NULL</b>.
///              For more information about the I/O procedure, see MMIOProc.
///    dwFlags = Flag indicating whether the I/O procedure is being installed, removed, or located. The following values are
///              defined. <table> <tr> <th>Value </th> <th>Meaning </th> </tr> <tr> <td>MMIO_FINDPROC</td> <td>Searches for the
///              specified I/O procedure.</td> </tr> <tr> <td>MMIO_GLOBALPROC</td> <td>This flag is a modifier to the
///              MMIO_INSTALLPROC flag and indicates the I/O procedure should be installed for global use. This flag is ignored if
///              MMIO_FINDPROC or MMIO_REMOVEPROC is specified.</td> </tr> <tr> <td>MMIO_INSTALLPROC</td> <td>Installs the
///              specified I/O procedure.</td> </tr> <tr> <td>MMIO_REMOVEPROC</td> <td>Removes the specified I/O procedure.</td>
///              </tr> </table>
///Returns:
///    Returns the address of the I/O procedure installed, removed, or located. Returns <b>NULL</b> if there is an
///    error.
///    
@DllImport("api-ms-win-mm-misc-l1-1-0")
LPMMIOPROC mmioInstallIOProcA(uint fccIOProc, LPMMIOPROC pIOProc, uint dwFlags);

///The <b>mmioInstallIOProc</b> function installs or removes a custom I/O procedure. This function also locates an
///installed I/O procedure, using its corresponding four-character code.
///Params:
///    fccIOProc = Four-character code identifying the I/O procedure to install, remove, or locate. All characters in this code
///                should be uppercase.
///    pIOProc = Pointer to the I/O procedure to install. To remove or locate an I/O procedure, set this parameter to <b>NULL</b>.
///              For more information about the I/O procedure, see MMIOProc.
///    dwFlags = Flag indicating whether the I/O procedure is being installed, removed, or located. The following values are
///              defined. <table> <tr> <th>Value </th> <th>Meaning </th> </tr> <tr> <td>MMIO_FINDPROC</td> <td>Searches for the
///              specified I/O procedure.</td> </tr> <tr> <td>MMIO_GLOBALPROC</td> <td>This flag is a modifier to the
///              MMIO_INSTALLPROC flag and indicates the I/O procedure should be installed for global use. This flag is ignored if
///              MMIO_FINDPROC or MMIO_REMOVEPROC is specified.</td> </tr> <tr> <td>MMIO_INSTALLPROC</td> <td>Installs the
///              specified I/O procedure.</td> </tr> <tr> <td>MMIO_REMOVEPROC</td> <td>Removes the specified I/O procedure.</td>
///              </tr> </table>
///Returns:
///    Returns the address of the I/O procedure installed, removed, or located. Returns <b>NULL</b> if there is an
///    error.
///    
@DllImport("api-ms-win-mm-misc-l1-1-0")
LPMMIOPROC mmioInstallIOProcW(uint fccIOProc, LPMMIOPROC pIOProc, uint dwFlags);

///The <b>mmioOpen</b> function opens a file for unbuffered or buffered I/O; creates a file; deletes a file; or checks
///whether a file exists. The file can be a standard file, a memory file, or an element of a custom storage system. The
///handle returned by mmioOpen is not a standard file handle; do not use it with any file I/O functions other than
///multimedia file I/O functions. <div class="alert"><b>Note</b> This function is deprecated. Applications should call
///CreateFile to create or open files.</div> <div> </div>
///Params:
///    pszFileName = Pointer to a buffer that contains the name of the file. If no I/O procedure is specified to open the file, the
///                  file name determines how the file is opened, as follows: <ul> <li>If the file name does not contain a plus sign
///                  (+), it is assumed to be the name of a standard file (that is, a file whose type is not <b>HMMIO</b>).</li>
///                  <li>If the file name is of the form EXAMPLE.EXT+ABC, the extension EXT is assumed to identify an installed I/O
///                  procedure which is called to perform I/O on the file. For more information, see mmioInstallIOProc.</li> <li>If
///                  the file name is <b>NULL</b> and no I/O procedure is given, the <b>adwInfo</b> member of the MMIOINFO structure
///                  is assumed to be the standard (non-<b>HMMIO</b>) file handle of a currently open file.</li> </ul> The file name
///                  should not be longer than 128 characters, including the terminating NULL character. When opening a memory file,
///                  set <i>szFilename</i> to <b>NULL</b>.
///    pmmioinfo = Pointer to an MMIOINFO structure containing extra parameters used by <b>mmioOpen</b>. Unless you are opening a
///                memory file, specifying the size of a buffer for buffered I/O, or specifying an uninstalled I/O procedure to open
///                a file, this parameter should be <b>NULL</b>. If this parameter is not <b>NULL</b>, all unused members of the
///                <b>MMIOINFO</b> structure it references must be set to zero, including the reserved members.
///    fdwOpen = Flags for the open operation. The MMIO_READ, MMIO_WRITE, and MMIO_READWRITE flags are mutually exclusive
///              â&euro;" only one should be specified. The MMIO_COMPAT, MMIO_EXCLUSIVE, MMIO_DENYWRITE, MMIO_DENYREAD, and
///              MMIO_DENYNONE flags are file-sharing flags. The following values are defined. <table> <tr> <th>Value </th>
///              <th>Meaning </th> </tr> <tr> <td>MMIO_ALLOCBUF</td> <td>Opens a file for buffered I/O. To allocate a buffer
///              larger or smaller than the default buffer size (8K, defined as MMIO_DEFAULTBUFFER), set the <b>cchBuffer</b>
///              member of the MMIOINFO structure to the desired buffer size. If <b>cchBuffer</b> is zero, the default buffer size
///              is used. If you are providing your own I/O buffer, this flag should not be used.</td> </tr> <tr>
///              <td>MMIO_COMPAT</td> <td>Opens the file with compatibility mode, allowing any process on a given machine to open
///              the file any number of times. If the file has been opened with any of the other sharing modes, <b>mmioOpen</b>
///              fails.</td> </tr> <tr> <td>MMIO_CREATE</td> <td>Creates a new file. If the file already exists, it is truncated
///              to zero length. For memory files, this flag indicates the end of the file is initially at the start of the
///              buffer.</td> </tr> <tr> <td>MMIO_DELETE</td> <td>Deletes a file. If this flag is specified, <i>szFilename</i>
///              should not be <b>NULL</b>. The return value is <b>TRUE</b> (cast to <b>HMMIO</b>) if the file was deleted
///              successfully or <b>FALSE</b> otherwise. Do not call the mmioClose function for a file that has been deleted. If
///              this flag is specified, all other flags that open files are ignored.</td> </tr> <tr> <td>MMIO_DENYNONE</td>
///              <td>Opens the file without denying other processes read or write access to the file. If the file has been opened
///              in compatibility mode by any other process, <b>mmioOpen</b> fails.</td> </tr> <tr> <td>MMIO_DENYREAD</td>
///              <td>Opens the file and denies other processes read access to the file. If the file has been opened in
///              compatibility mode or for read access by any other process, <b>mmioOpen</b> fails.</td> </tr> <tr>
///              <td>MMIO_DENYWRITE</td> <td>Opens the file and denies other processes write access to the file. If the file has
///              been opened in compatibility mode or for write access by any other process, <b>mmioOpen</b> fails.</td> </tr>
///              <tr> <td>MMIO_EXCLUSIVE</td> <td>Opens the file and denies other processes read and write access to the file. If
///              the file has been opened in any other mode for read or write access, even by the current process, <b>mmioOpen</b>
///              fails.</td> </tr> <tr> <td>MMIO_EXIST</td> <td>Determines whether the specified file exists and creates a fully
///              qualified file name from the path specified in <i>szFilename</i>. The return value is <b>TRUE</b> (cast to
///              <b>HMMIO</b>) if the qualification was successful and the file exists or <b>FALSE</b> otherwise. The file is not
///              opened, and the function does not return a valid multimedia file I/O file handle, so do not attempt to close the
///              file. <div class="alert"><b>Note</b> Applications should call <b>GetFileAttributes</b> or
///              <b>GetFileAttributesEx</b> instead.</div> <div> </div> </td> </tr> <tr> <td>MMIO_GETTEMP</td> <td> Creates a
///              temporary file name, optionally using the parameters passed in <i>szFilename.</i> For example, you can specify
///              "C:F" to create a temporary file residing on drive C, starting with letter "F". The resulting file name is copied
///              to the buffer pointed to by <i>szFilename</i>. The buffer must be large enough to hold at least 128 characters.
///              If the temporary file name was created successfully, the return value is <b>MMSYSERR_NOERROR</b> (cast to
///              <b>HMMIO</b>). Otherwise, the return value is <b>MMIOERR_FILENOTFOUND</b> otherwise. The file is not opened, and
///              the function does not return a valid multimedia file I/O file handle, so do not attempt to close the file. This
///              flag overrides all other flags. <div class="alert"><b>Note</b> Applications should call <b>GetTempFileName</b>
///              instead.</div> <div> </div> </td> </tr> <tr> <td>MMIO_PARSE</td> <td> Creates a fully qualified file name from
///              the path specified in <i>szFilename</i>. The fully qualified name is copied to the buffer pointed to by
///              <i>szFilename</i>. The buffer must be large enough to hold at least 128 characters. If the function succeeds, the
///              return value is <b>TRUE</b> (cast to <b>HMMIO</b>). Otherwise, the return value is <b>FALSE</b>. The file is not
///              opened, and the function does not return a valid multimedia file I/O file handle, so do not attempt to close the
///              file. If this flag is specified, all flags that open files are ignored. <div class="alert"><b>Note</b>
///              Applications should call <b>GetFullPathName</b> instead.</div> <div> </div> </td> </tr> <tr> <td>MMIO_READ</td>
///              <td>Opens the file for reading only. This is the default if MMIO_WRITE and MMIO_READWRITE are not specified.</td>
///              </tr> <tr> <td>MMIO_READWRITE</td> <td>Opens the file for reading and writing.</td> </tr> <tr>
///              <td>MMIO_WRITE</td> <td>Opens the file for writing only.</td> </tr> </table>
@DllImport("api-ms-win-mm-misc-l1-1-0")
HMMIO__* mmioOpenA(PSTR pszFileName, MMIOINFO* pmmioinfo, uint fdwOpen);

///The <b>mmioOpen</b> function opens a file for unbuffered or buffered I/O; creates a file; deletes a file; or checks
///whether a file exists. The file can be a standard file, a memory file, or an element of a custom storage system. The
///handle returned by mmioOpen is not a standard file handle; do not use it with any file I/O functions other than
///multimedia file I/O functions. <div class="alert"><b>Note</b> This function is deprecated. Applications should call
///CreateFile to create or open files.</div> <div> </div>
///Params:
///    pszFileName = Pointer to a buffer that contains the name of the file. If no I/O procedure is specified to open the file, the
///                  file name determines how the file is opened, as follows: <ul> <li>If the file name does not contain a plus sign
///                  (+), it is assumed to be the name of a standard file (that is, a file whose type is not <b>HMMIO</b>).</li>
///                  <li>If the file name is of the form EXAMPLE.EXT+ABC, the extension EXT is assumed to identify an installed I/O
///                  procedure which is called to perform I/O on the file. For more information, see mmioInstallIOProc.</li> <li>If
///                  the file name is <b>NULL</b> and no I/O procedure is given, the <b>adwInfo</b> member of the MMIOINFO structure
///                  is assumed to be the standard (non-<b>HMMIO</b>) file handle of a currently open file.</li> </ul> The file name
///                  should not be longer than 128 characters, including the terminating NULL character. When opening a memory file,
///                  set <i>szFilename</i> to <b>NULL</b>.
///    pmmioinfo = Pointer to an MMIOINFO structure containing extra parameters used by <b>mmioOpen</b>. Unless you are opening a
///                memory file, specifying the size of a buffer for buffered I/O, or specifying an uninstalled I/O procedure to open
///                a file, this parameter should be <b>NULL</b>. If this parameter is not <b>NULL</b>, all unused members of the
///                <b>MMIOINFO</b> structure it references must be set to zero, including the reserved members.
///    fdwOpen = Flags for the open operation. The MMIO_READ, MMIO_WRITE, and MMIO_READWRITE flags are mutually exclusive
///              â&euro;" only one should be specified. The MMIO_COMPAT, MMIO_EXCLUSIVE, MMIO_DENYWRITE, MMIO_DENYREAD, and
///              MMIO_DENYNONE flags are file-sharing flags. The following values are defined. <table> <tr> <th>Value </th>
///              <th>Meaning </th> </tr> <tr> <td>MMIO_ALLOCBUF</td> <td>Opens a file for buffered I/O. To allocate a buffer
///              larger or smaller than the default buffer size (8K, defined as MMIO_DEFAULTBUFFER), set the <b>cchBuffer</b>
///              member of the MMIOINFO structure to the desired buffer size. If <b>cchBuffer</b> is zero, the default buffer size
///              is used. If you are providing your own I/O buffer, this flag should not be used.</td> </tr> <tr>
///              <td>MMIO_COMPAT</td> <td>Opens the file with compatibility mode, allowing any process on a given machine to open
///              the file any number of times. If the file has been opened with any of the other sharing modes, <b>mmioOpen</b>
///              fails.</td> </tr> <tr> <td>MMIO_CREATE</td> <td>Creates a new file. If the file already exists, it is truncated
///              to zero length. For memory files, this flag indicates the end of the file is initially at the start of the
///              buffer.</td> </tr> <tr> <td>MMIO_DELETE</td> <td>Deletes a file. If this flag is specified, <i>szFilename</i>
///              should not be <b>NULL</b>. The return value is <b>TRUE</b> (cast to <b>HMMIO</b>) if the file was deleted
///              successfully or <b>FALSE</b> otherwise. Do not call the mmioClose function for a file that has been deleted. If
///              this flag is specified, all other flags that open files are ignored.</td> </tr> <tr> <td>MMIO_DENYNONE</td>
///              <td>Opens the file without denying other processes read or write access to the file. If the file has been opened
///              in compatibility mode by any other process, <b>mmioOpen</b> fails.</td> </tr> <tr> <td>MMIO_DENYREAD</td>
///              <td>Opens the file and denies other processes read access to the file. If the file has been opened in
///              compatibility mode or for read access by any other process, <b>mmioOpen</b> fails.</td> </tr> <tr>
///              <td>MMIO_DENYWRITE</td> <td>Opens the file and denies other processes write access to the file. If the file has
///              been opened in compatibility mode or for write access by any other process, <b>mmioOpen</b> fails.</td> </tr>
///              <tr> <td>MMIO_EXCLUSIVE</td> <td>Opens the file and denies other processes read and write access to the file. If
///              the file has been opened in any other mode for read or write access, even by the current process, <b>mmioOpen</b>
///              fails.</td> </tr> <tr> <td>MMIO_EXIST</td> <td>Determines whether the specified file exists and creates a fully
///              qualified file name from the path specified in <i>szFilename</i>. The return value is <b>TRUE</b> (cast to
///              <b>HMMIO</b>) if the qualification was successful and the file exists or <b>FALSE</b> otherwise. The file is not
///              opened, and the function does not return a valid multimedia file I/O file handle, so do not attempt to close the
///              file. <div class="alert"><b>Note</b> Applications should call <b>GetFileAttributes</b> or
///              <b>GetFileAttributesEx</b> instead.</div> <div> </div> </td> </tr> <tr> <td>MMIO_GETTEMP</td> <td> Creates a
///              temporary file name, optionally using the parameters passed in <i>szFilename.</i> For example, you can specify
///              "C:F" to create a temporary file residing on drive C, starting with letter "F". The resulting file name is copied
///              to the buffer pointed to by <i>szFilename</i>. The buffer must be large enough to hold at least 128 characters.
///              If the temporary file name was created successfully, the return value is <b>MMSYSERR_NOERROR</b> (cast to
///              <b>HMMIO</b>). Otherwise, the return value is <b>MMIOERR_FILENOTFOUND</b> otherwise. The file is not opened, and
///              the function does not return a valid multimedia file I/O file handle, so do not attempt to close the file. This
///              flag overrides all other flags. <div class="alert"><b>Note</b> Applications should call <b>GetTempFileName</b>
///              instead.</div> <div> </div> </td> </tr> <tr> <td>MMIO_PARSE</td> <td> Creates a fully qualified file name from
///              the path specified in <i>szFilename</i>. The fully qualified name is copied to the buffer pointed to by
///              <i>szFilename</i>. The buffer must be large enough to hold at least 128 characters. If the function succeeds, the
///              return value is <b>TRUE</b> (cast to <b>HMMIO</b>). Otherwise, the return value is <b>FALSE</b>. The file is not
///              opened, and the function does not return a valid multimedia file I/O file handle, so do not attempt to close the
///              file. If this flag is specified, all flags that open files are ignored. <div class="alert"><b>Note</b>
///              Applications should call <b>GetFullPathName</b> instead.</div> <div> </div> </td> </tr> <tr> <td>MMIO_READ</td>
///              <td>Opens the file for reading only. This is the default if MMIO_WRITE and MMIO_READWRITE are not specified.</td>
///              </tr> <tr> <td>MMIO_READWRITE</td> <td>Opens the file for reading and writing.</td> </tr> <tr>
///              <td>MMIO_WRITE</td> <td>Opens the file for writing only.</td> </tr> </table>
@DllImport("api-ms-win-mm-misc-l1-1-0")
HMMIO__* mmioOpenW(PWSTR pszFileName, MMIOINFO* pmmioinfo, uint fdwOpen);

///The <b>mmioRename</b> function renames the specified file.
///Params:
///    pszFileName = Pointer to a string containing the file name of the file to rename.
///    pszNewFileName = Pointer to a string containing the new file name.
///    pmmioinfo = Pointer to an MMIOINFO structure containing extra parameters used by <b>mmioRename</b>. If this parameter is not
///                <b>NULL</b>, all unused members of the <b>MMIOINFO</b> structure it references must be set to zero, including the
///                reserved members.
///    fdwRename = Flags for the rename operation. This parameter should be set to zero.
///Returns:
///    Returns zero if the file was renamed. Otherwise, returns an error code returned from <b>mmioRename</b> or from
///    the I/O procedure.
///    
@DllImport("api-ms-win-mm-misc-l1-1-0")
uint mmioRenameA(const(PSTR) pszFileName, const(PSTR) pszNewFileName, MMIOINFO* pmmioinfo, uint fdwRename);

///The <b>mmioRename</b> function renames the specified file.
///Params:
///    pszFileName = Pointer to a string containing the file name of the file to rename.
///    pszNewFileName = Pointer to a string containing the new file name.
///    pmmioinfo = Pointer to an MMIOINFO structure containing extra parameters used by <b>mmioRename</b>. If this parameter is not
///                <b>NULL</b>, all unused members of the <b>MMIOINFO</b> structure it references must be set to zero, including the
///                reserved members.
///    fdwRename = Flags for the rename operation. This parameter should be set to zero.
///Returns:
///    Returns zero if the file was renamed. Otherwise, returns an error code returned from <b>mmioRename</b> or from
///    the I/O procedure.
///    
@DllImport("api-ms-win-mm-misc-l1-1-0")
uint mmioRenameW(const(PWSTR) pszFileName, const(PWSTR) pszNewFileName, MMIOINFO* pmmioinfo, uint fdwRename);

///The <b>mmioClose</b> function closes a file that was opened by using the mmioOpen function.
///Params:
///    hmmio = File handle of the file to close.
///    fuClose = Flags for the close operation. The following value is defined. <table> <tr> <th>Value </th> <th>Meaning </th>
///              </tr> <tr> <td>MMIO_FHOPEN</td> <td>If the file was opened by passing a file handle whose type is not
///              <b>HMMIO</b>, using this flag tells the <b>mmioClose</b> function to close the multimedia file handle, but not
///              the standard file handle.</td> </tr> </table>
@DllImport("api-ms-win-mm-misc-l1-1-0")
uint mmioClose(HMMIO__* hmmio, uint fuClose);

///The <b>mmioRead</b> function reads a specified number of bytes from a file opened by using the mmioOpen function.
///Params:
///    hmmio = File handle of the file to be read.
///    pch = Pointer to a buffer to contain the data read from the file.
///    cch = Number of bytes to read from the file.
@DllImport("api-ms-win-mm-misc-l1-1-0")
int mmioRead(HMMIO__* hmmio, byte* pch, int cch);

///The <b>mmioWrite</b> function writes a specified number of bytes to a file opened by using the mmioOpen function.
///Params:
///    hmmio = File handle of the file.
///    pch = Pointer to the buffer to be written to the file.
///    cch = Number of bytes to write to the file.
///Returns:
///    Returns the number of bytes actually written. If there is an error writing to the file, the return value is -1.
///    
@DllImport("api-ms-win-mm-misc-l1-1-0")
int mmioWrite(HMMIO__* hmmio, const(byte)* pch, int cch);

///The <b>mmioSeek</b> function changes the current file position in a file opened by using the mmioOpen function.
///Params:
///    hmmio = File handle of the file to seek in.
///    lOffset = Offset to change the file position.
///    iOrigin = Flags indicating how the offset specified by <i>lOffset</i> is interpreted. The following values are defined:
///              <table> <tr> <th>Name</th> <th>Description</th> </tr> <tr> <td width="40%"><a id="SEEK_CUR"></a><a
///              id="seek_cur"></a><dl> <dt><b>SEEK_CUR</b></dt> </dl> </td> <td width="60%"> Seeks to <i>lOffset</i> bytes from
///              the current file position. </td> </tr> <tr> <td width="40%"><a id="SEEK_END"></a><a id="seek_end"></a><dl>
///              <dt><b>SEEK_END</b></dt> </dl> </td> <td width="60%"> Seeks to <i>lOffset</i> bytes from the end of the file.
///              </td> </tr> <tr> <td width="40%"><a id="SEEK_SET"></a><a id="seek_set"></a><dl> <dt><b>SEEK_SET</b></dt> </dl>
///              </td> <td width="60%"> Seeks to <i>lOffset</i> bytes from the beginning of the file. </td> </tr> </table>
///Returns:
///    Returns the new file position, in bytes, relative to the beginning of the file. If there is an error, the return
///    value is â€“ 1.
///    
@DllImport("api-ms-win-mm-misc-l1-1-0")
int mmioSeek(HMMIO__* hmmio, int lOffset, int iOrigin);

///The <b>mmioGetInfo</b> function retrieves information about a file opened by using the mmioOpen function. This
///information allows the application to directly access the I/O buffer, if the file is opened for buffered I/O.
///Params:
///    hmmio = File handle of the file.
///    pmmioinfo = Pointer to a buffer that receives an MMIOINFO structure that <b>mmioGetInfo</b> fills with information about the
///                file.
///    fuInfo = Reserved; must be zero.
///Returns:
///    Returns zero if successful or an error otherwise.
///    
@DllImport("api-ms-win-mm-misc-l1-1-0")
uint mmioGetInfo(HMMIO__* hmmio, MMIOINFO* pmmioinfo, uint fuInfo);

///The <b>mmioSetInfo</b> function updates the information retrieved by the mmioGetInfo function about a file opened by
///using the mmioOpen function. Use this function to terminate direct buffer access of a file opened for buffered I/O.
///Params:
///    hmmio = File handle of the file.
///    pmmioinfo = Pointer to an MMIOINFO structure filled with information by the mmioGetInfo function.
///    fuInfo = Reserved; must be zero.
///Returns:
///    Returns zero if successful or an error otherwise.
///    
@DllImport("api-ms-win-mm-misc-l1-1-0")
uint mmioSetInfo(HMMIO__* hmmio, MMIOINFO* pmmioinfo, uint fuInfo);

///The <b>mmioSetBuffer</b> function enables or disables buffered I/O, or changes the buffer or buffer size for a file
///opened by using the mmioOpen function.
///Params:
///    hmmio = File handle of the file.
///    pchBuffer = Pointer to an application-defined buffer to use for buffered I/O. If this parameter is <b>NULL</b>,
///                <b>mmioSetBuffer</b> allocates an internal buffer for buffered I/O.
///    cchBuffer = Size, in characters, of the application-defined buffer, or the size of the buffer for <b>mmioSetBuffer</b> to
///                allocate.
///    fuBuffer = Reserved; must be zero.
///Returns:
///    Returns zero if successful or an error otherwise. If an error occurs, the file handle remains valid. The
///    following values are defined. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>MMIOERR_CANNOTWRITE</b></dt> </dl> </td> <td width="60%"> The contents of the old buffer could not be
///    written to disk, so the operation was aborted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMIOERR_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The new buffer could not be allocated, probably
///    due to a lack of available memory. </td> </tr> </table>
///    
@DllImport("api-ms-win-mm-misc-l1-1-0")
uint mmioSetBuffer(HMMIO__* hmmio, PSTR pchBuffer, int cchBuffer, uint fuBuffer);

///The <b>mmioFlush</b> function writes the I/O buffer of a file to disk if the buffer has been written to.
///Params:
///    hmmio = File handle of a file opened by using the mmioOpen function.
///    fuFlush = Flag determining how the flush is carried out. It can be zero or the following. <table> <tr> <th>Value </th>
///              <th>Description </th> </tr> <tr> <td>MMIO_EMPTYBUF</td> <td>Empties the buffer after writing it to the disk.</td>
///              </tr> </table>
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>MMIOERR_CANNOTWRITE</b></dt>
///    </dl> </td> <td width="60%"> The contents of the buffer could not be written to disk. </td> </tr> </table>
///    
@DllImport("api-ms-win-mm-misc-l1-1-0")
uint mmioFlush(HMMIO__* hmmio, uint fuFlush);

///The <b>mmioAdvance</b> function advances the I/O buffer of a file set up for direct I/O buffer access with the
///mmioGetInfo function.
///Params:
///    hmmio = File handle of a file opened by using the mmioOpen function.
///    pmmioinfo = Pointer to the MMIOINFO structure obtained by using the mmioGetInfo function. This structure is used to set the
///                current file information, and then it is updated after the buffer is advanced. This parameter is optional.
///    fuAdvance = Flags for the operation. It can be one of the following. <table> <tr> <th>Value </th> <th>Meaning </th> </tr>
///                <tr> <td>MMIO_READ</td> <td>Buffer is filled from the file.</td> </tr> <tr> <td>MMIO_WRITE</td> <td>Buffer is
///                written to the file.</td> </tr> </table>
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMIOERR_CANNOTEXPAND</b></dt> </dl> </td> <td width="60%"> The specified memory file cannot be expanded,
///    probably because the <b>adwInfo</b> member of the MMIOINFO structure was set to zero in the initial call to the
///    mmioOpen function. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMIOERR_CANNOTREAD</b></dt> </dl> </td> <td
///    width="60%"> An error occurred while refilling the buffer. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMIOERR_CANNOTWRITE</b></dt> </dl> </td> <td width="60%"> The contents of the buffer could not be written
///    to disk. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMIOERR_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
///    There was not enough memory to expand a memory file for further writing. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMIOERR_UNBUFFERED</b></dt> </dl> </td> <td width="60%"> The specified file is not opened for buffered
///    I/O. </td> </tr> </table>
///    
@DllImport("api-ms-win-mm-misc-l1-1-0")
uint mmioAdvance(HMMIO__* hmmio, MMIOINFO* pmmioinfo, uint fuAdvance);

///The <b>mmioSendMessage</b> function sends a message to the I/O procedure associated with the specified file.
///Params:
///    hmmio = File handle for a file opened by using the mmioOpen function.
///    uMsg = Message to send to the I/O procedure.
///    lParam1 = Parameter for the message.
///    lParam2 = Parameter for the message.
///Returns:
///    Returns a value that corresponds to the message. If the I/O procedure does not recognize the message, the return
///    value should be zero.
///    
@DllImport("api-ms-win-mm-misc-l1-1-0")
LRESULT mmioSendMessage(HMMIO__* hmmio, uint uMsg, LPARAM lParam1, LPARAM lParam2);

///The <b>mmioDescend</b> function descends into a chunk of a RIFF file that was opened by using the mmioOpen function.
///It can also search for a given chunk.
///Params:
///    hmmio = File handle of an open RIFF file.
///    pmmcki = Pointer to a buffer that receives an MMCKINFO structure.
///    pmmckiParent = Pointer to an optional application-defined MMCKINFO structure identifying the parent of the chunk being searched
///                   for. If this parameter is not <b>NULL</b>, <b>mmioDescend</b> assumes the <b>MMCKINFO</b> structure it refers to
///                   was filled when <b>mmioDescend</b> was called to descend into the parent chunk, and <b>mmioDescend</b> searches
///                   for a chunk within the parent chunk. Set this parameter to <b>NULL</b> if no parent chunk is being specified.
///    fuDescend = Search flags. If no flags are specified, <b>mmioDescend</b> descends into the chunk beginning at the current file
///                position. The following values are defined. <table> <tr> <th>Value </th> <th>Meaning </th> </tr> <tr>
///                <td>MMIO_FINDCHUNK</td> <td>Searches for a chunk with the specified chunk identifier.</td> </tr> <tr>
///                <td>MMIO_FINDLIST</td> <td>Searches for a chunk with the chunk identifier "LIST" and with the specified form
///                type.</td> </tr> <tr> <td>MMIO_FINDRIFF</td> <td>Searches for a chunk with the chunk identifier "RIFF" and with
///                the specified form type.</td> </tr> </table>
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMIOERR_CHUNKNOTFOUND</b></dt> </dl> </td> <td width="60%"> The end of the file (or the end of the parent
///    chunk, if given) was reached before the desired chunk was found. </td> </tr> </table>
///    
@DllImport("api-ms-win-mm-misc-l1-1-0")
uint mmioDescend(HMMIO__* hmmio, MMCKINFO* pmmcki, const(MMCKINFO)* pmmckiParent, uint fuDescend);

///The <b>mmioAscend</b> function ascends out of a chunk in a RIFF file descended into with the mmioDescend function or
///created with the mmioCreateChunk function.
///Params:
///    hmmio = File handle of an open RIFF file.
///    pmmcki = Pointer to an application-defined MMCKINFO structure previously filled by the mmioDescend or mmioCreateChunk
///             function.
///    fuAscend = Reserved; must be zero.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMIOERR_CANNOTSEEK</b></dt> </dl> </td> <td width="60%"> There was an error while seeking to the end of
///    the chunk. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMIOERR_CANNOTWRITE</b></dt> </dl> </td> <td
///    width="60%"> The contents of the buffer could not be written to disk. </td> </tr> </table>
///    
@DllImport("api-ms-win-mm-misc-l1-1-0")
uint mmioAscend(HMMIO__* hmmio, MMCKINFO* pmmcki, uint fuAscend);

///The <b>mmioCreateChunk</b> function creates a chunk in a RIFF file that was opened by using the mmioOpen function.
///The new chunk is created at the current file position. After the new chunk is created, the current file position is
///the beginning of the data portion of the new chunk.
///Params:
///    hmmio = File handle of an open RIFF file.
///    pmmcki = Pointer to a buffer that receives a MMCKINFO structure containing information about the chunk to be created.
///    fuCreate = Flags identifying what type of chunk to create. The following values are defined. <table> <tr> <th>Value </th>
///               <th>Meaning </th> </tr> <tr> <td>MMIO_CREATELIST</td> <td>"LIST" chunk.</td> </tr> <tr> <td>MMIO_CREATERIFF</td>
///               <td>"RIFF" chunk.</td> </tr> </table>
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMIOERR_CANNOTSEEK</b></dt> </dl> </td> <td width="60%"> Unable to determine offset of the data portion of
///    the chunk. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMIOERR_CANNOTWRITE</b></dt> </dl> </td> <td
///    width="60%"> Unable to write the chunk header. </td> </tr> </table>
///    
@DllImport("api-ms-win-mm-misc-l1-1-0")
uint mmioCreateChunk(HMMIO__* hmmio, MMCKINFO* pmmcki, uint fuCreate);

@DllImport("WINMM")
BOOL sndPlaySoundA(const(PSTR) pszSound, uint fuSound);

@DllImport("WINMM")
BOOL sndPlaySoundW(const(PWSTR) pszSound, uint fuSound);

@DllImport("WINMM")
BOOL PlaySoundA(const(PSTR) pszSound, ptrdiff_t hmod, uint fdwSound);

@DllImport("WINMM")
BOOL PlaySoundW(const(PWSTR) pszSound, ptrdiff_t hmod, uint fdwSound);

///The <b>waveOutGetNumDevs</b> function retrieves the number of waveform-audio output devices present in the system.
///Returns:
///    Returns the number of devices. A return value of zero means that no devices are present or that an error
///    occurred.
///    
@DllImport("WINMM")
uint waveOutGetNumDevs();

@DllImport("WINMM")
uint waveOutGetDevCapsA(size_t uDeviceID, WAVEOUTCAPSA* pwoc, uint cbwoc);

@DllImport("WINMM")
uint waveOutGetDevCapsW(size_t uDeviceID, WAVEOUTCAPSW* pwoc, uint cbwoc);

///The <b>waveOutGetVolume</b> function retrieves the current volume level of the specified waveform-audio output
///device.
///Params:
///    hwo = Handle to an open waveform-audio output device. This parameter can also be a device identifier.
///    pdwVolume = Pointer to a variable to be filled with the current volume setting. The low-order word of this location contains
///                the left-channel volume setting, and the high-order word contains the right-channel setting. A value of 0xFFFF
///                represents full volume, and a value of 0x0000 is silence. If a device does not support both left and right volume
///                control, the low-order word of the specified location contains the mono volume level. The full 16-bit setting(s)
///                set with the waveOutSetVolume function is returned, regardless of whether the device supports the full 16 bits of
///                volume-level control.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> Specified device handle is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> No device driver is
///    present. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%">
///    Unable to allocate or lock memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOTSUPPORTED</b></dt>
///    </dl> </td> <td width="60%"> Function isn't supported. </td> </tr> </table>
///    
@DllImport("WINMM")
uint waveOutGetVolume(HWAVEOUT hwo, uint* pdwVolume);

///The <b>waveOutSetVolume</b> function sets the volume level of the specified waveform-audio output device.
///Params:
///    hwo = Handle to an open waveform-audio output device. This parameter can also be a device identifier.
///    dwVolume = New volume setting. The low-order word contains the left-channel volume setting, and the high-order word contains
///               the right-channel setting. A value of 0xFFFF represents full volume, and a value of 0x0000 is silence. If a
///               device does not support both left and right volume control, the low-order word of <i>dwVolume</i> specifies the
///               volume level, and the high-order word is ignored.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> Specified device handle is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> No device driver is
///    present. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%">
///    Unable to allocate or lock memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOTSUPPORTED</b></dt>
///    </dl> </td> <td width="60%"> Function is not supported. </td> </tr> </table>
///    
@DllImport("WINMM")
uint waveOutSetVolume(HWAVEOUT hwo, uint dwVolume);

@DllImport("WINMM")
uint waveOutGetErrorTextA(uint mmrError, PSTR pszText, uint cchText);

@DllImport("WINMM")
uint waveOutGetErrorTextW(uint mmrError, PWSTR pszText, uint cchText);

///The <b>waveOutOpen</b> function opens the given waveform-audio output device for playback.
///Params:
///    phwo = Pointer to a buffer that receives a handle identifying the open waveform-audio output device. Use the handle to
///           identify the device when calling other waveform-audio output functions. This parameter might be <b>NULL</b> if
///           the <b>WAVE_FORMAT_QUERY</b> flag is specified for <i>fdwOpen</i>.
///    uDeviceID = Identifier of the waveform-audio output device to open. It can be either a device identifier or a handle of an
///                open waveform-audio input device. You can also use the following flag instead of a device identifier: <table>
///                <tr> <th>Value </th> <th>Meaning </th> </tr> <tr> <td><b>WAVE_MAPPER</b></td> <td>The function selects a
///                waveform-audio output device capable of playing the given format.</td> </tr> </table>
///    pwfx = Pointer to a WAVEFORMATEX structure that identifies the format of the waveform-audio data to be sent to the
///           device. You can free this structure immediately after passing it to <b>waveOutOpen</b>.
///    dwCallback = Specifies the callback mechanism. The value must be one of the following: <ul> <li>A pointer to a callback
///                 function. For the function signature, see waveOutProc.</li> <li>A handle to a window.</li> <li>A thread
///                 identifier.</li> <li>A handle to an event.</li> <li>The value <b>NULL</b>.</li> </ul> The <i>fdwOpen</i>
///                 parameter specifies how the <i>dwCallback</i> parameter is interpreted. For more information, see Remarks.
///    dwInstance = User-instance data passed to the callback mechanism. This parameter is not used with the window callback
///                 mechanism.
///    fdwOpen = Flags for opening the device. The following values are defined. <table> <tr> <th>Value </th> <th>Meaning </th>
///              </tr> <tr> <td><b>CALLBACK_EVENT</b></td> <td>The <i>dwCallback</i> parameter is an event handle.</td> </tr> <tr>
///              <td><b>CALLBACK_FUNCTION</b></td> <td>The <i>dwCallback</i> parameter is a callback procedure address.</td> </tr>
///              <tr> <td><b>CALLBACK_NULL</b></td> <td>No callback mechanism. This is the default setting.</td> </tr> <tr>
///              <td><b>CALLBACK_THREAD</b></td> <td>The <i>dwCallback</i> parameter is a thread identifier.</td> </tr> <tr>
///              <td><b>CALLBACK_WINDOW</b></td> <td>The <i>dwCallback</i> parameter is a window handle.</td> </tr> <tr>
///              <td><b>WAVE_ALLOWSYNC</b></td> <td>If this flag is specified, a synchronous waveform-audio device can be opened.
///              If this flag is not specified while opening a synchronous driver, the device will fail to open.</td> </tr> <tr>
///              <td><b>WAVE_MAPPED_DEFAULT_COMMUNICATION_DEVICE</b></td> <td> If this flag is specified and the <i>uDeviceID</i>
///              parameter is <b>WAVE_MAPPER</b>, the function opens the default communication device. This flag applies only when
///              <i>uDeviceID</i> equals <b>WAVE_MAPPER</b>. <div class="alert"><b>Note</b> Requires Windows 7</div> <div> </div>
///              </td> </tr> <tr> <td><b>WAVE_FORMAT_DIRECT</b></td> <td>If this flag is specified, the ACM driver does not
///              perform conversions on the audio data.</td> </tr> <tr> <td><b>WAVE_FORMAT_QUERY</b></td> <td>If this flag is
///              specified, <b>waveOutOpen</b> queries the device to determine if it supports the given format, but the device is
///              not actually opened.</td> </tr> <tr> <td><b>WAVE_MAPPED</b></td> <td>If this flag is specified, the
///              <i>uDeviceID</i> parameter specifies a waveform-audio device to be mapped to by the wave mapper.</td> </tr>
///              </table>
///Returns:
///    Returns <b>MMSYSERR_NOERROR</b> if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_ALLOCATED</b></dt> </dl> </td> <td width="60%"> Specified resource is already allocated. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_BADDEVICEID</b></dt> </dl> </td> <td width="60%"> Specified
///    device identifier is out of range. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl>
///    </td> <td width="60%"> No device driver is present. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%"> Unable to allocate or lock memory. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WAVERR_BADFORMAT</b></dt> </dl> </td> <td width="60%"> Attempted to open with an
///    unsupported waveform-audio format. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WAVERR_SYNC</b></dt> </dl> </td>
///    <td width="60%"> The device is synchronous but waveOutOpen was called without using the <b>WAVE_ALLOWSYNC</b>
///    flag. </td> </tr> </table>
///    
@DllImport("WINMM")
uint waveOutOpen(HWAVEOUT* phwo, uint uDeviceID, WAVEFORMATEX* pwfx, size_t dwCallback, size_t dwInstance, 
                 uint fdwOpen);

///The <b>waveOutClose</b> function closes the given waveform-audio output device.
///Params:
///    hwo = Handle to the waveform-audio output device. If the function succeeds, the handle is no longer valid after this
///          call.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> Specified device handle is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> No device driver is
///    present. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%">
///    Unable to allocate or lock memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WAVERR_STILLPLAYING</b></dt>
///    </dl> </td> <td width="60%"> There are still buffers in the queue. </td> </tr> </table>
///    
@DllImport("WINMM")
uint waveOutClose(HWAVEOUT hwo);

///The <b>waveOutPrepareHeader</b> function prepares a waveform-audio data block for playback.
///Params:
///    hwo = Handle to the waveform-audio output device.
///    pwh = Pointer to a WAVEHDR structure that identifies the data block to be prepared.
///    cbwh = Size, in bytes, of the WAVEHDR structure.
///Returns:
///    Returns <b>MMSYSERR_NOERROR</b> if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> Specified device handle is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> No device driver is
///    present. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%">
///    Unable to allocate or lock memory. </td> </tr> </table>
///    
@DllImport("WINMM")
uint waveOutPrepareHeader(HWAVEOUT hwo, WAVEHDR* pwh, uint cbwh);

///The <b>waveOutUnprepareHeader</b> function cleans up the preparation performed by the waveOutPrepareHeader function.
///This function must be called after the device driver is finished with a data block. You must call this function
///before freeing the buffer.
///Params:
///    hwo = Handle to the waveform-audio output device.
///    pwh = Pointer to a WAVEHDR structure identifying the data block to be cleaned up.
///    cbwh = Size, in bytes, of the <b>WAVEHDR</b> structure.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> Specified device handle is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> No device driver is
///    present. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%">
///    Unable to allocate or lock memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WAVERR_STILLPLAYING</b></dt>
///    </dl> </td> <td width="60%"> The data block pointed to by the <i>pwh</i> parameter is still in the queue. </td>
///    </tr> </table>
///    
@DllImport("WINMM")
uint waveOutUnprepareHeader(HWAVEOUT hwo, WAVEHDR* pwh, uint cbwh);

///The <b>waveOutWrite</b> function sends a data block to the given waveform-audio output device.
///Params:
///    hwo = Handle to the waveform-audio output device.
///    pwh = Pointer to a WAVEHDR structure containing information about the data block.
///    cbwh = Size, in bytes, of the <b>WAVEHDR</b> structure.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> Specified device handle is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> No device driver is
///    present. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%">
///    Unable to allocate or lock memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WAVERR_UNPREPARED</b></dt> </dl>
///    </td> <td width="60%"> The data block pointed to by the <i>pwh</i> parameter hasn't been prepared. </td> </tr>
///    </table>
///    
@DllImport("WINMM")
uint waveOutWrite(HWAVEOUT hwo, WAVEHDR* pwh, uint cbwh);

///The <b>waveOutPause</b> function pauses playback on the given waveform-audio output device. The current position is
///saved. Use the waveOutRestart function to resume playback from the current position.
///Params:
///    hwo = Handle to the waveform-audio output device.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> Specified device handle is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> No device driver is
///    present. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%">
///    Unable to allocate or lock memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOTSUPPORTED</b></dt>
///    </dl> </td> <td width="60%"> Specified device is synchronous and does not support pausing. </td> </tr> </table>
///    
@DllImport("WINMM")
uint waveOutPause(HWAVEOUT hwo);

///The <b>waveOutRestart</b> function resumes playback on a paused waveform-audio output device.
///Params:
///    hwo = Handle to the waveform-audio output device.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> Specified device handle is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> No device driver is
///    present. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%">
///    Unable to allocate or lock memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOTSUPPORTED</b></dt>
///    </dl> </td> <td width="60%"> Specified device is synchronous and does not support pausing. </td> </tr> </table>
///    
@DllImport("WINMM")
uint waveOutRestart(HWAVEOUT hwo);

///The <b>waveOutReset</b> function stops playback on the given waveform-audio output device and resets the current
///position to zero. All pending playback buffers are marked as done (WHDR_DONE) and returned to the application.
///Params:
///    hwo = Handle to the waveform-audio output device.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> Specified device handle is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> No device driver is
///    present. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%">
///    Unable to allocate or lock memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOTSUPPORTED</b></dt>
///    </dl> </td> <td width="60%"> Specified device is synchronous and does not support pausing. </td> </tr> </table>
///    
@DllImport("WINMM")
uint waveOutReset(HWAVEOUT hwo);

///The <b>waveOutBreakLoop</b> function breaks a loop on the given waveform-audio output device and allows playback to
///continue with the next block in the driver list.
///Params:
///    hwo = Handle to the waveform-audio output device.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> Specified device handle is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> No device driver is
///    present. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%">
///    Unable to allocate or lock memory. </td> </tr> </table>
///    
@DllImport("WINMM")
uint waveOutBreakLoop(HWAVEOUT hwo);

///The <b>waveOutGetPosition</b> function retrieves the current playback position of the given waveform-audio output
///device.
///Params:
///    hwo = Handle to the waveform-audio output device.
///    pmmt = Pointer to an MMTIME structure.
///    cbmmt = Size, in bytes, of the <b>MMTIME</b> structure.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> Specified device handle is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> No device driver is
///    present. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%">
///    Unable to allocate or lock memory. </td> </tr> </table>
///    
@DllImport("WINMM")
uint waveOutGetPosition(HWAVEOUT hwo, MMTIME* pmmt, uint cbmmt);

///The <b>waveOutGetPitch</b> function retrieves the current pitch setting for the specified waveform-audio output
///device.
///Params:
///    hwo = Handle to the waveform-audio output device.
///    pdwPitch = Pointer to a variable to be filled with the current pitch multiplier setting. The pitch multiplier indicates the
///               current change in pitch from the original authored setting. The pitch multiplier must be a positive value. The
///               pitch multiplier is specified as a fixed-point value. The high-order word of the variable contains the signed
///               integer part of the number, and the low-order word contains the fractional part. A value of 0x8000 in the
///               low-order word represents one-half, and 0x4000 represents one-quarter. For example, the value 0x00010000
///               specifies a multiplier of 1.0 (no pitch change), and a value of 0x000F8000 specifies a multiplier of 15.5.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> Specified device handle is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> No device driver is
///    present. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%">
///    Unable to allocate or lock memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOTSUPPORTED</b></dt>
///    </dl> </td> <td width="60%"> Function isn't supported. </td> </tr> </table>
///    
@DllImport("WINMM")
uint waveOutGetPitch(HWAVEOUT hwo, uint* pdwPitch);

///The <b>waveOutSetPitch</b> function sets the pitch for the specified waveform-audio output device.
///Params:
///    hwo = Handle to the waveform-audio output device.
///    dwPitch = New pitch multiplier setting. This setting indicates the current change in pitch from the original authored
///              setting. The pitch multiplier must be a positive value. The pitch multiplier is specified as a fixed-point value.
///              The high-order word contains the signed integer part of the number, and the low-order word contains the
///              fractional part. A value of 0x8000 in the low-order word represents one-half, and 0x4000 represents one-quarter.
///              For example, the value 0x00010000 specifies a multiplier of 1.0 (no pitch change), and a value of 0x000F8000
///              specifies a multiplier of 15.5.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> Specified device handle is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> No device driver is
///    present. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%">
///    Unable to allocate or lock memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOTSUPPORTED</b></dt>
///    </dl> </td> <td width="60%"> Function isn't supported. </td> </tr> </table>
///    
@DllImport("WINMM")
uint waveOutSetPitch(HWAVEOUT hwo, uint dwPitch);

///The <b>waveOutGetPlaybackRate</b> function retrieves the current playback rate for the specified waveform-audio
///output device.
///Params:
///    hwo = Handle to the waveform-audio output device.
///    pdwRate = Pointer to a variable to be filled with the current playback rate. The playback rate setting is a multiplier
///              indicating the current change in playback rate from the original authored setting. The playback rate multiplier
///              must be a positive value. The rate is specified as a fixed-point value. The high-order word of the variable
///              contains the signed integer part of the number, and the low-order word contains the fractional part. A value of
///              0x8000 in the low-order word represents one-half, and 0x4000 represents one-quarter. For example, the value
///              0x00010000 specifies a multiplier of 1.0 (no playback rate change), and a value of 0x000F8000 specifies a
///              multiplier of 15.5.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> Specified device handle is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> No device driver is
///    present. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%">
///    Unable to allocate or lock memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOTSUPPORTED</b></dt>
///    </dl> </td> <td width="60%"> Function isn't supported. </td> </tr> </table>
///    
@DllImport("WINMM")
uint waveOutGetPlaybackRate(HWAVEOUT hwo, uint* pdwRate);

///The <b>waveOutSetPlaybackRate</b> function sets the playback rate for the specified waveform-audio output device.
///Params:
///    hwo = Handle to the waveform-audio output device.
///    dwRate = New playback rate setting. This setting is a multiplier indicating the current change in playback rate from the
///             original authored setting. The playback rate multiplier must be a positive value. The rate is specified as a
///             fixed-point value. The high-order word contains the signed integer part of the number, and the low-order word
///             contains the fractional part. A value of 0x8000 in the low-order word represents one-half, and 0x4000 represents
///             one-quarter. For example, the value 0x00010000 specifies a multiplier of 1.0 (no playback rate change), and a
///             value of 0x000F8000 specifies a multiplier of 15.5.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> Specified device handle is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> No device driver is
///    present. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%">
///    Unable to allocate or lock memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOTSUPPORTED</b></dt>
///    </dl> </td> <td width="60%"> Function isn't supported. </td> </tr> </table>
///    
@DllImport("WINMM")
uint waveOutSetPlaybackRate(HWAVEOUT hwo, uint dwRate);

///The <b>waveOutGetID</b> function retrieves the device identifier for the given waveform-audio output device. This
///function is supported for backward compatibility. New applications can cast a handle of the device rather than
///retrieving the device identifier.
///Params:
///    hwo = Handle to the waveform-audio output device.
///    puDeviceID = Pointer to a variable to be filled with the device identifier.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The <i>hwo</i> parameter specifies an invalid
///    handle. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> No
///    device driver is present. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td
///    width="60%"> Unable to allocate or lock memory. </td> </tr> </table>
///    
@DllImport("WINMM")
uint waveOutGetID(HWAVEOUT hwo, uint* puDeviceID);

///The <b>waveOutMessage</b> function sends messages to the waveform-audio output device drivers.
///Params:
///    hwo = Identifier of the waveform device that receives the message. You must cast the device ID to the <b>HWAVEOUT</b>
///          handle type. If you supply a handle instead of a device ID, the function fails and returns the MMSYSERR_NOSUPPORT
///          error code.
///    uMsg = Message to send.
///    dw1 = Message parameter.
///    dw2 = Message parameter.
///Returns:
///    Returns the value returned from the driver.
///    
@DllImport("WINMM")
uint waveOutMessage(HWAVEOUT hwo, uint uMsg, size_t dw1, size_t dw2);

///The <b>waveInGetNumDevs</b> function returns the number of waveform-audio input devices present in the system.
///Returns:
///    Returns the number of devices. A return value of zero means that no devices are present or that an error
///    occurred.
///    
@DllImport("WINMM")
uint waveInGetNumDevs();

@DllImport("WINMM")
uint waveInGetDevCapsA(size_t uDeviceID, WAVEINCAPSA* pwic, uint cbwic);

@DllImport("WINMM")
uint waveInGetDevCapsW(size_t uDeviceID, WAVEINCAPSW* pwic, uint cbwic);

@DllImport("WINMM")
uint waveInGetErrorTextA(uint mmrError, PSTR pszText, uint cchText);

@DllImport("WINMM")
uint waveInGetErrorTextW(uint mmrError, PWSTR pszText, uint cchText);

///The <b>waveInOpen</b> function opens the given waveform-audio input device for recording.
///Params:
///    phwi = Pointer to a buffer that receives a handle identifying the open waveform-audio input device. Use this handle to
///           identify the device when calling other waveform-audio input functions. This parameter can be <b>NULL</b> if
///           <b>WAVE_FORMAT_QUERY</b> is specified for <i>fdwOpen</i>.
///    uDeviceID = Identifier of the waveform-audio input device to open. It can be either a device identifier or a handle of an
///                open waveform-audio input device. You can use the following flag instead of a device identifier. <table> <tr>
///                <th>Value </th> <th>Meaning </th> </tr> <tr> <td>WAVE_MAPPER</td> <td>The function selects a waveform-audio input
///                device capable of recording in the specified format.</td> </tr> </table>
///    pwfx = Pointer to a WAVEFORMATEX structure that identifies the desired format for recording waveform-audio data. You can
///           free this structure immediately after <b>waveInOpen</b> returns.
///    dwCallback = Pointer to a fixed callback function, an event handle, a handle to a window, or the identifier of a thread to be
///                 called during waveform-audio recording to process messages related to the progress of recording. If no callback
///                 function is required, this value can be zero. For more information on the callback function, see waveInProc.
///    dwInstance = User-instance data passed to the callback mechanism. This parameter is not used with the window callback
///                 mechanism.
///    fdwOpen = Flags for opening the device. The following values are defined. <table> <tr> <th>Value </th> <th>Meaning </th>
///              </tr> <tr> <td><b>CALLBACK_EVENT</b></td> <td>The <i>dwCallback</i> parameter is an event handle.</td> </tr> <tr>
///              <td><b>CALLBACK_FUNCTION</b></td> <td>The <i>dwCallback</i> parameter is a callback procedure address.</td> </tr>
///              <tr> <td><b>CALLBACK_NULL</b></td> <td>No callback mechanism. This is the default setting.</td> </tr> <tr>
///              <td><b>CALLBACK_THREAD</b></td> <td>The <i>dwCallback</i> parameter is a thread identifier.</td> </tr> <tr>
///              <td><b>CALLBACK_WINDOW</b></td> <td>The <i>dwCallback</i> parameter is a window handle.</td> </tr> <tr>
///              <td><b>WAVE_MAPPED_DEFAULT_COMMUNICATION_DEVICE</b></td> <td> If this flag is specified and the <i>uDeviceID</i>
///              parameter is <b>WAVE_MAPPER</b>, the function opens the default communication device. This flag applies only when
///              <i>uDeviceID</i> equals <b>WAVE_MAPPER</b>. <div class="alert"><b>Note</b> Requires Windows 7</div> <div> </div>
///              </td> </tr> <tr> <td><b>WAVE_FORMAT_DIRECT</b></td> <td>If this flag is specified, the ACM driver does not
///              perform conversions on the audio data.</td> </tr> <tr> <td><b>WAVE_FORMAT_QUERY</b></td> <td>The function queries
///              the device to determine whether it supports the given format, but it does not open the device.</td> </tr> <tr>
///              <td><b>WAVE_MAPPED</b></td> <td>The <i>uDeviceID</i> parameter specifies a waveform-audio device to be mapped to
///              by the wave mapper.</td> </tr> </table>
///Returns:
///    Returns <b>MMSYSERR_NOERROR</b> if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_ALLOCATED</b></dt> </dl> </td> <td width="60%"> Specified resource is already allocated. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_BADDEVICEID</b></dt> </dl> </td> <td width="60%"> Specified
///    device identifier is out of range. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl>
///    </td> <td width="60%"> No device driver is present. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%"> Unable to allocate or lock memory. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WAVERR_BADFORMAT</b></dt> </dl> </td> <td width="60%"> Attempted to open with an
///    unsupported waveform-audio format. </td> </tr> </table>
///    
@DllImport("WINMM")
uint waveInOpen(HWAVEIN* phwi, uint uDeviceID, WAVEFORMATEX* pwfx, size_t dwCallback, size_t dwInstance, 
                uint fdwOpen);

///The <b>waveInClose</b> function closes the given waveform-audio input device.
///Params:
///    hwi = Handle to the waveform-audio input device. If the function succeeds, the handle is no longer valid after this
///          call.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> Specified device handle is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> No device driver is
///    present. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%">
///    Unable to allocate or lock memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WAVERR_STILLPLAYING</b></dt>
///    </dl> </td> <td width="60%"> There are still buffers in the queue. </td> </tr> </table>
///    
@DllImport("WINMM")
uint waveInClose(HWAVEIN hwi);

///The <b>waveInPrepareHeader</b> function prepares a buffer for waveform-audio input.
///Params:
///    hwi = Handle to the waveform-audio input device.
///    pwh = Pointer to a WAVEHDR structure that identifies the buffer to be prepared.
///    cbwh = Size, in bytes, of the <b>WAVEHDR</b> structure.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> Specified device handle is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> No device driver is
///    present. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%">
///    Unable to allocate or lock memory. </td> </tr> </table>
///    
@DllImport("WINMM")
uint waveInPrepareHeader(HWAVEIN hwi, WAVEHDR* pwh, uint cbwh);

///The <b>waveInUnprepareHeader</b> function cleans up the preparation performed by the waveInPrepareHeader function.
///This function must be called after the device driver fills a buffer and returns it to the application. You must call
///this function before freeing the buffer.
///Params:
///    hwi = Handle to the waveform-audio input device.
///    pwh = Pointer to a WAVEHDR structure identifying the buffer to be cleaned up.
///    cbwh = Size, in bytes, of the <b>WAVEHDR</b> structure.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> Specified device handle is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> No device driver is
///    present. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%">
///    Unable to allocate or lock memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WAVERR_STILLPLAYING</b></dt>
///    </dl> </td> <td width="60%"> The buffer pointed to by the <i>pwh</i> parameter is still in the queue. </td> </tr>
///    </table>
///    
@DllImport("WINMM")
uint waveInUnprepareHeader(HWAVEIN hwi, WAVEHDR* pwh, uint cbwh);

///The <b>waveInAddBuffer</b> function sends an input buffer to the given waveform-audio input device. When the buffer
///is filled, the application is notified.
///Params:
///    hwi = Handle to the waveform-audio input device.
///    pwh = Pointer to a WAVEHDR structure that identifies the buffer.
///    cbwh = Size, in bytes, of the <b>WAVEHDR</b> structure.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> Specified device handle is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> No device driver is
///    present. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%">
///    Unable to allocate or lock memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WAVERR_UNPREPARED</b></dt> </dl>
///    </td> <td width="60%"> The buffer pointed to by the <i>pwh</i> parameter hasn't been prepared. </td> </tr>
///    </table>
///    
@DllImport("WINMM")
uint waveInAddBuffer(HWAVEIN hwi, WAVEHDR* pwh, uint cbwh);

///The <b>waveInStart</b> function starts input on the given waveform-audio input device.
///Params:
///    hwi = Handle to the waveform-audio input device.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> Specified device handle is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> No device driver is
///    present. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%">
///    Unable to allocate or lock memory. </td> </tr> </table>
///    
@DllImport("WINMM")
uint waveInStart(HWAVEIN hwi);

///The <b>waveInStop</b> function stops waveform-audio input.
///Params:
///    hwi = Handle to the waveform-audio input device.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> Specified device handle is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> No device driver is
///    present. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%">
///    Unable to allocate or lock memory. </td> </tr> </table>
///    
@DllImport("WINMM")
uint waveInStop(HWAVEIN hwi);

///The <b>waveInReset</b> function stops input on the given waveform-audio input device and resets the current position
///to zero. All pending buffers are marked as done and returned to the application.
///Params:
///    hwi = Handle to the waveform-audio input device.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> Specified device handle is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> No device driver is
///    present. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%">
///    Unable to allocate or lock memory. </td> </tr> </table>
///    
@DllImport("WINMM")
uint waveInReset(HWAVEIN hwi);

///<p class="CCE_Message">[<b>waveInGetPosition</b> is no longer supported for use as of Windows Vista. Instead, use
///IAudioClock::GetPosition.] The <b>waveInGetPosition</b> function retrieves the current input position of the given
///waveform-audio input device.
///Params:
///    hwi = Handle to the waveform-audio input device.
///    pmmt = Pointer to an MMTIME structure.
///    cbmmt = Size, in bytes, of the MMTIME structure.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> Specified device handle is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> No device driver is
///    present. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%">
///    Unable to allocate or lock memory. </td> </tr> </table>
///    
@DllImport("WINMM")
uint waveInGetPosition(HWAVEIN hwi, MMTIME* pmmt, uint cbmmt);

///The <b>waveInGetID</b> function gets the device identifier for the given waveform-audio input device. This function
///is supported for backward compatibility. New applications can cast a handle of the device rather than retrieving the
///device identifier.
///Params:
///    hwi = Handle to the waveform-audio input device.
///    puDeviceID = Pointer to a variable to be filled with the device identifier.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The <i>hwi</i> parameter specifies an invalid
///    handle. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> No
///    device driver is present. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td
///    width="60%"> Unable to allocate or lock memory. </td> </tr> </table>
///    
@DllImport("WINMM")
uint waveInGetID(HWAVEIN hwi, uint* puDeviceID);

///The <b>waveInMessage</b> function sends messages to the waveform-audio input device drivers.
///Params:
///    hwi = Identifier of the waveform device that receives the message. You must cast the device ID to the <b>HWAVEIN</b>
///          handle type. If you supply a handle instead of a device ID, the function fails and returns the MMSYSERR_NOSUPPORT
///          error code.
///    uMsg = Message to send.
///    dw1 = Message parameter.
///    dw2 = Message parameter.
///Returns:
///    Returns the value returned from the driver.
///    
@DllImport("WINMM")
uint waveInMessage(HWAVEIN hwi, uint uMsg, size_t dw1, size_t dw2);

///The <b>midiOutGetNumDevs</b> function retrieves the number of MIDI output devices present in the system.
///Returns:
///    Returns the number of MIDI output devices. A return value of zero means that there are no devices (not that there
///    is no error).
///    
@DllImport("WINMM")
uint midiOutGetNumDevs();

///The <b>midiStreamOpen</b> function opens a MIDI stream for output. By default, the device is opened in paused mode.
///The stream handle retrieved by this function must be used in all subsequent references to the stream.
///Params:
///    phms = Pointer to a variable to contain the stream handle when the function returns.
///    puDeviceID = Pointer to a device identifier. The device is opened on behalf of the stream and closed again when the stream is
///                 closed.
///    cMidi = Reserved; must be 1.
///    dwCallback = Pointer to a callback function, an event handle, a thread identifier, or a handle of a window or thread called
///                 during MIDI playback to process messages related to the progress of the playback. If no callback mechanism is
///                 desired, specify <b>NULL</b> for this parameter.
///    dwInstance = Application-specific instance data that is returned to the application with every callback function.
///    fdwOpen = Callback flag for opening the device. One of the following callback flags must be specified. <table> <tr>
///              <th>Value </th> <th>Meaning </th> </tr> <tr> <td>CALLBACK_EVENT</td> <td>The <i>dwCallback</i> parameter is an
///              event handle. This callback mechanism is for output only.</td> </tr> <tr> <td>CALLBACK_FUNCTION</td> <td>The
///              <i>dwCallback</i> parameter is a callback procedure address. For the callback signature, see MidiOutProc.</td>
///              </tr> <tr> <td>CALLBACK_NULL</td> <td>There is no callback mechanism. This is the default setting.</td> </tr>
///              <tr> <td>CALLBACK_THREAD</td> <td>The <i>dwCallback</i> parameter is a thread identifier.</td> </tr> <tr>
///              <td>CALLBACK_WINDOW</td> <td>The <i>dwCallback</i> parameter is a window handle.</td> </tr> </table>
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_BADDEVICEID</b></dt> </dl> </td> <td width="60%"> The specified device identifier is out of
///    range. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%">
///    The given handle or flags parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%"> The system is unable to allocate or lock memory.
///    </td> </tr> </table>
///    
@DllImport("WINMM")
uint midiStreamOpen(HMIDISTRM* phms, uint* puDeviceID, uint cMidi, size_t dwCallback, size_t dwInstance, 
                    uint fdwOpen);

///The <b>midiStreamClose</b> function closes an open MIDI stream.
///Params:
///    hms = Handle to a MIDI stream, as retrieved by using the midiStreamOpen function.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified device handle is invalid. </td>
///    </tr> </table>
///    
@DllImport("WINMM")
uint midiStreamClose(HMIDISTRM hms);

///The <b>midiStreamProperty</b> function sets or retrieves properties of a MIDI data stream associated with a MIDI
///output device.
///Params:
///    hms = Handle to the MIDI device that the property is associated with.
///    lppropdata = Pointer to the property data.
///    dwProperty = Flags that specify the action to perform and identify the appropriate property of the MIDI data stream. The
///                 <b>midiStreamProperty</b> function requires setting two flags in each use. One flag (either MIDIPROP_GET or
///                 MIDIPROP_SET) specifies an action, and the other identifies a specific property to examine or edit. <table> <tr>
///                 <th>Value </th> <th>Meaning </th> </tr> <tr> <td>MIDIPROP_GET</td> <td>Retrieves the current setting of the given
///                 property.</td> </tr> <tr> <td>MIDIPROP_SET</td> <td>Sets the given property.</td> </tr> <tr>
///                 <td>MIDIPROP_TEMPO</td> <td>Retrieves the tempo property. The <i>lppropdata</i> parameter points to a
///                 MIDIPROPTEMPO structure. The current tempo value can be retrieved at any time. Output devices set the tempo by
///                 inserting MEVT_TEMPO events into the MIDI data.</td> </tr> <tr> <td>MIDIPROP_TIMEDIV</td> <td>Specifies the time
///                 division property. You can get or set this property. The <i>lppropdata</i> parameter points to a MIDIPROPTIMEDIV
///                 structure. This property can be set only when the device is stopped.</td> </tr> </table>
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified handle is not a stream handle.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%"> The given
///    handle or flags parameter is invalid. </td> </tr> </table>
///    
@DllImport("WINMM")
uint midiStreamProperty(HMIDISTRM hms, ubyte* lppropdata, uint dwProperty);

///The <b>midiStreamPosition</b> function retrieves the current position in a MIDI stream.
///Params:
///    hms = Handle to a MIDI stream. This handle must have been returned by a call to the midiStreamOpen function. This
///          handle identifies the output device.
///    lpmmt = Pointer to an MMTIME structure.
///    cbmmt = Size, in bytes, of the MMTIME structure.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> Specified device handle is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%"> Specified pointer or
///    structure is invalid. </td> </tr> </table>
///    
@DllImport("WINMM")
uint midiStreamPosition(HMIDISTRM hms, MMTIME* lpmmt, uint cbmmt);

///The <b>midiStreamOut</b> function plays or queues a stream (buffer) of MIDI data to a MIDI output device.
///Params:
///    hms = Handle to a MIDI stream. This handle must have been returned by a call to the midiStreamOpen function. This
///          handle identifies the output device.
///    pmh = Pointer to a MIDIHDR structure that identifies the MIDI buffer.
///    cbmh = Size, in bytes, of the MIDIHDR structure.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%"> The system is unable to allocate or lock memory.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MIDIERR_STILLPLAYING</b></dt> </dl> </td> <td width="60%"> The
///    output buffer pointed to by <i>lpMidiHdr</i> is still playing or is queued from a previous call to midiStreamOut.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MIDIERR_UNPREPARED</b></dt> </dl> </td> <td width="60%"> The header
///    pointed to by <i>lpMidiHdr</i> has not been prepared. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified device handle is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%"> The pointer
///    specified by <i>lpMidiHdr</i> is invalid. </td> </tr> </table>
///    
@DllImport("WINMM")
uint midiStreamOut(HMIDISTRM hms, MIDIHDR* pmh, uint cbmh);

///The <b>midiStreamPause</b> function pauses playback of a specified MIDI stream.
///Params:
///    hms = Handle to a MIDI stream. This handle must have been returned by a call to the MIDIEVENT function. This handle
///          identifies the output device.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified device handle is invalid. </td>
///    </tr> </table>
///    
@DllImport("WINMM")
uint midiStreamPause(HMIDISTRM hms);

///The <b>midiStreamRestart</b> function restarts a paused MIDI stream.
///Params:
///    hms = Handle to a MIDI stream. This handle must have been returned by a call to the midiStreamOpen function. This
///          handle identifies the output device.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified device handle is invalid. </td>
///    </tr> </table>
///    
@DllImport("WINMM")
uint midiStreamRestart(HMIDISTRM hms);

///The <b>midiStreamStop</b> function turns off all notes on all MIDI channels for the specified MIDI output device.
///Params:
///    hms = Handle to a MIDI stream. This handle must have been returned by a call to the midiStreamOpen function. This
///          handle identifies the output device.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified device handle is invalid. </td>
///    </tr> </table>
///    
@DllImport("WINMM")
uint midiStreamStop(HMIDISTRM hms);

///The <b>midiConnect</b> function connects a MIDI input device to a MIDI thru or output device, or connects a MIDI thru
///device to a MIDI output device.
///Params:
///    hmi = Handle to a MIDI input device or a MIDI thru device. (For thru devices, this handle must have been returned by a
///          call to the midiOutOpen function.)
///    hmo = Handle to the MIDI output or thru device.
///    pReserved = Reserved; must be <b>NULL</b>.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MIDIERR_NOTREADY</b></dt> </dl> </td> <td width="60%"> Specified input device is already connected to an
///    output device. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td
///    width="60%"> Specified device handle is invalid. </td> </tr> </table>
///    
@DllImport("WINMM")
uint midiConnect(HMIDI hmi, HMIDIOUT hmo, void* pReserved);

///The <b>midiDisconnect</b> function disconnects a MIDI input device from a MIDI thru or output device, or disconnects
///a MIDI thru device from a MIDI output device.
///Params:
///    hmi = Handle to a MIDI input device or a MIDI thru device.
///    hmo = Handle to the MIDI output device to be disconnected.
///    pReserved = Reserved; must be <b>NULL</b>.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following:.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> Specified device handle is invalid. </td> </tr>
///    </table>
///    
@DllImport("WINMM")
uint midiDisconnect(HMIDI hmi, HMIDIOUT hmo, void* pReserved);

///The <b>midiOutGetDevCaps</b> function queries a specified MIDI output device to determine its capabilities.
///Params:
///    uDeviceID = Identifier of the MIDI output device. The device identifier specified by this parameter varies from zero to one
///                less than the number of devices present. The MIDI_MAPPER constant is also a valid device identifier. This
///                parameter can also be a properly cast device handle.
///    pmoc = Pointer to a MIDIOUTCAPS structure. This structure is filled with information about the capabilities of the
///           device.
///    cbmoc = Size, in bytes, of the MIDIOUTCAPS structure. Only <i>cbMidiOutCaps</i> bytes (or less) of information is copied
///            to the location pointed to by <i>lpMidiOutCaps</i>. If <i>cbMidiOutCaps</i> is zero, nothing is copied, and the
///            function returns MMSYSERR_NOERROR.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_BADDEVICEID</b></dt> </dl> </td> <td width="60%"> The specified device identifier is out of
///    range. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%">
///    The specified pointer or structure is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> The driver is not installed. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%"> The system is unable to load mapper
///    string description. </td> </tr> </table>
///    
@DllImport("WINMM")
uint midiOutGetDevCapsA(size_t uDeviceID, MIDIOUTCAPSA* pmoc, uint cbmoc);

///The <b>midiOutGetDevCaps</b> function queries a specified MIDI output device to determine its capabilities.
///Params:
///    uDeviceID = Identifier of the MIDI output device. The device identifier specified by this parameter varies from zero to one
///                less than the number of devices present. The MIDI_MAPPER constant is also a valid device identifier. This
///                parameter can also be a properly cast device handle.
///    pmoc = Pointer to a MIDIOUTCAPS structure. This structure is filled with information about the capabilities of the
///           device.
///    cbmoc = Size, in bytes, of the MIDIOUTCAPS structure. Only <i>cbMidiOutCaps</i> bytes (or less) of information is copied
///            to the location pointed to by <i>lpMidiOutCaps</i>. If <i>cbMidiOutCaps</i> is zero, nothing is copied, and the
///            function returns MMSYSERR_NOERROR.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_BADDEVICEID</b></dt> </dl> </td> <td width="60%"> The specified device identifier is out of
///    range. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%">
///    The specified pointer or structure is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> The driver is not installed. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%"> The system is unable to load mapper
///    string description. </td> </tr> </table>
///    
@DllImport("WINMM")
uint midiOutGetDevCapsW(size_t uDeviceID, MIDIOUTCAPSW* pmoc, uint cbmoc);

///The <b>midiOutGetVolume</b> function retrieves the current volume setting of a MIDI output device.
///Params:
///    hmo = Handle to an open MIDI output device. This parameter can also contain the handle of a MIDI stream, as long as it
///          is cast to <b>HMIDIOUT</b>. This parameter can also be a device identifier.
///    pdwVolume = Pointer to the location to contain the current volume setting. The low-order word of this location contains the
///                left-channel volume setting, and the high-order word contains the right-channel setting. A value of 0xFFFF
///                represents full volume, and a value of 0x0000 is silence. If a device does not support both left and right volume
///                control, the low-order word of the specified location contains the mono volume level. Any value set by using the
///                midiOutSetVolume function is returned, regardless of whether the device supports that value.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified device handle is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%"> The specified
///    pointer or structure is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl>
///    </td> <td width="60%"> The system is unable to allocate or lock memory. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_NOTSUPPORTED</b></dt> </dl> </td> <td width="60%"> The function is not supported. </td> </tr>
///    </table>
///    
@DllImport("WINMM")
uint midiOutGetVolume(HMIDIOUT hmo, uint* pdwVolume);

///The <b>midiOutSetVolume</b> function sets the volume of a MIDI output device.
///Params:
///    hmo = Handle to an open MIDI output device. This parameter can also contain the handle of a MIDI stream, as long as it
///          is cast to <b>HMIDIOUT</b>. This parameter can also be a device identifier.
///    dwVolume = New volume setting. The low-order word contains the left-channel volume setting, and the high-order word contains
///               the right-channel setting. A value of 0xFFFF represents full volume, and a value of 0x0000 is silence. If a
///               device does not support both left and right volume control, the low-order word of <i>dwVolume</i> specifies the
///               mono volume level, and the high-order word is ignored.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified device handle is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%"> The system is unable
///    to allocate or lock memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOTSUPPORTED</b></dt> </dl>
///    </td> <td width="60%"> The function is not supported. </td> </tr> </table>
///    
@DllImport("WINMM")
uint midiOutSetVolume(HMIDIOUT hmo, uint dwVolume);

///The <b>midiOutGetErrorText</b> function retrieves a textual description for an error identified by the specified
///error code.
///Params:
///    mmrError = Error code.
///    pszText = Pointer to a buffer to be filled with the textual error description.
///    cchText = Length, in characters, of the buffer pointed to by <i>lpText</i>.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_BADERRNUM</b></dt> </dl> </td> <td width="60%"> The specified error number is out of range. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%"> The specified
///    pointer or structure is invalid. </td> </tr> </table>
///    
@DllImport("WINMM")
uint midiOutGetErrorTextA(uint mmrError, PSTR pszText, uint cchText);

///The <b>midiOutGetErrorText</b> function retrieves a textual description for an error identified by the specified
///error code.
///Params:
///    mmrError = Error code.
///    pszText = Pointer to a buffer to be filled with the textual error description.
///    cchText = Length, in characters, of the buffer pointed to by <i>lpText</i>.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_BADERRNUM</b></dt> </dl> </td> <td width="60%"> The specified error number is out of range. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%"> The specified
///    pointer or structure is invalid. </td> </tr> </table>
///    
@DllImport("WINMM")
uint midiOutGetErrorTextW(uint mmrError, PWSTR pszText, uint cchText);

///The <b>midiOutOpen</b> function opens a MIDI output device for playback.
///Params:
///    phmo = Pointer to an <b>HMIDIOUT</b> handle. This location is filled with a handle identifying the opened MIDI output
///           device. The handle is used to identify the device in calls to other MIDI output functions.
///    uDeviceID = Identifier of the MIDI output device that is to be opened.
///    dwCallback = Pointer to a callback function, an event handle, a thread identifier, or a handle of a window or thread called
///                 during MIDI playback to process messages related to the progress of the playback. If no callback is desired,
///                 specify <b>NULL</b> for this parameter. For more information on the callback function, see MidiOutProc.
///    dwInstance = User instance data passed to the callback. This parameter is not used with window callbacks or threads.
///    fdwOpen = Callback flag for opening the device. It can be the following values. <table> <tr> <th>Value </th> <th>Meaning
///              </th> </tr> <tr> <td>CALLBACK_EVENT</td> <td>The <i>dwCallback</i> parameter is an event handle. This callback
///              mechanism is for output only.</td> </tr> <tr> <td>CALLBACK_FUNCTION</td> <td>The <i>dwCallback</i> parameter is a
///              callback function address.</td> </tr> <tr> <td>CALLBACK_NULL</td> <td>There is no callback mechanism. This value
///              is the default setting.</td> </tr> <tr> <td>CALLBACK_THREAD</td> <td>The <i>dwCallback</i> parameter is a thread
///              identifier.</td> </tr> <tr> <td>CALLBACK_WINDOW</td> <td>The <i>dwCallback</i> parameter is a window handle.</td>
///              </tr> </table>
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MIDIERR_NODEVICE</b></dt> </dl> </td> <td width="60%"> No MIDI port was found. This error occurs only when
///    the mapper is opened. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_ALLOCATED</b></dt> </dl> </td> <td
///    width="60%"> The specified resource is already allocated. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_BADDEVICEID</b></dt> </dl> </td> <td width="60%"> The specified device identifier is out of
///    range. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%">
///    The specified pointer or structure is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%"> The system is unable to allocate or lock memory.
///    </td> </tr> </table>
///    
@DllImport("WINMM")
uint midiOutOpen(HMIDIOUT* phmo, uint uDeviceID, size_t dwCallback, size_t dwInstance, uint fdwOpen);

///The <b>midiOutClose</b> function closes the specified MIDI output device.
///Params:
///    hmo = Handle to the MIDI output device. If the function is successful, the handle is no longer valid after the call to
///          this function.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MIDIERR_STILLPLAYING</b></dt> </dl> </td> <td width="60%"> Buffers are still in the queue. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified device
///    handle is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td
///    width="60%"> The system is unable to load mapper string description. </td> </tr> </table>
///    
@DllImport("WINMM")
uint midiOutClose(HMIDIOUT hmo);

///The <b>midiOutPrepareHeader</b> function prepares a MIDI system-exclusive or stream buffer for output.
///Params:
///    hmo = Handle to the MIDI output device. To get the device handle, call midiOutOpen. This parameter can also be the
///          handle of a MIDI stream cast to a <b>HMIDIOUT</b> type.
///    pmh = Pointer to a MIDIHDR structure that identifies the buffer to be prepared. Before calling the function, set the
///          <b>lpData</b>, <b>dwBufferLength</b>, and <b>dwFlags</b> members of the MIDIHDR structure. The <b>dwFlags</b>
///          member must be set to zero.
///    cbmh = Size, in bytes, of the MIDIHDR structure.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified device handle is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%"> The specified
///    address is invalid or the given stream buffer is greater than 64K. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%"> The system is unable to allocate or lock memory.
///    </td> </tr> </table>
///    
@DllImport("WINMM")
uint midiOutPrepareHeader(HMIDIOUT hmo, MIDIHDR* pmh, uint cbmh);

///The <b>midiOutUnprepareHeader</b> function cleans up the preparation performed by the midiOutPrepareHeader function.
///Params:
///    hmo = Handle to the MIDI output device. This parameter can also be the handle of a MIDI stream cast to <b>HMIDIOUT</b>.
///    pmh = Pointer to a MIDIHDR structure identifying the buffer to be cleaned up.
///    cbmh = Size, in bytes, of the MIDIHDR structure.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MIDIERR_STILLPLAYING</b></dt> </dl> </td> <td width="60%"> The buffer pointed to by <i>lpMidiOutHdr</i> is
///    still in the queue. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td
///    width="60%"> The specified device handle is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%"> The specified pointer or structure is invalid.
///    </td> </tr> </table>
///    
@DllImport("WINMM")
uint midiOutUnprepareHeader(HMIDIOUT hmo, MIDIHDR* pmh, uint cbmh);

///The <b>midiOutShortMsg</b> function sends a short MIDI message to the specified MIDI output device.
///Params:
///    hmo = Handle to the MIDI output device. This parameter can also be the handle of a MIDI stream cast to <b>HMIDIOUT</b>.
///    dwMsg = MIDI message. The message is packed into a <b>DWORD</b> value with the first byte of the message in the low-order
///            byte. The message is packed into this parameter as follows. <table> <tr> <th>Word </th> <th>Byte </th> <th>Usage
///            </th> </tr> <tr> <td>High</td> <td>High-order</td> <td>Not used.</td> </tr> <tr> <td></td> <td>Low-order</td>
///            <td>The second byte of MIDI data (when needed).</td> </tr> <tr> <td>Low</td> <td>High-order</td> <td>The first
///            byte of MIDI data (when needed).</td> </tr> <tr> <td></td> <td>Low-order</td> <td>The MIDI status.</td> </tr>
///            </table> The two MIDI data bytes are optional, depending on the MIDI status byte. When a series of messages have
///            the same status byte, the status byte can be omitted from messages after the first one in the series, creating a
///            running status. Pack a message for running status as follows: <table> <tr> <th>Word </th> <th>Byte </th>
///            <th>Usage </th> </tr> <tr> <td>High</td> <td>High-order</td> <td>Not used.</td> </tr> <tr> <td></td>
///            <td>Low-order</td> <td>Not used.</td> </tr> <tr> <td>Low</td> <td>High-order</td> <td>The second byte of MIDI
///            data (when needed).</td> </tr> <tr> <td></td> <td>Low-order</td> <td>The first byte of MIDI data.</td> </tr>
///            </table>
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MIDIERR_BADOPENMODE</b></dt> </dl> </td> <td width="60%"> The application sent a message without a status
///    byte to a stream handle. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MIDIERR_NOTREADY</b></dt> </dl> </td> <td
///    width="60%"> The hardware is busy with other data. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified device handle is invalid. </td>
///    </tr> </table>
///    
@DllImport("WINMM")
uint midiOutShortMsg(HMIDIOUT hmo, uint dwMsg);

///The <b>midiOutLongMsg</b> function sends a system-exclusive MIDI message to the specified MIDI output device.
///Params:
///    hmo = Handle to the MIDI output device. This parameter can also be the handle of a MIDI stream cast to <b>HMIDIOUT</b>.
///    pmh = Pointer to a MIDIHDR structure that identifies the MIDI buffer.
///    cbmh = Size, in bytes, of the MIDIHDR structure.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MIDIERR_NOTREADY</b></dt> </dl> </td> <td width="60%"> The hardware is busy with other data. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MIDIERR_UNPREPARED</b></dt> </dl> </td> <td width="60%"> The buffer pointed to
///    by <i>lpMidiOutHdr</i> has not been prepared. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified device handle is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%"> The specified
///    pointer or structure is invalid. </td> </tr> </table>
///    
@DllImport("WINMM")
uint midiOutLongMsg(HMIDIOUT hmo, MIDIHDR* pmh, uint cbmh);

///The <b>midiOutReset</b> function turns off all notes on all MIDI channels for the specified MIDI output device.
///Params:
///    hmo = Handle to the MIDI output device. This parameter can also be the handle of a MIDI stream cast to <b>HMIDIOUT</b>.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified device handle is invalid. </td>
///    </tr> </table>
///    
@DllImport("WINMM")
uint midiOutReset(HMIDIOUT hmo);

///The <b>midiOutCachePatches</b> function requests that an internal MIDI synthesizer device preload and cache a
///specified set of patches.
///Params:
///    hmo = Handle to the opened MIDI output device. This device must be an internal MIDI synthesizer. This parameter can
///          also be the handle of a MIDI stream, cast to <b>HMIDIOUT</b>.
///    uBank = Bank of patches that should be used. This parameter should be set to zero to cache the default patch bank.
///    pwpa = Pointer to a PATCHARRAY array indicating the patches to be cached or uncached.
///    fuCache = Options for the cache operation. It can be one of the following flags. <table> <tr> <th>Value </th> <th>Meaning
///              </th> </tr> <tr> <td>MIDI_CACHE_ALL</td> <td>Caches all of the specified patches. If they cannot all be cached,
///              it caches none, clears the PATCHARRAY array, and returns MMSYSERR_NOMEM.</td> </tr> <tr>
///              <td>MIDI_CACHE_BESTFIT</td> <td>Caches all of the specified patches. If they cannot all be cached, it caches as
///              many patches as possible, changes the PATCHARRAY array to reflect which patches were cached, and returns
///              MMSYSERR_NOMEM.</td> </tr> <tr> <td>MIDI_CACHE_QUERY</td> <td>Changes the PATCHARRAY array to indicate which
///              patches are currently cached.</td> </tr> <tr> <td>MIDI_UNCACHE</td> <td>Uncaches the specified patches and clears
///              the PATCHARRAY array.</td> </tr> </table>
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALFLAG</b></dt> </dl> </td> <td width="60%"> The flag specified by <i>wFlags</i> is invalid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The
///    specified device handle is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt>
///    </dl> </td> <td width="60%"> The array pointed to by <i>lpPatchArray</i> is invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%"> The device does not have enough
///    memory to cache all of the requested patches. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_NOTSUPPORTED</b></dt> </dl> </td> <td width="60%"> The specified device does not support patch
///    caching. </td> </tr> </table>
///    
@DllImport("WINMM")
uint midiOutCachePatches(HMIDIOUT hmo, uint uBank, ushort* pwpa, uint fuCache);

///The <b>midiOutCacheDrumPatches</b> function requests that an internal MIDI synthesizer device preload and cache a
///specified set of key-based percussion patches.
///Params:
///    hmo = Handle to the opened MIDI output device. This device should be an internal MIDI synthesizer. This parameter can
///          also be the handle of a MIDI stream, cast to <b>HMIDIOUT</b>.
///    uPatch = Drum patch number that should be used. This parameter should be set to zero to cache the default drum patch.
///    pwkya = Pointer to a KEYARRAY array indicating the key numbers of the specified percussion patches to be cached or
///            uncached.
///    fuCache = Options for the cache operation. It can be one of the following flags. <table> <tr> <th>Value </th> <th>Meaning
///              </th> </tr> <tr> <td>MIDI_CACHE_ALL</td> <td>Caches all of the specified patches. If they cannot all be cached,
///              it caches none, clears the KEYARRAY array, and returns MMSYSERR_NOMEM.</td> </tr> <tr>
///              <td>MIDI_CACHE_BESTFIT</td> <td>Caches all of the specified patches. If they cannot all be cached, it caches as
///              many patches as possible, changes the KEYARRAY array to reflect which patches were cached, and returns
///              MMSYSERR_NOMEM.</td> </tr> <tr> <td>MIDI_CACHE_QUERY</td> <td>Changes the KEYARRAY array to indicate which
///              patches are currently cached.</td> </tr> <tr> <td>MIDI_UNCACHE</td> <td>Uncaches the specified patches and clears
///              the KEYARRAY array.</td> </tr> </table>
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALFLAG</b></dt> </dl> </td> <td width="60%"> The flag specified by <i>wFlags</i> is invalid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The
///    specified device handle is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt>
///    </dl> </td> <td width="60%"> The array pointed to by the <i>lpKeyArray</i> array is invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%"> The device does not have enough
///    memory to cache all of the requested patches. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_NOTSUPPORTED</b></dt> </dl> </td> <td width="60%"> The specified device does not support patch
///    caching. </td> </tr> </table>
///    
@DllImport("WINMM")
uint midiOutCacheDrumPatches(HMIDIOUT hmo, uint uPatch, ushort* pwkya, uint fuCache);

///The <b>midiOutGetID</b> function retrieves the device identifier for the given MIDI output device. This function is
///supported for backward compatibility. New applications can cast a handle of the device rather than retrieving the
///device identifier.
///Params:
///    hmo = Handle to the MIDI output device.
///    puDeviceID = Pointer to a variable to be filled with the device identifier.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The <i>hmo</i> parameter specifies an invalid
///    handle. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> No
///    device driver is present. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td
///    width="60%"> Unable to allocate or lock memory. </td> </tr> </table>
///    
@DllImport("WINMM")
uint midiOutGetID(HMIDIOUT hmo, uint* puDeviceID);

///The <b>midiOutMessage</b> function sends a message to the MIDI device drivers. This function is used only for
///driver-specific messages that are not supported by the MIDI API.
///Params:
///    hmo = Identifier of the MIDI device that receives the message. You must cast the device ID to the <b>HMIDIOUT</b>
///          handle type. If you supply a handle instead of a device ID, the function fails and returns the MMSYSERR_NOSUPPORT
///          error code.
///    uMsg = Message to send.
///    dw1 = Message parameter.
///    dw2 = Message parameter.
///Returns:
///    Returns the value returned by the audio device driver.
///    
@DllImport("WINMM")
uint midiOutMessage(HMIDIOUT hmo, uint uMsg, size_t dw1, size_t dw2);

///The <b>midiInGetNumDevs</b> function retrieves the number of MIDI input devices in the system.
///Returns:
///    Returns the number of MIDI input devices present in the system. A return value of zero means that there are no
///    devices (not that there is no error).
///    
@DllImport("WINMM")
uint midiInGetNumDevs();

///The <b>midiInGetDevCaps</b> function determines the capabilities of a specified MIDI input device.
///Params:
///    uDeviceID = Identifier of the MIDI input device. The device identifier varies from zero to one less than the number of
///                devices present. This parameter can also be a properly cast device handle.
///    pmic = Pointer to a MIDIINCAPS structure that is filled with information about the capabilities of the device.
///    cbmic = Size, in bytes, of the MIDIINCAPS structure. Only <i>cbMidiInCaps</i> bytes (or less) of information is copied to
///            the location pointed to by <i>lpMidiInCaps</i>. If <i>cbMidiInCaps</i> is zero, nothing is copied, and the
///            function returns MMSYSERR_NOERROR.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_BADDEVICEID</b></dt> </dl> </td> <td width="60%"> The specified device identifier is out of
///    range. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%">
///    The specified pointer or structure is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> The driver is not installed. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%"> The system is unable to allocate or
///    lock memory. </td> </tr> </table>
///    
@DllImport("WINMM")
uint midiInGetDevCapsA(size_t uDeviceID, MIDIINCAPSA* pmic, uint cbmic);

///The <b>midiInGetDevCaps</b> function determines the capabilities of a specified MIDI input device.
///Params:
///    uDeviceID = Identifier of the MIDI input device. The device identifier varies from zero to one less than the number of
///                devices present. This parameter can also be a properly cast device handle.
///    pmic = Pointer to a MIDIINCAPS structure that is filled with information about the capabilities of the device.
///    cbmic = Size, in bytes, of the MIDIINCAPS structure. Only <i>cbMidiInCaps</i> bytes (or less) of information is copied to
///            the location pointed to by <i>lpMidiInCaps</i>. If <i>cbMidiInCaps</i> is zero, nothing is copied, and the
///            function returns MMSYSERR_NOERROR.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_BADDEVICEID</b></dt> </dl> </td> <td width="60%"> The specified device identifier is out of
///    range. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%">
///    The specified pointer or structure is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> The driver is not installed. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%"> The system is unable to allocate or
///    lock memory. </td> </tr> </table>
///    
@DllImport("WINMM")
uint midiInGetDevCapsW(size_t uDeviceID, MIDIINCAPSW* pmic, uint cbmic);

///The <b>midiInGetErrorText</b> function retrieves a textual description for an error identified by the specified error
///code.
///Params:
///    mmrError = Error code.
///    pszText = Pointer to the buffer to be filled with the textual error description.
///    cchText = Length, in characters, of the buffer pointed to by <i>lpText</i>.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_BADERRNUM</b></dt> </dl> </td> <td width="60%"> The specified error number is out of range. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%"> The specified
///    pointer or structure is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl>
///    </td> <td width="60%"> The system is unable to allocate or lock memory. </td> </tr> </table>
///    
@DllImport("WINMM")
uint midiInGetErrorTextA(uint mmrError, PSTR pszText, uint cchText);

///The <b>midiInGetErrorText</b> function retrieves a textual description for an error identified by the specified error
///code.
///Params:
///    mmrError = Error code.
///    pszText = Pointer to the buffer to be filled with the textual error description.
///    cchText = Length, in characters, of the buffer pointed to by <i>lpText</i>.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_BADERRNUM</b></dt> </dl> </td> <td width="60%"> The specified error number is out of range. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%"> The specified
///    pointer or structure is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl>
///    </td> <td width="60%"> The system is unable to allocate or lock memory. </td> </tr> </table>
///    
@DllImport("WINMM")
uint midiInGetErrorTextW(uint mmrError, PWSTR pszText, uint cchText);

///The <b>midiInOpen</b> function opens a specified MIDI input device.
///Params:
///    phmi = Pointer to an <b>HMIDIIN</b> handle. This location is filled with a handle identifying the opened MIDI input
///           device. The handle is used to identify the device in calls to other MIDI input functions.
///    uDeviceID = Identifier of the MIDI input device to be opened.
///    dwCallback = Pointer to a callback function, a thread identifier, or a handle of a window called with information about
///                 incoming MIDI messages. For more information on the callback function, see MidiInProc.
///    dwInstance = User instance data passed to the callback function. This parameter is not used with window callback functions or
///                 threads.
///    fdwOpen = Callback flag for opening the device and, optionally, a status flag that helps regulate rapid data transfers. It
///              can be the following values. <table> <tr> <th>Value </th> <th>Meaning </th> </tr> <tr> <td>CALLBACK_FUNCTION</td>
///              <td>The <i>dwCallback</i> parameter is a callback procedure address.</td> </tr> <tr> <td>CALLBACK_NULL</td>
///              <td>There is no callback mechanism. This value is the default setting.</td> </tr> <tr> <td>CALLBACK_THREAD</td>
///              <td>The <i>dwCallback</i> parameter is a thread identifier.</td> </tr> <tr> <td>CALLBACK_WINDOW</td> <td>The
///              <i>dwCallback</i> parameter is a window handle.</td> </tr> <tr> <td>MIDI_IO_STATUS</td> <td>When this parameter
///              also specifies CALLBACK_FUNCTION, MIM_MOREDATA messages are sent to the callback function as well as MIM_DATA
///              messages. Or, if this parameter also specifies CALLBACK_WINDOW, MM_MIM_MOREDATA messages are sent to the window
///              as well as MM_MIM_DATA messages. This flag does not affect event or thread callbacks.</td> </tr> </table> Most
///              applications that use a callback mechanism will specify CALLBACK_FUNCTION for this parameter.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following/
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_ALLOCATED</b></dt> </dl> </td> <td width="60%"> The specified resource is already allocated.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_BADDEVICEID</b></dt> </dl> </td> <td width="60%"> The
///    specified device identifier is out of range. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALFLAG</b></dt> </dl> </td> <td width="60%"> The flags specified by <i>dwFlags</i> are
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%">
///    The specified pointer or structure is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%"> The system is unable to allocate or lock memory.
///    </td> </tr> </table>
///    
@DllImport("WINMM")
uint midiInOpen(HMIDIIN* phmi, uint uDeviceID, size_t dwCallback, size_t dwInstance, uint fdwOpen);

///The <b>midiInClose</b> function closes the specified MIDI input device.
///Params:
///    hmi = Handle to the MIDI input device. If the function is successful, the handle is no longer valid after the call to
///          this function.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MIDIERR_STILLPLAYING</b></dt> </dl> </td> <td width="60%"> Buffers are still in the queue. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified device
///    handle is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td
///    width="60%"> The system is unable to allocate or lock memory. </td> </tr> </table>
///    
@DllImport("WINMM")
uint midiInClose(HMIDIIN hmi);

///The <b>midiInPrepareHeader</b> function prepares a buffer for MIDI input.
///Params:
///    hmi = Handle to the MIDI input device. To get the device handle, call midiInOpen.
///    pmh = Pointer to a MIDIHDR structure that identifies the buffer to be prepared. Before calling the function, set the
///          <b>lpData</b>, <b>dwBufferLength</b>, and <b>dwFlags</b> members of the MIDIHDR structure. The <b>dwFlags</b>
///          member must be set to zero.
///    cbmh = Size, in bytes, of the MIDIHDR structure.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified device handle is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%"> The specified
///    address is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td
///    width="60%"> The system is unable to allocate or lock memory. </td> </tr> </table>
///    
@DllImport("WINMM")
uint midiInPrepareHeader(HMIDIIN hmi, MIDIHDR* pmh, uint cbmh);

///The <b>midiInUnprepareHeader</b> function cleans up the preparation performed by the midiInPrepareHeader function.
///Params:
///    hmi = Handle to the MIDI input device.
///    pmh = Pointer to a MIDIHDR structure identifying the buffer to be cleaned up.
///    cbmh = Size of the MIDIHDR structure.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MIDIERR_STILLPLAYING</b></dt> </dl> </td> <td width="60%"> The buffer pointed to by <i>lpMidiInHdr</i> is
///    still in the queue. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td
///    width="60%"> The specified pointer or structure is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified device handle is invalid. </td>
///    </tr> </table>
///    
@DllImport("WINMM")
uint midiInUnprepareHeader(HMIDIIN hmi, MIDIHDR* pmh, uint cbmh);

///The <b>midiInAddBuffer</b> function sends an input buffer to a specified opened MIDI input device. This function is
///used for system-exclusive messages.
///Params:
///    hmi = Handle to the MIDI input device.
///    pmh = Pointer to a MIDIHDR structure that identifies the buffer.
///    cbmh = Size, in bytes, of the MIDIHDR structure.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MIDIERR_STILLPLAYING</b></dt> </dl> </td> <td width="60%"> The buffer pointed to by <i>lpMidiInHdr</i> is
///    still in the queue. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MIDIERR_UNPREPARED</b></dt> </dl> </td> <td
///    width="60%"> The buffer pointed to by <i>lpMidiInHdr</i> has not been prepared. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified device handle is invalid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%"> The
///    specified pointer or structure is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt>
///    </dl> </td> <td width="60%"> The system is unable to allocate or lock memory. </td> </tr> </table>
///    
@DllImport("WINMM")
uint midiInAddBuffer(HMIDIIN hmi, MIDIHDR* pmh, uint cbmh);

///The <b>midiInStart</b> function starts MIDI input on the specified MIDI input device.
///Params:
///    hmi = Handle to the MIDI input device.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following <table>
///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified device handle is invalid. </td>
///    </tr> </table>
///    
@DllImport("WINMM")
uint midiInStart(HMIDIIN hmi);

///The <b>midiInStop</b> function stops MIDI input on the specified MIDI input device.
///Params:
///    hmi = Handle to the MIDI input device.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified device handle is invalid. </td>
///    </tr> </table>
///    
@DllImport("WINMM")
uint midiInStop(HMIDIIN hmi);

///The <b>midiInReset</b> function stops input on a given MIDI input device.
///Params:
///    hmi = Handle to the MIDI input device.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified device handle is invalid. </td>
///    </tr> </table>
///    
@DllImport("WINMM")
uint midiInReset(HMIDIIN hmi);

///The <b>midiInGetID</b> function gets the device identifier for the given MIDI input device. This function is
///supported for backward compatibility. New applications can cast a handle of the device rather than retrieving the
///device identifier.
///Params:
///    hmi = Handle to the MIDI input device.
///    puDeviceID = Pointer to a variable to be filled with the device identifier.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The <i>hwi</i> parameter specifies an invalid
///    handle. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> No
///    device driver is present. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td
///    width="60%"> Unable to allocate or lock memory. </td> </tr> </table>
///    
@DllImport("WINMM")
uint midiInGetID(HMIDIIN hmi, uint* puDeviceID);

///The <b>midiInMessage</b> function sends a message to the MIDI device driver.
///Params:
///    hmi = Identifier of the MIDI device that receives the message. You must cast the device ID to the <b>HMIDIIN</b> handle
///          type. If you supply a handle instead of a device ID, the function fails and returns the MMSYSERR_NOSUPPORT error
///          code.
///    uMsg = Message to send.
///    dw1 = Message parameter.
///    dw2 = Message parameter.
///Returns:
///    Returns the value returned by the audio device driver.
///    
@DllImport("WINMM")
uint midiInMessage(HMIDIIN hmi, uint uMsg, size_t dw1, size_t dw2);

///The <b>auxGetNumDevs</b> function retrieves the number of auxiliary output devices present in the system.
///Returns:
///    Returns the number of device. A return value of zero means that no devices are present or that an error occurred.
///    
@DllImport("WINMM")
uint auxGetNumDevs();

///The <b>auxGetDevCaps</b> function retrieves the capabilities of a given auxiliary output device.
///Params:
///    uDeviceID = Identifier of the auxiliary output device to be queried. Specify a valid device identifier (see the following
///                comments section), or use the following constant: <table> <tr> <th>Value </th> <th>Meaning </th> </tr> <tr>
///                <td>AUX_MAPPER</td> <td>Auxiliary audio mapper. The function returns an error if no auxiliary audio mapper is
///                installed.</td> </tr> </table>
///    pac = Pointer to an AUXCAPS structure to be filled with information about the capabilities of the device.
///    cbac = Size, in bytes, of the AUXCAPS structure.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_BADDEVICEID</b></dt> </dl> </td> <td width="60%"> Specified device identifier is out of range.
///    </td> </tr> </table>
///    
@DllImport("WINMM")
uint auxGetDevCapsA(size_t uDeviceID, AUXCAPSA* pac, uint cbac);

///The <b>auxGetDevCaps</b> function retrieves the capabilities of a given auxiliary output device.
///Params:
///    uDeviceID = Identifier of the auxiliary output device to be queried. Specify a valid device identifier (see the following
///                comments section), or use the following constant: <table> <tr> <th>Value </th> <th>Meaning </th> </tr> <tr>
///                <td>AUX_MAPPER</td> <td>Auxiliary audio mapper. The function returns an error if no auxiliary audio mapper is
///                installed.</td> </tr> </table>
///    pac = Pointer to an AUXCAPS structure to be filled with information about the capabilities of the device.
///    cbac = Size, in bytes, of the AUXCAPS structure.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_BADDEVICEID</b></dt> </dl> </td> <td width="60%"> Specified device identifier is out of range.
///    </td> </tr> </table>
///    
@DllImport("WINMM")
uint auxGetDevCapsW(size_t uDeviceID, AUXCAPSW* pac, uint cbac);

///The <b>auxSetVolume</b> function sets the volume of the specified auxiliary output device.
///Params:
///    uDeviceID = Identifier of the auxiliary output device to be queried. Device identifiers are determined implicitly from the
///                number of devices present in the system. Device identifier values range from zero to one less than the number of
///                devices present. Use the auxGetNumDevs function to determine the number of auxiliary devices in the system.
///    dwVolume = Specifies the new volume setting. The low-order word specifies the left-channel volume setting, and the
///               high-order word specifies the right-channel setting. A value of 0xFFFF represents full volume, and a value of
///               0x0000 is silence. If a device does not support both left and right volume control, the low-order word of
///               <i>dwVolume</i> specifies the volume level, and the high-order word is ignored.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_BADDEVICEID</b></dt> </dl> </td> <td width="60%"> Specified device identifier is out of range.
///    </td> </tr> </table>
///    
@DllImport("WINMM")
uint auxSetVolume(uint uDeviceID, uint dwVolume);

///The <b>auxGetVolume</b> function retrieves the current volume setting of the specified auxiliary output device.
///Params:
///    uDeviceID = Identifier of the auxiliary output device to be queried.
///    pdwVolume = Pointer to a variable to be filled with the current volume setting. The low-order word of this location contains
///                the left channel volume setting, and the high-order word contains the right channel setting. A value of 0xFFFF
///                represents full volume, and a value of 0x0000 is silence. If a device does not support both left and right volume
///                control, the low-order word of the specified location contains the volume level. The full 16-bit setting(s) set
///                with the auxSetVolume function are returned, regardless of whether the device supports the full 16 bits of
///                volume-level control.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_BADDEVICEID</b></dt> </dl> </td> <td width="60%"> Specified device identifier is out of range.
///    </td> </tr> </table>
///    
@DllImport("WINMM")
uint auxGetVolume(uint uDeviceID, uint* pdwVolume);

///The <b>auxOutMessage</b> function sends a message to the given auxiliary output device. This function also performs
///error checking on the device identifier passed as part of the message.
///Params:
///    uDeviceID = Identifier of the auxiliary output device to receive the message.
///    uMsg = Message to send.
///    dw1 = Message parameter.
///    dw2 = Message parameter.
///Returns:
///    Returns the message return value.
///    
@DllImport("WINMM")
uint auxOutMessage(uint uDeviceID, uint uMsg, size_t dw1, size_t dw2);

///The <b>mixerGetNumDevs</b> function retrieves the number of mixer devices present in the system.
///Returns:
///    Returns the number of mixer devices or zero if no mixer devices are available.
///    
@DllImport("WINMM")
uint mixerGetNumDevs();

///The <b>mixerGetDevCaps</b> function queries a specified mixer device to determine its capabilities.
///Params:
///    uMxId = Identifier or handle of an open mixer device.
///    pmxcaps = Pointer to a MIXERCAPS structure that receives information about the capabilities of the device.
///    cbmxcaps = Size, in bytes, of the MIXERCAPS structure.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_BADDEVICEID</b></dt> </dl> </td> <td width="60%"> The specified device identifier is out of
///    range. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%">
///    The mixer device handle is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt>
///    </dl> </td> <td width="60%"> One or more parameters are invalid. </td> </tr> </table>
///    
@DllImport("WINMM")
uint mixerGetDevCapsA(size_t uMxId, MIXERCAPSA* pmxcaps, uint cbmxcaps);

///The <b>mixerGetDevCaps</b> function queries a specified mixer device to determine its capabilities.
///Params:
///    uMxId = Identifier or handle of an open mixer device.
///    pmxcaps = Pointer to a MIXERCAPS structure that receives information about the capabilities of the device.
///    cbmxcaps = Size, in bytes, of the MIXERCAPS structure.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_BADDEVICEID</b></dt> </dl> </td> <td width="60%"> The specified device identifier is out of
///    range. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%">
///    The mixer device handle is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt>
///    </dl> </td> <td width="60%"> One or more parameters are invalid. </td> </tr> </table>
///    
@DllImport("WINMM")
uint mixerGetDevCapsW(size_t uMxId, MIXERCAPSW* pmxcaps, uint cbmxcaps);

///The <b>mixerOpen</b> function opens a specified mixer device and ensures that the device will not be removed until
///the application closes the handle.
///Params:
///    phmx = Pointer to a variable that will receive a handle identifying the opened mixer device. Use this handle to identify
///           the device when calling other audio mixer functions. This parameter cannot be <b>NULL</b>.
///    uMxId = Identifier of the mixer device to open. Use a valid device identifier or any <b>HMIXEROBJ</b> (see the mixerGetID
///            function for a description of mixer object handles). A "mapper" for audio mixer devices does not currently exist,
///            so a mixer device identifier of -1 is not valid.
///    dwCallback = Handle to a window called when the state of an audio line and/or control associated with the device being opened
///                 is changed. Specify <b>NULL</b> for this parameter if no callback mechanism is to be used.
///    dwInstance = Reserved. Must be zero.
///    fdwOpen = Flags for opening the device. The following values are defined. <table> <tr> <th>Value </th> <th>Meaning </th>
///              </tr> <tr> <td><b>CALLBACK_WINDOW</b></td> <td>The <i>dwCallback</i> parameter is assumed to be a window handle
///              (<b>HWND</b>).</td> </tr> <tr> <td><b>MIXER_OBJECTF_AUX</b></td> <td>The <i>uMxId</i> parameter is an auxiliary
///              device identifier in the range of zero to one less than the number of devices returned by the auxGetNumDevs
///              function.</td> </tr> <tr> <td><b>MIXER_OBJECTF_HMIDIIN</b></td> <td>The <i>uMxId</i> parameter is the handle of a
///              MIDI input device. This handle must have been returned by the midiInOpen function.</td> </tr> <tr>
///              <td><b>MIXER_OBJECTF_HMIDIOUT</b></td> <td>The <i>uMxId</i> parameter is the handle of a MIDI output device. This
///              handle must have been returned by the midiOutOpen function.</td> </tr> <tr> <td><b>MIXER_OBJECTF_HMIXER</b></td>
///              <td>The <i>uMxId</i> parameter is a mixer device handle returned by the <b>mixerOpen</b> function. This flag is
///              optional.</td> </tr> <tr> <td><b>MIXER_OBJECTF_HWAVEIN</b></td> <td>The <i>uMxId</i> parameter is a
///              waveform-audio input handle returned by the waveInOpen function.</td> </tr> <tr>
///              <td><b>MIXER_OBJECTF_HWAVEOUT</b></td> <td>The <i>uMxId</i> parameter is a waveform-audio output handle returned
///              by the waveOutOpen function.</td> </tr> <tr> <td><b>MIXER_OBJECTF_MIDIIN</b></td> <td>The <i>uMxId</i> parameter
///              is the identifier of a MIDI input device. This identifier must be in the range of zero to one less than the
///              number of devices returned by the midiInGetNumDevs function.</td> </tr> <tr>
///              <td><b>MIXER_OBJECTF_MIDIOUT</b></td> <td>The <i>uMxId</i> parameter is the identifier of a MIDI output device.
///              This identifier must be in the range of zero to one less than the number of devices returned by the
///              midiOutGetNumDevs function.</td> </tr> <tr> <td><b>MIXER_OBJECTF_MIXER</b></td> <td>The <i>uMxId</i> parameter is
///              a mixer device identifier in the range of zero to one less than the number of devices returned by the
///              mixerGetNumDevs function. This flag is optional.</td> </tr> <tr> <td><b>MIXER_OBJECTF_WAVEIN</b></td> <td>The
///              <i>uMxId</i> parameter is the identifier of a waveform-audio input device in the range of zero to one less than
///              the number of devices returned by the waveInGetNumDevs function.</td> </tr> <tr>
///              <td><b>MIXER_OBJECTF_WAVEOUT</b></td> <td>The <i>uMxId</i> parameter is the identifier of a waveform-audio output
///              device in the range of zero to one less than the number of devices returned by the waveOutGetNumDevs
///              function.</td> </tr> </table>
///Returns:
///    Returns <b>MMSYSERR_NOERROR</b> if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_ALLOCATED</b></dt> </dl> </td> <td width="60%"> The specified resource is already allocated by
///    the maximum number of clients possible. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_BADDEVICEID</b></dt> </dl> </td> <td width="60%"> The <i>uMxId</i> parameter specifies an invalid
///    device identifier. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALFLAG</b></dt> </dl> </td> <td
///    width="60%"> One or more flags are invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The <i>uMxId</i> parameter specifies an invalid
///    handle. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%">
///    One or more parameters are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt>
///    </dl> </td> <td width="60%"> No mixer device is available for the object specified by <i>uMxId</i>. Note that the
///    location referenced by <i>uMxId</i> will also contain the value –1. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%"> Unable to allocate resources. </td> </tr> </table>
///    
@DllImport("WINMM")
uint mixerOpen(ptrdiff_t* phmx, uint uMxId, size_t dwCallback, size_t dwInstance, uint fdwOpen);

///The <b>mixerClose</b> function closes the specified mixer device.
///Params:
///    hmx = Handle to the mixer device. This handle must have been returned successfully by the mixerOpen function. If
///          <b>mixerClose</b> is successful, <i>hmx</i> is no longer valid.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> Specified device handle is invalid. </td> </tr>
///    </table>
///    
@DllImport("WINMM")
uint mixerClose(HMIXER hmx);

///The <b>mixerMessage</b> function sends a custom mixer driver message directly to a mixer driver.
///Params:
///    hmx = Identifier of the mixer that receives the message. You must cast the device ID to the <b>HMIXER</b> handle type.
///          If you supply a handle instead of a device ID, the function fails and returns the MMSYSERR_NOSUPPORT error code.
///    uMsg = Custom mixer driver message to send to the mixer driver. This message must be above or equal to the MXDM_USER
///           constant.
///    dwParam1 = Parameter associated with the message being sent.
///    dwParam2 = Parameter associated with the message being sent.
///Returns:
///    Returns a value that is specific to the custom mixer driver message. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified device handle is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%"> The <i>uMsg</i>
///    parameter specified in the MXDM_USER message is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_NOSUPPORT</b></dt> </dl> </td> <td width="60%"> The <i>deviceID</i> parameter must be a valid
///    device ID. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOTSUPPORTED</b></dt> </dl> </td> <td
///    width="60%"> The mixer device did not process the message. </td> </tr> </table>
///    
@DllImport("WINMM")
uint mixerMessage(HMIXER hmx, uint uMsg, size_t dwParam1, size_t dwParam2);

///The <b>mixerGetLineInfo</b> function retrieves information about a specific line of a mixer device.
///Params:
///    hmxobj = Handle to the mixer device object that controls the specific audio line.
///    pmxl = Pointer to a MIXERLINE structure. This structure is filled with information about the audio line for the mixer
///           device. The <b>cbStruct</b> member must always be initialized to be the size, in bytes, of the <b>MIXERLINE</b>
///           structure.
///    fdwInfo = Flags for retrieving information about an audio line. The following values are defined. <table> <tr> <th>Value
///              </th> <th>Meaning </th> </tr> <tr> <td>MIXER_GETLINEINFOF_COMPONENTTYPE</td> <td>The <i>pmxl</i> parameter will
///              receive information about the first audio line of the type specified in the <b>dwComponentType</b> member of the
///              MIXERLINE structure. This flag is used to retrieve information about an audio line of a specific component type.
///              Remaining structure members except <b>cbStruct</b> require no further initialization.</td> </tr> <tr>
///              <td>MIXER_GETLINEINFOF_DESTINATION</td> <td>The <i>pmxl</i> parameter will receive information about the
///              destination audio line specified by the <b>dwDestination</b> member of the MIXERLINE structure. This index ranges
///              from zero to one less than the value in the <b>cDestinations</b> member of the MIXERCAPS structure. All remaining
///              structure members except <b>cbStruct</b> require no further initialization.</td> </tr> <tr>
///              <td>MIXER_GETLINEINFOF_LINEID</td> <td>The <i>pmxl</i> parameter will receive information about the audio line
///              specified by the <b>dwLineID</b> member of the MIXERLINE structure. This is usually used to retrieve updated
///              information about the state of an audio line. All remaining structure members except <b>cbStruct</b> require no
///              further initialization.</td> </tr> <tr> <td>MIXER_GETLINEINFOF_SOURCE</td> <td>The <i>pmxl</i> parameter will
///              receive information about the source audio line specified by the <b>dwDestination</b> and <b>dwSource</b> members
///              of the MIXERLINE structure. The index specified by <b>dwDestination</b> ranges from zero to one less than the
///              value in the <b>cDestinations</b> member of the MIXERCAPS structure. The index specified by <b>dwSource</b>
///              ranges from zero to one less than the value in the <b>cConnections</b> member of the <b>MIXERLINE</b> structure
///              returned for the audio line stored in the <b>dwDestination</b> member. All remaining structure members except
///              <b>cbStruct</b> require no further initialization.</td> </tr> <tr> <td>MIXER_GETLINEINFOF_TARGETTYPE</td> <td>The
///              <i>pmxl</i> parameter will receive information about the audio line that is for the <b>dwType</b> member of the
///              <b>Target</b> structure, which is a member of the MIXERLINE structure. This flag is used to retrieve information
///              about an audio line that handles the target type (for example, <b>MIXERLINE_TARGETTYPE_WAVEOUT</b>). The
///              application must initialize the <b>dwType</b>, <b>wMid</b>, <b>wPid</b>, <b>vDriverVersion</b> and <b>szPname</b>
///              members of the MIXERLINE structure before calling <b>mixerGetLineInfo</b>. All of these values can be retrieved
///              from the device capabilities structures for all media devices. Remaining structure members except <b>cbStruct</b>
///              require no further initialization. <div class="alert"><b>Note</b> In the ANSI version of this function
///              (<b>mixerGetLineInfoA</b>), you cannot use the ANSI string returned from <b>mixerGetLineInfo</b> or
///              waveOutGetDevCaps for the value of the <b>psPname</b> string when calling <b>mixerGetLineInfo</b> with the
///              <b>MIXER_GETLINEINFOF_TARGETTYPE</b> flag. The reason is that an internal conversion to and from Unicode is
///              performed, which might result in loss of data. </div> <div> </div> </td> </tr> <tr> <td>MIXER_OBJECTF_AUX</td>
///              <td>The <i>hmxobj</i> parameter is an auxiliary device identifier in the range of zero to one less than the
///              number of devices returned by the auxGetNumDevs function.</td> </tr> <tr> <td>MIXER_OBJECTF_HMIDIIN</td> <td>The
///              <i>hmxobj</i> parameter is the handle of a MIDI input device. This handle must have been returned by the
///              midiInOpen function.</td> </tr> <tr> <td>MIXER_OBJECTF_HMIDIOUT</td> <td>The <i>hmxobj</i> parameter is the
///              handle of a MIDI output device. This handle must have been returned by the midiOutOpen function.</td> </tr> <tr>
///              <td>MIXER_OBJECTF_HMIXER</td> <td>The <i>hmxobj</i> parameter is a mixer device handle returned by the mixerOpen
///              function. This flag is optional.</td> </tr> <tr> <td>MIXER_OBJECTF_HWAVEIN</td> <td>The <i>hmxobj</i> parameter
///              is a waveform-audio input handle returned by the waveInOpen function.</td> </tr> <tr>
///              <td>MIXER_OBJECTF_HWAVEOUT</td> <td>The <i>hmxobj</i> parameter is a waveform-audio output handle returned by the
///              waveOutOpen function.</td> </tr> <tr> <td>MIXER_OBJECTF_MIDIIN</td> <td>The <i>hmxobj</i> parameter is the
///              identifier of a MIDI input device. This identifier must be in the range of zero to one less than the number of
///              devices returned by the midiInGetNumDevs function.</td> </tr> <tr> <td>MIXER_OBJECTF_MIDIOUT</td> <td>The
///              <i>hmxobj</i> parameter is the identifier of a MIDI output device. This identifier must be in the range of zero
///              to one less than the number of devices returned by the midiOutGetNumDevs function.</td> </tr> <tr>
///              <td>MIXER_OBJECTF_MIXER</td> <td>The <i>hmxobj</i> parameter is a mixer device identifier in the range of zero to
///              one less than the number of devices returned by the mixerGetNumDevs function. This flag is optional.</td> </tr>
///              <tr> <td>MIXER_OBJECTF_WAVEIN</td> <td>The <i>hmxobj</i> parameter is the identifier of a waveform-audio input
///              device in the range of zero to one less than the number of devices returned by the waveInGetNumDevs
///              function.</td> </tr> <tr> <td>MIXER_OBJECTF_WAVEOUT</td> <td>The <i>hmxobj</i> parameter is the identifier of a
///              waveform-audio output device in the range of zero to one less than the number of devices returned by the
///              waveOutGetNumDevs function.</td> </tr> </table>
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MIXERR_INVALLINE</b></dt> </dl> </td> <td width="60%"> The audio line reference is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_BADDEVICEID</b></dt> </dl> </td> <td width="60%"> The <i>hmxobj</i>
///    parameter specifies an invalid device identifier. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALFLAG</b></dt> </dl> </td> <td width="60%"> One or more flags are invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The <i>hmxobj</i>
///    parameter specifies an invalid handle. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt>
///    </dl> </td> <td width="60%"> One or more parameters are invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> No mixer device is available for the object
///    specified by <i>hmxobj</i>. </td> </tr> </table>
///    
@DllImport("WINMM")
uint mixerGetLineInfoA(HMIXEROBJ hmxobj, MIXERLINEA* pmxl, uint fdwInfo);

///The <b>mixerGetLineInfo</b> function retrieves information about a specific line of a mixer device.
///Params:
///    hmxobj = Handle to the mixer device object that controls the specific audio line.
///    pmxl = Pointer to a MIXERLINE structure. This structure is filled with information about the audio line for the mixer
///           device. The <b>cbStruct</b> member must always be initialized to be the size, in bytes, of the <b>MIXERLINE</b>
///           structure.
///    fdwInfo = Flags for retrieving information about an audio line. The following values are defined. <table> <tr> <th>Value
///              </th> <th>Meaning </th> </tr> <tr> <td>MIXER_GETLINEINFOF_COMPONENTTYPE</td> <td>The <i>pmxl</i> parameter will
///              receive information about the first audio line of the type specified in the <b>dwComponentType</b> member of the
///              MIXERLINE structure. This flag is used to retrieve information about an audio line of a specific component type.
///              Remaining structure members except <b>cbStruct</b> require no further initialization.</td> </tr> <tr>
///              <td>MIXER_GETLINEINFOF_DESTINATION</td> <td>The <i>pmxl</i> parameter will receive information about the
///              destination audio line specified by the <b>dwDestination</b> member of the MIXERLINE structure. This index ranges
///              from zero to one less than the value in the <b>cDestinations</b> member of the MIXERCAPS structure. All remaining
///              structure members except <b>cbStruct</b> require no further initialization.</td> </tr> <tr>
///              <td>MIXER_GETLINEINFOF_LINEID</td> <td>The <i>pmxl</i> parameter will receive information about the audio line
///              specified by the <b>dwLineID</b> member of the MIXERLINE structure. This is usually used to retrieve updated
///              information about the state of an audio line. All remaining structure members except <b>cbStruct</b> require no
///              further initialization.</td> </tr> <tr> <td>MIXER_GETLINEINFOF_SOURCE</td> <td>The <i>pmxl</i> parameter will
///              receive information about the source audio line specified by the <b>dwDestination</b> and <b>dwSource</b> members
///              of the MIXERLINE structure. The index specified by <b>dwDestination</b> ranges from zero to one less than the
///              value in the <b>cDestinations</b> member of the MIXERCAPS structure. The index specified by <b>dwSource</b>
///              ranges from zero to one less than the value in the <b>cConnections</b> member of the <b>MIXERLINE</b> structure
///              returned for the audio line stored in the <b>dwDestination</b> member. All remaining structure members except
///              <b>cbStruct</b> require no further initialization.</td> </tr> <tr> <td>MIXER_GETLINEINFOF_TARGETTYPE</td> <td>The
///              <i>pmxl</i> parameter will receive information about the audio line that is for the <b>dwType</b> member of the
///              <b>Target</b> structure, which is a member of the MIXERLINE structure. This flag is used to retrieve information
///              about an audio line that handles the target type (for example, <b>MIXERLINE_TARGETTYPE_WAVEOUT</b>). The
///              application must initialize the <b>dwType</b>, <b>wMid</b>, <b>wPid</b>, <b>vDriverVersion</b> and <b>szPname</b>
///              members of the MIXERLINE structure before calling <b>mixerGetLineInfo</b>. All of these values can be retrieved
///              from the device capabilities structures for all media devices. Remaining structure members except <b>cbStruct</b>
///              require no further initialization. <div class="alert"><b>Note</b> In the ANSI version of this function
///              (<b>mixerGetLineInfoA</b>), you cannot use the ANSI string returned from <b>mixerGetLineInfo</b> or
///              waveOutGetDevCaps for the value of the <b>psPname</b> string when calling <b>mixerGetLineInfo</b> with the
///              <b>MIXER_GETLINEINFOF_TARGETTYPE</b> flag. The reason is that an internal conversion to and from Unicode is
///              performed, which might result in loss of data. </div> <div> </div> </td> </tr> <tr> <td>MIXER_OBJECTF_AUX</td>
///              <td>The <i>hmxobj</i> parameter is an auxiliary device identifier in the range of zero to one less than the
///              number of devices returned by the auxGetNumDevs function.</td> </tr> <tr> <td>MIXER_OBJECTF_HMIDIIN</td> <td>The
///              <i>hmxobj</i> parameter is the handle of a MIDI input device. This handle must have been returned by the
///              midiInOpen function.</td> </tr> <tr> <td>MIXER_OBJECTF_HMIDIOUT</td> <td>The <i>hmxobj</i> parameter is the
///              handle of a MIDI output device. This handle must have been returned by the midiOutOpen function.</td> </tr> <tr>
///              <td>MIXER_OBJECTF_HMIXER</td> <td>The <i>hmxobj</i> parameter is a mixer device handle returned by the mixerOpen
///              function. This flag is optional.</td> </tr> <tr> <td>MIXER_OBJECTF_HWAVEIN</td> <td>The <i>hmxobj</i> parameter
///              is a waveform-audio input handle returned by the waveInOpen function.</td> </tr> <tr>
///              <td>MIXER_OBJECTF_HWAVEOUT</td> <td>The <i>hmxobj</i> parameter is a waveform-audio output handle returned by the
///              waveOutOpen function.</td> </tr> <tr> <td>MIXER_OBJECTF_MIDIIN</td> <td>The <i>hmxobj</i> parameter is the
///              identifier of a MIDI input device. This identifier must be in the range of zero to one less than the number of
///              devices returned by the midiInGetNumDevs function.</td> </tr> <tr> <td>MIXER_OBJECTF_MIDIOUT</td> <td>The
///              <i>hmxobj</i> parameter is the identifier of a MIDI output device. This identifier must be in the range of zero
///              to one less than the number of devices returned by the midiOutGetNumDevs function.</td> </tr> <tr>
///              <td>MIXER_OBJECTF_MIXER</td> <td>The <i>hmxobj</i> parameter is a mixer device identifier in the range of zero to
///              one less than the number of devices returned by the mixerGetNumDevs function. This flag is optional.</td> </tr>
///              <tr> <td>MIXER_OBJECTF_WAVEIN</td> <td>The <i>hmxobj</i> parameter is the identifier of a waveform-audio input
///              device in the range of zero to one less than the number of devices returned by the waveInGetNumDevs
///              function.</td> </tr> <tr> <td>MIXER_OBJECTF_WAVEOUT</td> <td>The <i>hmxobj</i> parameter is the identifier of a
///              waveform-audio output device in the range of zero to one less than the number of devices returned by the
///              waveOutGetNumDevs function.</td> </tr> </table>
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MIXERR_INVALLINE</b></dt> </dl> </td> <td width="60%"> The audio line reference is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_BADDEVICEID</b></dt> </dl> </td> <td width="60%"> The <i>hmxobj</i>
///    parameter specifies an invalid device identifier. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALFLAG</b></dt> </dl> </td> <td width="60%"> One or more flags are invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The <i>hmxobj</i>
///    parameter specifies an invalid handle. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt>
///    </dl> </td> <td width="60%"> One or more parameters are invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> No mixer device is available for the object
///    specified by <i>hmxobj</i>. </td> </tr> </table>
///    
@DllImport("WINMM")
uint mixerGetLineInfoW(HMIXEROBJ hmxobj, MIXERLINEW* pmxl, uint fdwInfo);

///The <b>mixerGetID</b> function retrieves the device identifier for a mixer device associated with a specified device
///handle.
///Params:
///    hmxobj = Handle to the audio mixer object to map to a mixer device identifier.
///    puMxId = Pointer to a variable that receives the mixer device identifier. If no mixer device is available for the
///             <i>hmxobj</i> object, the value -1 is placed in this location and the MMSYSERR_NODRIVER error value is returned.
///    fdwId = Flags for mapping the mixer object <i>hmxobj</i>. The following values are defined. <table> <tr> <th>Value </th>
///            <th>Meaning </th> </tr> <tr> <td>MIXER_OBJECTF_AUX</td> <td>The <i>hmxobj</i> parameter is an auxiliary device
///            identifier in the range of zero to one less than the number of devices returned by the auxGetNumDevs
///            function.</td> </tr> <tr> <td>MIXER_OBJECTF_HMIDIIN</td> <td>The <i>hmxobj</i> parameter is the handle of a MIDI
///            input device. This handle must have been returned by the midiInOpen function.</td> </tr> <tr>
///            <td>MIXER_OBJECTF_HMIDIOUT</td> <td>The <i>hmxobj</i> parameter is the handle of a MIDI output device. This
///            handle must have been returned by the midiOutOpen function.</td> </tr> <tr> <td>MIXER_OBJECTF_HMIXER</td> <td>The
///            <i>hmxobj</i> parameter is a mixer device handle returned by the mixerOpen function. This flag is optional.</td>
///            </tr> <tr> <td>MIXER_OBJECTF_HWAVEIN</td> <td>The <i>hmxobj</i> parameter is a waveform-audio input handle
///            returned by the waveInOpen function.</td> </tr> <tr> <td>MIXER_OBJECTF_HWAVEOUT</td> <td>The <i>hmxobj</i>
///            parameter is a waveform-audio output handle returned by the waveOutOpen function.</td> </tr> <tr>
///            <td>MIXER_OBJECTF_MIDIIN</td> <td>The <i>hmxobj</i> parameter is the identifier of a MIDI input device. This
///            identifier must be in the range of zero to one less than the number of devices returned by the midiInGetNumDevs
///            function.</td> </tr> <tr> <td>MIXER_OBJECTF_MIDIOUT</td> <td>The <i>hmxobj</i> parameter is the identifier of a
///            MIDI output device. This identifier must be in the range of zero to one less than the number of devices returned
///            by the midiOutGetNumDevs function.</td> </tr> <tr> <td>MIXER_OBJECTF_MIXER</td> <td>The <i>hmxobj</i> parameter
///            is the identifier of a mixer device in the range of zero to one less than the number of devices returned by the
///            mixerGetNumDevs function. This flag is optional.</td> </tr> <tr> <td>MIXER_OBJECTF_WAVEIN</td> <td>The
///            <i>hmxobj</i> parameter is the identifier of a waveform-audio input device in the range of zero to one less than
///            the number of devices returned by the waveInGetNumDevs function.</td> </tr> <tr> <td>MIXER_OBJECTF_WAVEOUT</td>
///            <td>The <i>hmxobj</i> parameter is the identifier of a waveform-audio output device in the range of zero to one
///            less than the number of devices returned by the waveOutGetNumDevs function.</td> </tr> </table>
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_BADDEVICEID</b></dt> </dl> </td> <td width="60%"> The <i>hmxobj</i> parameter specifies an
///    invalid device identifier. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALFLAG</b></dt> </dl> </td>
///    <td width="60%"> One or more flags are invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The <i>hmxobj</i> parameter specifies an
///    invalid handle. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td
///    width="60%"> One or more parameters are invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> No audio mixer device is available for the object
///    specified by <i>hmxobj</i>. The location referenced by <i>puMxId</i> also contains the value -1. </td> </tr>
///    </table>
///    
@DllImport("WINMM")
uint mixerGetID(HMIXEROBJ hmxobj, uint* puMxId, uint fdwId);

///The <b>mixerGetLineControls</b> function retrieves one or more controls associated with an audio line.
///Params:
///    hmxobj = Handle to the mixer device object that is being queried.
///    pmxlc = Pointer to a MIXERLINECONTROLS structure. This structure is used to reference one or more MIXERCONTROL structures
///            to be filled with information about the controls associated with an audio line. The <b>cbStruct</b> member of the
///            <b>MIXERLINECONTROLS</b> structure must always be initialized to be the size, in bytes, of the
///            <b>MIXERLINECONTROLS</b> structure.
///    fdwControls = Flags for retrieving information about one or more controls associated with an audio line. The following values
///                  are defined. <table> <tr> <th>Value </th> <th>Meaning </th> </tr> <tr> <td>MIXER_GETLINECONTROLSF_ALL</td>
///                  <td>The <i>pmxlc</i> parameter references a list of MIXERCONTROL structures that will receive information on all
///                  controls associated with the audio line identified by the <b>dwLineID</b> member of the MIXERLINECONTROLS
///                  structure. The <b>cControls</b> member must be initialized to the number of controls associated with the line.
///                  This number is retrieved from the <b>cControls</b> member of the MIXERLINE structure returned by the
///                  mixerGetLineInfo function. The <b>cbmxctrl</b> member must be initialized to the size, in bytes, of a single
///                  <b>MIXERCONTROL</b> structure. The <b>pamxctrl</b> member must point to the first <b>MIXERCONTROL</b> structure
///                  to be filled. The <b>dwControlID</b> and <b>dwControlType</b> members are ignored for this query.</td> </tr> <tr>
///                  <td>MIXER_GETLINECONTROLSF_ONEBYID</td> <td>The <i>pmxlc</i> parameter references a single MIXERCONTROL structure
///                  that will receive information on the control identified by the <b>dwControlID</b> member of the MIXERLINECONTROLS
///                  structure. The <b>cControls</b> member must be initialized to 1. The <b>cbmxctrl</b> member must be initialized
///                  to the size, in bytes, of a single <b>MIXERCONTROL</b> structure. The <b>pamxctrl</b> member must point to a
///                  <b>MIXERCONTROL</b> structure to be filled. The <b>dwLineID</b> and <b>dwControlType</b> members are ignored for
///                  this query. This query is usually used to refresh a control after receiving a MM_MIXM_CONTROL_CHANGE control
///                  change notification message by the user-defined callback (see mixerOpen).</td> </tr> <tr>
///                  <td>MIXER_GETLINECONTROLSF_ONEBYTYPE</td> <td>The <b>mixerGetLineControls</b> function retrieves information
///                  about the first control of a specific class for the audio line that is being queried. The <i>pmxlc</i> parameter
///                  references a single MIXERCONTROL structure that will receive information about the specific control. The audio
///                  line is identified by the <b>dwLineID</b> member. The control class is specified in the <b>dwControlType</b>
///                  member of the MIXERLINECONTROLS structure.The <b>dwControlID</b> member is ignored for this query. This query can
///                  be used by an application to get information on a single control associated with a line. For example, you might
///                  want your application to use a peak meter only from a waveform-audio output line. </td> </tr> <tr>
///                  <td>MIXER_OBJECTF_AUX</td> <td>The <i>hmxobj</i> parameter is an auxiliary device identifier in the range of zero
///                  to one less than the number of devices returned by the auxGetNumDevs function.</td> </tr> <tr>
///                  <td>MIXER_OBJECTF_HMIDIIN</td> <td>The <i>hmxobj</i> parameter is the handle of a MIDI input device. This handle
///                  must have been returned by the midiInOpen function.</td> </tr> <tr> <td>MIXER_OBJECTF_HMIDIOUT</td> <td>The
///                  <i>hmxobj</i> parameter is the handle of a MIDI output device. This handle must have been returned by the
///                  midiOutOpen function.</td> </tr> <tr> <td>MIXER_OBJECTF_HMIXER</td> <td>The <i>hmxobj</i> parameter is a mixer
///                  device handle returned by the mixerOpen function. This flag is optional.</td> </tr> <tr>
///                  <td>MIXER_OBJECTF_HWAVEIN</td> <td>The <i>hmxobj</i> parameter is a waveform-audio input handle returned by the
///                  waveInOpen function.</td> </tr> <tr> <td>MIXER_OBJECTF_HWAVEOUT</td> <td>The <i>hmxobj</i> parameter is a
///                  waveform-audio output handle returned by the waveOutOpen function.</td> </tr> <tr> <td>MIXER_OBJECTF_MIDIIN</td>
///                  <td>The <i>hmxobj</i> parameter is the identifier of a MIDI input device. This identifier must be in the range of
///                  zero to one less than the number of devices returned by the midiInGetNumDevs function.</td> </tr> <tr>
///                  <td>MIXER_OBJECTF_MIDIOUT</td> <td>The <i>hmxobj</i> parameter is the identifier of a MIDI output device. This
///                  identifier must be in the range of zero to one less than the number of devices returned by the midiOutGetNumDevs
///                  function.</td> </tr> <tr> <td>MIXER_OBJECTF_MIXER</td> <td>The <i>hmxobj</i> parameter is the identifier of a
///                  mixer device in the range of zero to one less than the number of devices returned by the mixerGetNumDevs
///                  function. This flag is optional.</td> </tr> <tr> <td>MIXER_OBJECTF_WAVEIN</td> <td>The <i>hmxobj</i> parameter is
///                  the identifier of a waveform-audio input device in the range of zero to one less than the number of devices
///                  returned by the waveInGetNumDevs function.</td> </tr> <tr> <td>MIXER_OBJECTF_WAVEOUT</td> <td>The <i>hmxobj</i>
///                  parameter is the identifier of a waveform-audio output device in the range of zero to one less than the number of
///                  devices returned by the waveOutGetNumDevs function.</td> </tr> </table>
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MIXERR_INVALCONTROL</b></dt> </dl> </td> <td width="60%"> The control reference is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MIXERR_INVALLINE</b></dt> </dl> </td> <td width="60%"> The audio line reference
///    is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_BADDEVICEID</b></dt> </dl> </td> <td
///    width="60%"> The <i>hmxobj</i> parameter specifies an invalid device identifier. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>MMSYSERR_INVALFLAG</b></dt> </dl> </td> <td width="60%"> One or more flags are invalid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The
///    <i>hmxobj</i> parameter specifies an invalid handle. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%"> One or more parameters are invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> No mixer device is
///    available for the object specified by <i>hmxobj</i>. </td> </tr> </table>
///    
@DllImport("WINMM")
uint mixerGetLineControlsA(HMIXEROBJ hmxobj, MIXERLINECONTROLSA* pmxlc, uint fdwControls);

///The <b>mixerGetLineControls</b> function retrieves one or more controls associated with an audio line.
///Params:
///    hmxobj = Handle to the mixer device object that is being queried.
///    pmxlc = Pointer to a MIXERLINECONTROLS structure. This structure is used to reference one or more MIXERCONTROL structures
///            to be filled with information about the controls associated with an audio line. The <b>cbStruct</b> member of the
///            <b>MIXERLINECONTROLS</b> structure must always be initialized to be the size, in bytes, of the
///            <b>MIXERLINECONTROLS</b> structure.
///    fdwControls = Flags for retrieving information about one or more controls associated with an audio line. The following values
///                  are defined. <table> <tr> <th>Value </th> <th>Meaning </th> </tr> <tr> <td>MIXER_GETLINECONTROLSF_ALL</td>
///                  <td>The <i>pmxlc</i> parameter references a list of MIXERCONTROL structures that will receive information on all
///                  controls associated with the audio line identified by the <b>dwLineID</b> member of the MIXERLINECONTROLS
///                  structure. The <b>cControls</b> member must be initialized to the number of controls associated with the line.
///                  This number is retrieved from the <b>cControls</b> member of the MIXERLINE structure returned by the
///                  mixerGetLineInfo function. The <b>cbmxctrl</b> member must be initialized to the size, in bytes, of a single
///                  <b>MIXERCONTROL</b> structure. The <b>pamxctrl</b> member must point to the first <b>MIXERCONTROL</b> structure
///                  to be filled. The <b>dwControlID</b> and <b>dwControlType</b> members are ignored for this query.</td> </tr> <tr>
///                  <td>MIXER_GETLINECONTROLSF_ONEBYID</td> <td>The <i>pmxlc</i> parameter references a single MIXERCONTROL structure
///                  that will receive information on the control identified by the <b>dwControlID</b> member of the MIXERLINECONTROLS
///                  structure. The <b>cControls</b> member must be initialized to 1. The <b>cbmxctrl</b> member must be initialized
///                  to the size, in bytes, of a single <b>MIXERCONTROL</b> structure. The <b>pamxctrl</b> member must point to a
///                  <b>MIXERCONTROL</b> structure to be filled. The <b>dwLineID</b> and <b>dwControlType</b> members are ignored for
///                  this query. This query is usually used to refresh a control after receiving a MM_MIXM_CONTROL_CHANGE control
///                  change notification message by the user-defined callback (see mixerOpen).</td> </tr> <tr>
///                  <td>MIXER_GETLINECONTROLSF_ONEBYTYPE</td> <td>The <b>mixerGetLineControls</b> function retrieves information
///                  about the first control of a specific class for the audio line that is being queried. The <i>pmxlc</i> parameter
///                  references a single MIXERCONTROL structure that will receive information about the specific control. The audio
///                  line is identified by the <b>dwLineID</b> member. The control class is specified in the <b>dwControlType</b>
///                  member of the MIXERLINECONTROLS structure.The <b>dwControlID</b> member is ignored for this query. This query can
///                  be used by an application to get information on a single control associated with a line. For example, you might
///                  want your application to use a peak meter only from a waveform-audio output line. </td> </tr> <tr>
///                  <td>MIXER_OBJECTF_AUX</td> <td>The <i>hmxobj</i> parameter is an auxiliary device identifier in the range of zero
///                  to one less than the number of devices returned by the auxGetNumDevs function.</td> </tr> <tr>
///                  <td>MIXER_OBJECTF_HMIDIIN</td> <td>The <i>hmxobj</i> parameter is the handle of a MIDI input device. This handle
///                  must have been returned by the midiInOpen function.</td> </tr> <tr> <td>MIXER_OBJECTF_HMIDIOUT</td> <td>The
///                  <i>hmxobj</i> parameter is the handle of a MIDI output device. This handle must have been returned by the
///                  midiOutOpen function.</td> </tr> <tr> <td>MIXER_OBJECTF_HMIXER</td> <td>The <i>hmxobj</i> parameter is a mixer
///                  device handle returned by the mixerOpen function. This flag is optional.</td> </tr> <tr>
///                  <td>MIXER_OBJECTF_HWAVEIN</td> <td>The <i>hmxobj</i> parameter is a waveform-audio input handle returned by the
///                  waveInOpen function.</td> </tr> <tr> <td>MIXER_OBJECTF_HWAVEOUT</td> <td>The <i>hmxobj</i> parameter is a
///                  waveform-audio output handle returned by the waveOutOpen function.</td> </tr> <tr> <td>MIXER_OBJECTF_MIDIIN</td>
///                  <td>The <i>hmxobj</i> parameter is the identifier of a MIDI input device. This identifier must be in the range of
///                  zero to one less than the number of devices returned by the midiInGetNumDevs function.</td> </tr> <tr>
///                  <td>MIXER_OBJECTF_MIDIOUT</td> <td>The <i>hmxobj</i> parameter is the identifier of a MIDI output device. This
///                  identifier must be in the range of zero to one less than the number of devices returned by the midiOutGetNumDevs
///                  function.</td> </tr> <tr> <td>MIXER_OBJECTF_MIXER</td> <td>The <i>hmxobj</i> parameter is the identifier of a
///                  mixer device in the range of zero to one less than the number of devices returned by the mixerGetNumDevs
///                  function. This flag is optional.</td> </tr> <tr> <td>MIXER_OBJECTF_WAVEIN</td> <td>The <i>hmxobj</i> parameter is
///                  the identifier of a waveform-audio input device in the range of zero to one less than the number of devices
///                  returned by the waveInGetNumDevs function.</td> </tr> <tr> <td>MIXER_OBJECTF_WAVEOUT</td> <td>The <i>hmxobj</i>
///                  parameter is the identifier of a waveform-audio output device in the range of zero to one less than the number of
///                  devices returned by the waveOutGetNumDevs function.</td> </tr> </table>
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MIXERR_INVALCONTROL</b></dt> </dl> </td> <td width="60%"> The control reference is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MIXERR_INVALLINE</b></dt> </dl> </td> <td width="60%"> The audio line reference
///    is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_BADDEVICEID</b></dt> </dl> </td> <td
///    width="60%"> The <i>hmxobj</i> parameter specifies an invalid device identifier. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>MMSYSERR_INVALFLAG</b></dt> </dl> </td> <td width="60%"> One or more flags are invalid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The
///    <i>hmxobj</i> parameter specifies an invalid handle. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%"> One or more parameters are invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> No mixer device is
///    available for the object specified by <i>hmxobj</i>. </td> </tr> </table>
///    
@DllImport("WINMM")
uint mixerGetLineControlsW(HMIXEROBJ hmxobj, MIXERLINECONTROLSW* pmxlc, uint fdwControls);

///The <b>mixerGetControlDetails</b> function retrieves details about a single control associated with an audio line.
///Params:
///    hmxobj = Handle to the mixer device object being queried.
///    pmxcd = Pointer to a MIXERCONTROLDETAILS structure, which is filled with state information about the control.
///    fdwDetails = Flags for retrieving control details. The following values are defined. <table> <tr> <th>Value </th> <th>Meaning
///                 </th> </tr> <tr> <td>MIXER_GETCONTROLDETAILSF_LISTTEXT</td> <td>The <b>paDetails</b> member of the
///                 MIXERCONTROLDETAILS structure points to one or more MIXERCONTROLDETAILS_LISTTEXT structures to receive text
///                 labels for multiple-item controls. An application must get all list text items for a multiple-item control at
///                 once. This flag cannot be used with MIXERCONTROL_CONTROLTYPE_CUSTOM controls.</td> </tr> <tr>
///                 <td>MIXER_GETCONTROLDETAILSF_VALUE</td> <td>Current values for a control are retrieved. The <b>paDetails</b>
///                 member of the MIXERCONTROLDETAILS structure points to one or more details structures appropriate for the control
///                 class.</td> </tr> <tr> <td>MIXER_OBJECTF_AUX</td> <td>The <i>hmxobj</i> parameter is an auxiliary device
///                 identifier in the range of zero to one less than the number of devices returned by the auxGetNumDevs
///                 function.</td> </tr> <tr> <td>MIXER_OBJECTF_HMIDIIN</td> <td>The <i>hmxobj</i> parameter is the handle of a MIDI
///                 (Musical Instrument Digital Interface) input device. This handle must have been returned by the midiInOpen
///                 function.</td> </tr> <tr> <td>MIXER_OBJECTF_HMIDIOUT</td> <td>The <i>hmxobj</i> parameter is the handle of a MIDI
///                 output device. This handle must have been returned by the midiOutOpen function.</td> </tr> <tr>
///                 <td>MIXER_OBJECTF_HMIXER</td> <td>The <i>hmxobj</i> parameter is a mixer device handle returned by the mixerOpen
///                 function. This flag is optional.</td> </tr> <tr> <td>MIXER_OBJECTF_HWAVEIN</td> <td>The <i>hmxobj</i> parameter
///                 is a waveform-audio input handle returned by the waveInOpen function.</td> </tr> <tr>
///                 <td>MIXER_OBJECTF_HWAVEOUT</td> <td>The <i>hmxobj</i> parameter is a waveform-audio output handle returned by the
///                 waveOutOpen function.</td> </tr> <tr> <td>MIXER_OBJECTF_MIDIIN</td> <td>The <i>hmxobj</i> parameter is the
///                 identifier of a MIDI input device. This identifier must be in the range of zero to one less than the number of
///                 devices returned by the midiInGetNumDevs function.</td> </tr> <tr> <td>MIXER_OBJECTF_MIDIOUT</td> <td>The
///                 <i>hmxobj</i> parameter is the identifier of a MIDI output device. This identifier must be in the range of zero
///                 to one less than the number of devices returned by the midiOutGetNumDevs function.</td> </tr> <tr>
///                 <td>MIXER_OBJECTF_MIXER</td> <td>The <i>hmxobj</i> parameter is the identifier of a mixer device in the range of
///                 zero to one less than the number of devices returned by the mixerGetNumDevs function. This flag is optional.</td>
///                 </tr> <tr> <td>MIXER_OBJECTF_WAVEIN</td> <td>The <i>hmxobj</i> parameter is the identifier of a waveform-audio
///                 input device in the range of zero to one less than the number of devices returned by the waveInGetNumDevs
///                 function.</td> </tr> <tr> <td>MIXER_OBJECTF_WAVEOUT</td> <td>The <i>hmxobj</i> parameter is the identifier of a
///                 waveform-audio output device in the range of zero to one less than the number of devices returned by the
///                 waveOutGetNumDevs function.</td> </tr> </table>
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MIXERR_INVALCONTROL</b></dt> </dl> </td> <td width="60%"> The control reference is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_BADDEVICEID</b></dt> </dl> </td> <td width="60%"> The <i>hmxobj</i>
///    parameter specifies an invalid device identifier. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALFLAG</b></dt> </dl> </td> <td width="60%"> One or more flags are invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The <i>hmxobj</i>
///    parameter specifies an invalid handle. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt>
///    </dl> </td> <td width="60%"> One or more parameters are invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> No mixer device is available for the object
///    specified by <i>hmxobj</i>. </td> </tr> </table>
///    
@DllImport("WINMM")
uint mixerGetControlDetailsA(HMIXEROBJ hmxobj, MIXERCONTROLDETAILS* pmxcd, uint fdwDetails);

///The <b>mixerGetControlDetails</b> function retrieves details about a single control associated with an audio line.
///Params:
///    hmxobj = Handle to the mixer device object being queried.
///    pmxcd = Pointer to a MIXERCONTROLDETAILS structure, which is filled with state information about the control.
///    fdwDetails = Flags for retrieving control details. The following values are defined. <table> <tr> <th>Value </th> <th>Meaning
///                 </th> </tr> <tr> <td>MIXER_GETCONTROLDETAILSF_LISTTEXT</td> <td>The <b>paDetails</b> member of the
///                 MIXERCONTROLDETAILS structure points to one or more MIXERCONTROLDETAILS_LISTTEXT structures to receive text
///                 labels for multiple-item controls. An application must get all list text items for a multiple-item control at
///                 once. This flag cannot be used with MIXERCONTROL_CONTROLTYPE_CUSTOM controls.</td> </tr> <tr>
///                 <td>MIXER_GETCONTROLDETAILSF_VALUE</td> <td>Current values for a control are retrieved. The <b>paDetails</b>
///                 member of the MIXERCONTROLDETAILS structure points to one or more details structures appropriate for the control
///                 class.</td> </tr> <tr> <td>MIXER_OBJECTF_AUX</td> <td>The <i>hmxobj</i> parameter is an auxiliary device
///                 identifier in the range of zero to one less than the number of devices returned by the auxGetNumDevs
///                 function.</td> </tr> <tr> <td>MIXER_OBJECTF_HMIDIIN</td> <td>The <i>hmxobj</i> parameter is the handle of a MIDI
///                 (Musical Instrument Digital Interface) input device. This handle must have been returned by the midiInOpen
///                 function.</td> </tr> <tr> <td>MIXER_OBJECTF_HMIDIOUT</td> <td>The <i>hmxobj</i> parameter is the handle of a MIDI
///                 output device. This handle must have been returned by the midiOutOpen function.</td> </tr> <tr>
///                 <td>MIXER_OBJECTF_HMIXER</td> <td>The <i>hmxobj</i> parameter is a mixer device handle returned by the mixerOpen
///                 function. This flag is optional.</td> </tr> <tr> <td>MIXER_OBJECTF_HWAVEIN</td> <td>The <i>hmxobj</i> parameter
///                 is a waveform-audio input handle returned by the waveInOpen function.</td> </tr> <tr>
///                 <td>MIXER_OBJECTF_HWAVEOUT</td> <td>The <i>hmxobj</i> parameter is a waveform-audio output handle returned by the
///                 waveOutOpen function.</td> </tr> <tr> <td>MIXER_OBJECTF_MIDIIN</td> <td>The <i>hmxobj</i> parameter is the
///                 identifier of a MIDI input device. This identifier must be in the range of zero to one less than the number of
///                 devices returned by the midiInGetNumDevs function.</td> </tr> <tr> <td>MIXER_OBJECTF_MIDIOUT</td> <td>The
///                 <i>hmxobj</i> parameter is the identifier of a MIDI output device. This identifier must be in the range of zero
///                 to one less than the number of devices returned by the midiOutGetNumDevs function.</td> </tr> <tr>
///                 <td>MIXER_OBJECTF_MIXER</td> <td>The <i>hmxobj</i> parameter is the identifier of a mixer device in the range of
///                 zero to one less than the number of devices returned by the mixerGetNumDevs function. This flag is optional.</td>
///                 </tr> <tr> <td>MIXER_OBJECTF_WAVEIN</td> <td>The <i>hmxobj</i> parameter is the identifier of a waveform-audio
///                 input device in the range of zero to one less than the number of devices returned by the waveInGetNumDevs
///                 function.</td> </tr> <tr> <td>MIXER_OBJECTF_WAVEOUT</td> <td>The <i>hmxobj</i> parameter is the identifier of a
///                 waveform-audio output device in the range of zero to one less than the number of devices returned by the
///                 waveOutGetNumDevs function.</td> </tr> </table>
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MIXERR_INVALCONTROL</b></dt> </dl> </td> <td width="60%"> The control reference is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_BADDEVICEID</b></dt> </dl> </td> <td width="60%"> The <i>hmxobj</i>
///    parameter specifies an invalid device identifier. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALFLAG</b></dt> </dl> </td> <td width="60%"> One or more flags are invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The <i>hmxobj</i>
///    parameter specifies an invalid handle. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt>
///    </dl> </td> <td width="60%"> One or more parameters are invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> No mixer device is available for the object
///    specified by <i>hmxobj</i>. </td> </tr> </table>
///    
@DllImport("WINMM")
uint mixerGetControlDetailsW(HMIXEROBJ hmxobj, MIXERCONTROLDETAILS* pmxcd, uint fdwDetails);

///The <b>mixerSetControlDetails</b> function sets properties of a single control associated with an audio line.
///Params:
///    hmxobj = Handle to the mixer device object for which properties are being set.
///    pmxcd = Pointer to a MIXERCONTROLDETAILS structure. This structure is used to reference control detail structures that
///            contain the desired state for the control.
///    fdwDetails = Flags for setting properties for a control. The following values are defined. <table> <tr> <th>Value </th>
///                 <th>Meaning </th> </tr> <tr> <td>MIXER_OBJECTF_AUX</td> <td>The <i>hmxobj</i> parameter is an auxiliary device
///                 identifier in the range of zero to one less than the number of devices returned by the auxGetNumDevs
///                 function.</td> </tr> <tr> <td>MIXER_OBJECTF_HMIDIIN</td> <td>The <i>hmxobj</i> parameter is the handle of a MIDI
///                 input device. This handle must have been returned by the midiInOpen function.</td> </tr> <tr>
///                 <td>MIXER_OBJECTF_HMIDIOUT</td> <td>The <i>hmxobj</i> parameter is the handle of a MIDI output device. This
///                 handle must have been returned by the midiOutOpen function.</td> </tr> <tr> <td>MIXER_OBJECTF_HMIXER</td> <td>The
///                 <i>hmxobj</i> parameter is a mixer device handle returned by the mixerOpen function. This flag is optional.</td>
///                 </tr> <tr> <td>MIXER_OBJECTF_HWAVEIN</td> <td>The <i>hmxobj</i> parameter is a waveform-audio input handle
///                 returned by the waveInOpen function.</td> </tr> <tr> <td>MIXER_OBJECTF_HWAVEOUT</td> <td>The <i>hmxobj</i>
///                 parameter is a waveform-audio output handle returned by the waveOutOpen function.</td> </tr> <tr>
///                 <td>MIXER_OBJECTF_MIDIIN</td> <td>The <i>hmxobj</i> parameter is the identifier of a MIDI input device. This
///                 identifier must be in the range of zero to one less than the number of devices returned by the midiInGetNumDevs
///                 function.</td> </tr> <tr> <td>MIXER_OBJECTF_MIDIOUT</td> <td>The <i>hmxobj</i> parameter is the identifier of a
///                 MIDI output device. This identifier must be in the range of zero to one less than the number of devices returned
///                 by the midiOutGetNumDevs function.</td> </tr> <tr> <td>MIXER_OBJECTF_MIXER</td> <td>The <i>hmxobj</i> parameter
///                 is a mixer device identifier in the range of zero to one less than the number of devices returned by the
///                 mixerGetNumDevs function. This flag is optional.</td> </tr> <tr> <td>MIXER_OBJECTF_WAVEIN</td> <td>The
///                 <i>hmxobj</i> parameter is the identifier of a waveform-audio input device in the range of zero to one less than
///                 the number of devices returned by the waveInGetNumDevs function.</td> </tr> <tr> <td>MIXER_OBJECTF_WAVEOUT</td>
///                 <td>The <i>hmxobj</i> parameter is the identifier of a waveform-audio output device in the range of zero to one
///                 less than the number of devices returned by the waveOutGetNumDevs function.</td> </tr> <tr>
///                 <td>MIXER_SETCONTROLDETAILSF_CUSTOM</td> <td>A custom dialog box for the specified custom mixer control is
///                 displayed. The mixer device gathers the required information from the user and returns the data in the specified
///                 buffer. The handle for the owning window is specified in the <b>hwndOwner</b> member of the MIXERCONTROLDETAILS
///                 structure. (This handle can be set to <b>NULL</b>.) The application can then save the data from the dialog box
///                 and use it later to reset the control to the same state by using the MIXER_SETCONTROLDETAILSF_VALUE flag.</td>
///                 </tr> <tr> <td>MIXER_SETCONTROLDETAILSF_VALUE</td> <td>The current value(s) for a control are set. The
///                 <b>paDetails</b> member of the MIXERCONTROLDETAILS structure points to one or more mixer-control details
///                 structures of the appropriate class for the control.</td> </tr> </table>
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MIXERR_INVALCONTROL</b></dt> </dl> </td> <td width="60%"> The control reference is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_BADDEVICEID</b></dt> </dl> </td> <td width="60%"> The <i>hmxobj</i>
///    parameter specifies an invalid device identifier. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALFLAG</b></dt> </dl> </td> <td width="60%"> One or more flags are invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The <i>hmxobj</i>
///    parameter specifies an invalid handle. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt>
///    </dl> </td> <td width="60%"> One or more parameters are invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> No mixer device is available for the object
///    specified by <i>hmxobj</i>. </td> </tr> </table>
///    
@DllImport("WINMM")
uint mixerSetControlDetails(HMIXEROBJ hmxobj, MIXERCONTROLDETAILS* pmxcd, uint fdwDetails);

///The <b>timeGetSystemTime</b> function retrieves the system time, in milliseconds. The system time is the time elapsed
///since Windows was started. This function works very much like the timeGetTime function. See <b>timeGetTime</b> for
///details of these functions' operation.
///Params:
///    pmmt = Pointer to an MMTIME structure.
///    cbmmt = Size, in bytes, of the MMTIME structure.
///Returns:
///    If successful, returns <b>TIMERR_NOERROR</b>. Otherwise, returns an error code.
///    
@DllImport("WINMM")
uint timeGetSystemTime(MMTIME* pmmt, uint cbmmt);

///The <b>timeGetTime</b> function retrieves the system time, in milliseconds. The system time is the time elapsed since
///Windows was started.
///Returns:
///    Returns the system time, in milliseconds.
///    
@DllImport("WINMM")
uint timeGetTime();

///The <b>timeGetDevCaps</b> function queries the timer device to determine its resolution.
///Params:
///    ptc = A pointer to a TIMECAPS structure. This structure is filled with information about the resolution of the timer
///          device.
///    cbtc = The size, in bytes, of the TIMECAPS structure.
///Returns:
///    Returns <b>MMSYSERR_NOERROR</b> if successful or an error code otherwise. Possible error codes include the
///    following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_ERROR</b></dt> </dl> </td> <td width="60%"> General error code. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>TIMERR_NOCANDO</b></dt> </dl> </td> <td width="60%"> The <i>ptc</i> parameter is <b>NULL</b>, or the
///    <i>cbtc</i> parameter is invalid, or some other error occurred. </td> </tr> </table>
///    
@DllImport("WINMM")
uint timeGetDevCaps(TIMECAPS* ptc, uint cbtc);

///The <b>timeBeginPeriod</b> function requests a minimum resolution for periodic timers.
///Params:
///    uPeriod = Minimum timer resolution, in milliseconds, for the application or device driver. A lower value specifies a higher
///              (more accurate) resolution.
///Returns:
///    Returns <b>TIMERR_NOERROR</b> if successful or <b>TIMERR_NOCANDO</b> if the resolution specified in
///    <i>uPeriod</i> is out of range.
///    
@DllImport("WINMM")
uint timeBeginPeriod(uint uPeriod);

///The <b>timeEndPeriod</b> function clears a previously set minimum timer resolution.
///Params:
///    uPeriod = Minimum timer resolution specified in the previous call to the timeBeginPeriod function.
///Returns:
///    Returns <b>TIMERR_NOERROR</b> if successful or <b>TIMERR_NOCANDO</b> if the resolution specified in uPeriod is
///    out of range.
///    
@DllImport("WINMM")
uint timeEndPeriod(uint uPeriod);

///The <b>joyGetPosEx</b> function queries a joystick for its position and button status.
///Params:
///    uJoyID = Identifier of the joystick to be queried. Valid values for <i>uJoyID</i> range from zero (JOYSTICKID1) to 15.
///    pji = Pointer to a JOYINFOEX structure that contains extended position information and button status of the joystick.
///          You must set the <b>dwSize</b> and <b>dwFlags</b> members or <b>joyGetPosEx</b> will fail. The information
///          returned from <b>joyGetPosEx</b> depends on the flags you specify in <b>dwFlags</b>.
///Returns:
///    Returns JOYERR_NOERROR if successful or one of the following error values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td
///    width="60%"> The joystick driver is not present. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%"> An invalid parameter was passed. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_BADDEVICEID</b></dt> </dl> </td> <td width="60%"> The specified
///    joystick identifier is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>JOYERR_UNPLUGGED</b></dt> </dl>
///    </td> <td width="60%"> The specified joystick is not connected to the system. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>JOYERR_PARMS</b></dt> </dl> </td> <td width="60%"> The specified joystick identifier is invalid.
///    </td> </tr> </table>
///    
@DllImport("WINMM")
uint joyGetPosEx(uint uJoyID, JOYINFOEX* pji);

///The <b>joyGetNumDevs</b> function queries the joystick driver for the number of joysticks it supports.
///Returns:
///    The <b>joyGetNumDevs</b> function returns the number of joysticks supported by the current driver or zero if no
///    driver is installed.
///    
@DllImport("WINMM")
uint joyGetNumDevs();

@DllImport("WINMM")
uint joyGetDevCapsA(size_t uJoyID, JOYCAPSA* pjc, uint cbjc);

///The <b>joyGetDevCaps</b> function queries a joystick to determine its capabilities.
///Params:
///    uJoyID = Identifier of the joystick to be queried. Valid values for <i>uJoyID</i> range from -1 to 15. A value of -1
///             enables retrieval of the <b>szRegKey</b> member of the JOYCAPS structure whether a device is present or not.
///    pjc = Pointer to a JOYCAPS structure to contain the capabilities of the joystick.
///    cbjc = Size, in bytes, of the JOYCAPS structure.
///Returns:
///    Returns JOYERR_NOERROR if successful or one of the following error values: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td
///    width="60%"> The joystick driver is not present, or the specified joystick identifier is invalid. The specified
///    joystick identifier is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl>
///    </td> <td width="60%"> An invalid parameter was passed. </td> </tr> </table>
///    
@DllImport("WINMM")
uint joyGetDevCapsW(size_t uJoyID, JOYCAPSW* pjc, uint cbjc);

///The <b>joyGetPos</b> function queries a joystick for its position and button status.
///Params:
///    uJoyID = Identifier of the joystick to be queried. Valid values for <i>uJoyID</i> range from zero (JOYSTICKID1) to 15.
///    pji = Pointer to a JOYINFO structure that contains the position and button status of the joystick.
///Returns:
///    Returns JOYERR_NOERROR if successful or one of the following error values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td
///    width="60%"> The joystick driver is not present. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%"> An invalid parameter was passed. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>JOYERR_UNPLUGGED</b></dt> </dl> </td> <td width="60%"> The specified joystick
///    is not connected to the system. </td> </tr> </table>
///    
@DllImport("WINMM")
uint joyGetPos(uint uJoyID, JOYINFO* pji);

///The <b>joyGetThreshold</b> function queries a joystick for its current movement threshold.
///Params:
///    uJoyID = Identifier of the joystick. Valid values for <i>uJoyID</i> range from zero (JOYSTICKID1) to 15.
///    puThreshold = Pointer to a variable that contains the movement threshold value.
///Returns:
///    Returns JOYERR_NOERROR if successful or one of the following error values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td
///    width="60%"> The joystick driver is not present. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%"> An invalid parameter was passed. </td> </tr>
///    </table>
///    
@DllImport("WINMM")
uint joyGetThreshold(uint uJoyID, uint* puThreshold);

///The <b>joyReleaseCapture</b> function releases the specified captured joystick.
///Params:
///    uJoyID = Identifier of the joystick to be released. Valid values for <i>uJoyID</i> range from zero (JOYSTICKID1) to 15.
///Returns:
///    Returns JOYERR_NOERROR if successful or one of the following error values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td
///    width="60%"> The joystick driver is not present. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALIDPARAM</b></dt> </dl> </td> <td width="60%"> The specified joystick device identifier
///    <i>uJoyID</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>JOYERR_PARMS</b></dt> </dl> </td> <td
///    width="60%"> The specified joystick device identifier <i>uJoyID</i> is invalid. </td> </tr> </table>
///    
@DllImport("WINMM")
uint joyReleaseCapture(uint uJoyID);

///The <b>joySetCapture</b> function captures a joystick by causing its messages to be sent to the specified window.
///Params:
///    hwnd = Handle to the window to receive the joystick messages.
///    uJoyID = Identifier of the joystick to be captured. Valid values for <i>uJoyID</i> range from zero (JOYSTICKID1) to 15.
///    uPeriod = Polling frequency, in milliseconds.
///    fChanged = Change position flag. Specify <b>TRUE</b> for this parameter to send messages only when the position changes by a
///               value greater than the joystick movement threshold. Otherwise, messages are sent at the polling frequency
///               specified in <i>uPeriod</i>.
///Returns:
///    Returns JOYERR_NOERROR if successful or one of the following error values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td
///    width="60%"> The joystick driver is not present. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%"> Invalid joystick ID or hwnd is <b>NULL</b>.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>JOYERR_NOCANDO</b></dt> </dl> </td> <td width="60%"> Cannot capture
///    joystick input because a required service (such as a Windows timer) is unavailable. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>JOYERR_UNPLUGGED</b></dt> </dl> </td> <td width="60%"> The specified joystick is not
///    connected to the system. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>JOYERR_PARMS</b></dt> </dl> </td> <td
///    width="60%"> Invalid joystick ID or hwnd is <b>NULL</b>. </td> </tr> </table>
///    
@DllImport("WINMM")
uint joySetCapture(HWND hwnd, uint uJoyID, uint uPeriod, BOOL fChanged);

///The <b>joySetThreshold</b> function sets the movement threshold of a joystick.
///Params:
///    uJoyID = Identifier of the joystick. Valid values for <i>uJoyID</i> range from zero (JOYSTICKID1) to 15.
///    uThreshold = New movement threshold.
///Returns:
///    Returns JOYERR_NOERROR if successful or one of the following error values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td
///    width="60%"> The joystick driver is not present. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>JOYERR_PARMS</b></dt> </dl> </td> <td width="60%"> The specified joystick device identifier <i>uJoyID</i>
///    is invalid. </td> </tr> </table>
///    
@DllImport("WINMM")
uint joySetThreshold(uint uJoyID, uint uThreshold);

///The <b>acmGetVersion</b> function returns the version number of the ACM.
///Returns:
///    The version number is returned as a hexadecimal number of the form 0xAABBCCCC, where AA is the major version
///    number, BB is the minor version number, and CCCC is the build number.
///    
@DllImport("MSACM32")
uint acmGetVersion();

///The <b>acmMetrics</b> function returns various metrics for the ACM or related ACM objects.
///Params:
///    hao = Handle to the ACM object to query for the metric specified in <i>uMetric</i>. For some queries, this parameter
///          can be <b>NULL</b>.
///    uMetric = Metric index to be returned in <i>pMetric</i>. <table> <tr> <th>Value </th> <th>Meaning </th> </tr> <tr>
///              <td>ACM_METRIC_COUNT_CODECS</td> <td>Returned value is the number of global ACM compressor or decompressor
///              drivers in the system. The <i>hao</i> parameter must be <b>NULL</b> for this metric index. The <i>pMetric</i>
///              parameter must point to a buffer of a size equal to a <b>DWORD</b> value.</td> </tr> <tr>
///              <td>ACM_METRIC_COUNT_CONVERTERS</td> <td>Returned value is the number of global ACM converter drivers in the
///              system. The <i>hao</i> parameter must be <b>NULL</b> for this metric index. The <i>pMetric</i> parameter must
///              point to a buffer of a size equal to a <b>DWORD</b> value.</td> </tr> <tr> <td>ACM_METRIC_COUNT_DISABLED</td>
///              <td>Returned value is the total number of global disabled ACM drivers (of all support types) in the system. The
///              <i>hao</i> parameter must be <b>NULL</b> for this metric index. The <i>pMetric</i> parameter must point to a
///              buffer of a size equal to a <b>DWORD</b> value. The sum of the ACM_METRIC_COUNT_DRIVERS and
///              ACM_METRIC_COUNT_DISABLED metric indices is the total number of globally installed ACM drivers.</td> </tr> <tr>
///              <td>ACM_METRIC_COUNT_DRIVERS</td> <td>Returned value is the total number of enabled global ACM drivers (of all
///              support types) in the system. The <i>hao</i> parameter must be <b>NULL</b> for this metric index. The
///              <i>pMetric</i> parameter must point to a buffer of a size equal to a <b>DWORD</b> value.</td> </tr> <tr>
///              <td>ACM_METRIC_COUNT_FILTERS</td> <td>Returned value is the number of global ACM filter drivers in the system.
///              The <i>hao</i> parameter must be <b>NULL</b> for this metric index. The <i>pMetric</i> parameter must point to a
///              buffer of a size equal to a <b>DWORD</b> value.</td> </tr> <tr> <td>ACM_METRIC_COUNT_HARDWARE</td> <td>Returned
///              value is the number of global ACM hardware drivers in the system. The <i>hao</i> parameter must be <b>NULL</b>
///              for this metric index. The <i>pMetric</i> parameter must point to a buffer of a size equal to a <b>DWORD</b>
///              value.</td> </tr> <tr> <td>ACM_METRIC_COUNT_LOCAL_CODECS</td> <td>Returned value is the number of local ACM
///              compressor drivers, ACM decompressor drivers, or both for the calling task. The <i>hao</i> parameter must be
///              <b>NULL</b> for this metric index. The <i>pMetric</i> parameter must point to a buffer of a size equal to a
///              <b>DWORD</b> value.</td> </tr> <tr> <td>ACM_METRIC_COUNT_LOCAL_CONVERTERS</td> <td>Returned value is the number
///              of local ACM converter drivers for the calling task. The <i>hao</i> parameter must be <b>NULL</b> for this metric
///              index. The <i>pMetric</i> parameter must point to a buffer of a size equal to a <b>DWORD</b> value.</td> </tr>
///              <tr> <td>ACM_METRIC_COUNT_LOCAL_DISABLED</td> <td>Returned value is the total number of local disabled ACM
///              drivers, of all support types, for the calling task. The <i>hao</i> parameter must be <b>NULL</b> for this metric
///              index. The <i>pMetric</i> parameter must point to a buffer of a size equal to a <b>DWORD</b> value. The sum of
///              the ACM_METRIC_COUNT_LOCAL_DRIVERS and ACM_METRIC_COUNT_LOCAL_DISABLED metric indices is the total number of
///              locally installed ACM drivers.</td> </tr> <tr> <td>ACM_METRIC_COUNT_LOCAL_DRIVERS</td> <td>Returned value is the
///              total number of enabled local ACM drivers (of all support types) for the calling task. The <i>hao</i> parameter
///              must be <b>NULL</b> for this metric index. The <i>pMetric</i> parameter must point to a buffer of a size equal to
///              a <b>DWORD</b> value.</td> </tr> <tr> <td>ACM_METRIC_COUNT_LOCAL_FILTERS</td> <td>Returned value is the number of
///              local ACM filter drivers for the calling task. The <i>hao</i> parameter must be <b>NULL</b> for this metric
///              index. The <i>pMetric</i> parameter must point to a buffer of a size equal to a <b>DWORD</b> value.</td> </tr>
///              <tr> <td>ACM_METRIC_DRIVER_PRIORITY</td> <td>Returned value is the current priority for the specified driver. The
///              <i>hao</i> parameter must be a valid ACM driver identifier of the <b>HACMDRIVERID</b> data type. The
///              <i>pMetric</i> parameter must point to a buffer of a size equal to a <b>DWORD</b> value.</td> </tr> <tr>
///              <td>ACM_METRIC_DRIVER_SUPPORT</td> <td>Returned value is the <b>fdwSupport</b> flags for the specified driver.
///              The <i>hao</i> parameter must be a valid ACM driver identifier of the <b>HACMDRIVERID</b> data type. The
///              <i>pMetric</i> parameter must point to a buffer of a size equal to a <b>DWORD</b> value.</td> </tr> <tr>
///              <td>ACM_METRIC_HARDWARE_WAVE_INPUT</td> <td>Returned value is the waveform-audio input device identifier
///              associated with the specified driver. The <i>hao</i> parameter must be a valid ACM driver identifier of the
///              <b>HACMDRIVERID</b> data type that supports the ACMDRIVERDETAILS_SUPPORTF_HARDWARE flag. If no waveform-audio
///              input device is associated with the driver, MMSYSERR_NOTSUPPORTED is returned. The <i>pMetric</i> parameter must
///              point to a buffer of a size equal to a <b>DWORD</b> value.</td> </tr> <tr>
///              <td>ACM_METRIC_HARDWARE_WAVE_OUTPUT</td> <td>Returned value is the waveform-audio output device identifier
///              associated with the specified driver. The <i>hao</i> parameter must be a valid ACM driver identifier of the
///              <b>HACMDRIVERID</b> data type that supports the ACMDRIVERDETAILS_SUPPORTF_HARDWARE flag. If no waveform-audio
///              output device is associated with the driver, MMSYSERR_NOTSUPPORTED is returned. The <i>pMetric</i> parameter must
///              point to a buffer of a size equal to a <b>DWORD</b> value.</td> </tr> <tr> <td>ACM_METRIC_MAX_SIZE_FILTER</td>
///              <td>Returned value is the size of the largest WAVEFILTER structure. If <i>hao</i> is <b>NULL</b>, the return
///              value is the largest <b>WAVEFILTER</b> structure in the system. If <i>hao</i> identifies an open instance of an
///              ACM driver of the <b>HACMDRIVER</b> data type or an ACM driver identifier of the <b>HACMDRIVERID</b> data type,
///              the largest <b>WAVEFILTER</b> structure for that driver is returned. The <i>pMetric</i> parameter must point to a
///              buffer of a size equal to a <b>DWORD</b> value. This metric is not allowed for an ACM stream handle of the
///              <b>HACMSTREAM</b> data type.</td> </tr> <tr> <td>ACM_METRIC_MAX_SIZE_FORMAT</td> <td>Returned value is the size
///              of the largest WAVEFORMATEX structure. If <i>hao</i> is <b>NULL</b>, the return value is the largest
///              <b>WAVEFORMATEX</b> structure in the system. If <i>hao</i> identifies an open instance of an ACM driver of the
///              <b>HACMDRIVER</b> data type or an ACM driver identifier of the <b>HACMDRIVERID</b> data type, the largest
///              <b>WAVEFORMATEX</b> structure for that driver is returned. The <i>pMetric</i> parameter must point to a buffer of
///              a size equal to a <b>DWORD</b> value. This metric is not allowed for an ACM stream handle of the
///              <b>HACMSTREAM</b> data type.</td> </tr> </table>
///    pMetric = Pointer to the buffer to receive the metric details. The exact definition depends on the <i>uMetric</i> index.
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ACMERR_NOTPOSSIBLE</b></dt>
///    </dl> </td> <td width="60%"> The index specified in <i>uMetric</i> cannot be returned for the specified
///    <i>hao</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td
///    width="60%"> The specified handle is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%"> At least one parameter is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOTSUPPORTED</b></dt> </dl> </td> <td width="60%"> The index specified
///    in <i>uMetric</i> is not supported. </td> </tr> </table>
///    
@DllImport("MSACM32")
uint acmMetrics(HACMOBJ__* hao, uint uMetric, void* pMetric);

///The <b>acmDriverEnum</b> function enumerates the available ACM drivers, continuing until there are no more drivers or
///the callback function returns <b>FALSE</b>.
///Params:
///    fnCallback = Procedure instance address of the application-defined callback function.
///    dwInstance = A 64-bit (DWORD_PTR) or 32-bit (DWORD) application-defined value that is passed to the callback function along
///                 with ACM driver information.
///    fdwEnum = Flags for enumerating ACM drivers. The following values are defined. <table> <tr> <th>Value </th> <th>Meaning
///              </th> </tr> <tr> <td>ACM_DRIVERENUMF_DISABLED</td> <td>Disabled ACM drivers should be included in the
///              enumeration. Drivers can be disabled by the user through the Control Panel or by an application using the
///              acmDriverPriority function. If a driver is disabled, the <i>fdwSupport</i> parameter to the callback function
///              will have the ACMDRIVERDETAILS_SUPPORTF_DISABLED flag set.</td> </tr> <tr> <td>ACM_DRIVERENUMF_NOLOCAL</td>
///              <td>Only global drivers should be included in the enumeration.</td> </tr> </table>
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALFLAG</b></dt>
///    </dl> </td> <td width="60%"> At least one flag is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%"> At least one parameter is invalid. </td> </tr>
///    </table>
///    
@DllImport("MSACM32")
uint acmDriverEnum(ACMDRIVERENUMCB fnCallback, size_t dwInstance, uint fdwEnum);

///The <b>acmDriverID</b> function returns the handle of an ACM driver identifier associated with an open ACM driver
///instance or stream handle.
///Params:
///    hao = Handle to the open driver instance or stream handle. This is the handle of an ACM object, such as
///          <b>HACMDRIVER</b> or <b>HACMSTREAM</b>.
///    phadid = Pointer to a buffer that receives a handle identifying the installed driver that is associated with <i>hao</i>.
///    fdwDriverID = Reserved; must be zero.
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALFLAG</b></dt>
///    </dl> </td> <td width="60%"> At least one flag is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified handle is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%"> At least one
///    parameter is invalid. </td> </tr> </table>
///    
@DllImport("MSACM32")
uint acmDriverID(HACMOBJ__* hao, HACMDRIVERID__** phadid, uint fdwDriverID);

///The <b>acmDriverAdd</b> function adds a driver to the list of available ACM drivers. The driver type and location are
///dependent on the flags used to add ACM drivers. After a driver is successfully added, the driver entry function will
///receive ACM driver messages.
///Params:
///    phadid = Pointer to the buffer that receives a handle identifying the installed driver. This handle is used to identify
///             the driver in calls to other ACM functions.
///    hinstModule = Handle to the instance of the module whose executable or dynamic-link library (DLL) contains the driver entry
///                  function.
///    lParam = Driver function address or a notification window handle, depending on the <i>fdwAdd</i> flags.
///    dwPriority = Window message to send for notification broadcasts. This parameter is used only with the
///                 ACM_DRIVERADDF_NOTIFYHWND flag. All other flags require this member to be set to zero.
///    fdwAdd = Flags for adding ACM drivers. The following values are defined. <table> <tr> <th>Value </th> <th>Meaning </th>
///             </tr> <tr> <td>ACM_DRIVERADDF_FUNCTION</td> <td>The <i>lParam</i> parameter is a driver function address
///             conforming to the acmDriverProc prototype. The function may reside in either an executable or DLL file.</td>
///             </tr> <tr> <td>ACM_DRIVERADDF_GLOBAL</td> <td>Provided for compatibility with 16-bit applications. For the Win32
///             API, ACM drivers added by the <b>acmDriverAdd</b> function can be used only by the application that added the
///             driver. This is true whether or not ACM_DRIVERADDF_GLOBAL is specified. For more information, see Adding Drivers
///             Within an Application.</td> </tr> <tr> <td>ACM_DRIVERADDF_LOCAL</td> <td>The ACM automatically gives a local
///             driver higher priority than a global driver when searching for a driver to satisfy a function call. For more
///             information, see Adding Drivers Within an Application.</td> </tr> <tr> <td>ACM_DRIVERADDF_NAME</td> <td>The
///             <i>lParam</i> parameter is a registry value name in HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows
///             NT\CurrentVersion\Drivers32. The value identifies a DLL that implements an ACM codec. Applications can use this
///             flag if new registry entries are created after the application has already started using the ACM.</td> </tr> <tr>
///             <td>ACM_DRIVERADDF_NOTIFYHWND</td> <td>The <i>lParam</i> parameter is a handle of a notification window that
///             receives messages when changes to global driver priorities and states are made. The window message to receive is
///             defined by the application and must be passed in <i>dwPriority</i>. The <i>wParam</i> and <i>lParam</i>
///             parameters passed with the window message are reserved for future use and should be ignored.
///             ACM_DRIVERADDF_GLOBAL cannot be specified in conjunction with this flag. For more information about driver
///             priorities, see the description for the acmDriverPriority function.</td> </tr> </table>
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALFLAG</b></dt>
///    </dl> </td> <td width="60%"> At least one flag is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%"> At least one parameter is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%"> The system is unable to
///    allocate resources. </td> </tr> </table>
///    
@DllImport("MSACM32")
uint acmDriverAddA(HACMDRIVERID__** phadid, HINSTANCE hinstModule, LPARAM lParam, uint dwPriority, uint fdwAdd);

///The <b>acmDriverAdd</b> function adds a driver to the list of available ACM drivers. The driver type and location are
///dependent on the flags used to add ACM drivers. After a driver is successfully added, the driver entry function will
///receive ACM driver messages.
///Params:
///    phadid = Pointer to the buffer that receives a handle identifying the installed driver. This handle is used to identify
///             the driver in calls to other ACM functions.
///    hinstModule = Handle to the instance of the module whose executable or dynamic-link library (DLL) contains the driver entry
///                  function.
///    lParam = Driver function address or a notification window handle, depending on the <i>fdwAdd</i> flags.
///    dwPriority = Window message to send for notification broadcasts. This parameter is used only with the
///                 ACM_DRIVERADDF_NOTIFYHWND flag. All other flags require this member to be set to zero.
///    fdwAdd = Flags for adding ACM drivers. The following values are defined. <table> <tr> <th>Value </th> <th>Meaning </th>
///             </tr> <tr> <td>ACM_DRIVERADDF_FUNCTION</td> <td>The <i>lParam</i> parameter is a driver function address
///             conforming to the acmDriverProc prototype. The function may reside in either an executable or DLL file.</td>
///             </tr> <tr> <td>ACM_DRIVERADDF_GLOBAL</td> <td>Provided for compatibility with 16-bit applications. For the Win32
///             API, ACM drivers added by the <b>acmDriverAdd</b> function can be used only by the application that added the
///             driver. This is true whether or not ACM_DRIVERADDF_GLOBAL is specified. For more information, see Adding Drivers
///             Within an Application.</td> </tr> <tr> <td>ACM_DRIVERADDF_LOCAL</td> <td>The ACM automatically gives a local
///             driver higher priority than a global driver when searching for a driver to satisfy a function call. For more
///             information, see Adding Drivers Within an Application.</td> </tr> <tr> <td>ACM_DRIVERADDF_NAME</td> <td>The
///             <i>lParam</i> parameter is a registry value name in HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows
///             NT\CurrentVersion\Drivers32. The value identifies a DLL that implements an ACM codec. Applications can use this
///             flag if new registry entries are created after the application has already started using the ACM.</td> </tr> <tr>
///             <td>ACM_DRIVERADDF_NOTIFYHWND</td> <td>The <i>lParam</i> parameter is a handle of a notification window that
///             receives messages when changes to global driver priorities and states are made. The window message to receive is
///             defined by the application and must be passed in <i>dwPriority</i>. The <i>wParam</i> and <i>lParam</i>
///             parameters passed with the window message are reserved for future use and should be ignored.
///             ACM_DRIVERADDF_GLOBAL cannot be specified in conjunction with this flag. For more information about driver
///             priorities, see the description for the acmDriverPriority function.</td> </tr> </table>
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALFLAG</b></dt>
///    </dl> </td> <td width="60%"> At least one flag is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%"> At least one parameter is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td width="60%"> The system is unable to
///    allocate resources. </td> </tr> </table>
///    
@DllImport("MSACM32")
uint acmDriverAddW(HACMDRIVERID__** phadid, HINSTANCE hinstModule, LPARAM lParam, uint dwPriority, uint fdwAdd);

///The <b>acmDriverRemove</b> function removes an ACM driver from the list of available ACM drivers. The driver will be
///removed for the calling application only. If the driver is globally installed, other applications will still be able
///to use it.
///Params:
///    hadid = Handle to the driver identifier to be removed.
///    fdwRemove = Reserved; must be zero.
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ACMERR_BUSY</b></dt> </dl>
///    </td> <td width="60%"> The driver is in use and cannot be removed. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALFLAG</b></dt> </dl> </td> <td width="60%"> At least one flag is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified handle is
///    invalid. </td> </tr> </table>
///    
@DllImport("MSACM32")
uint acmDriverRemove(HACMDRIVERID__* hadid, uint fdwRemove);

///The <b>acmDriverOpen</b> function opens the specified ACM driver and returns a driver instance handle that can be
///used to communicate with the driver.
///Params:
///    phad = Pointer to a buffer that receives the new driver instance handle that can be used to communicate with the driver.
///    hadid = Handle to the driver identifier of an installed and enabled ACM driver.
///    fdwOpen = Reserved; must be zero.
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALFLAG</b></dt>
///    </dl> </td> <td width="60%"> At least one flag is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified handle is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%"> At least one
///    parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td
///    width="60%"> The system is unable to allocate resources. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_NOTENABLED</b></dt> </dl> </td> <td width="60%"> The driver is not enabled. </td> </tr> </table>
///    
@DllImport("MSACM32")
uint acmDriverOpen(HACMDRIVER__** phad, HACMDRIVERID__* hadid, uint fdwOpen);

///The <b>acmDriverClose</b> function closes a previously opened ACM driver instance. If the function is successful, the
///handle is invalidated.
///Params:
///    had = Handle to the open driver instance to be closed.
///    fdwClose = Reserved; must be zero.
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ACMERR_BUSY</b></dt> </dl>
///    </td> <td width="60%"> The driver is in use and cannot be closed. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALFLAG</b></dt> </dl> </td> <td width="60%"> At least one flag is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified handle is
///    invalid. </td> </tr> </table>
///    
@DllImport("MSACM32")
uint acmDriverClose(HACMDRIVER__* had, uint fdwClose);

///The <b>acmDriverMessage</b> function sends a user-defined message to a given ACM driver instance.
///Params:
///    had = Handle to the ACM driver instance to which the message will be sent.
///    uMsg = Message that the ACM driver must process. This message must be in the ACMDM_USER message range (above or equal to
///           ACMDM_USER and less than ACMDM_RESERVED_LOW). The exceptions to this restriction are the ACMDM_DRIVER_ABOUT,
///           DRV_QUERYCONFIGURE, and DRV_CONFIGURE messages.
///    lParam1 = Message parameter.
///    lParam2 = Message parameter.
///Returns:
///    The return value is specific to the user-defined ACM driver message specified by the uMsg parameter. However,
///    possible error values include the following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified handle is
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%">
///    The <i>uMsg</i> parameter is not in the ACMDM_USER range. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_NOTSUPPORTED</b></dt> </dl> </td> <td width="60%"> The ACM driver did not process the message.
///    </td> </tr> </table>
///    
@DllImport("MSACM32")
LRESULT acmDriverMessage(HACMDRIVER__* had, uint uMsg, LPARAM lParam1, LPARAM lParam2);

///The <b>acmDriverPriority</b> function modifies the priority and state of an ACM driver.
///Params:
///    hadid = Handle to the driver identifier of an installed ACM driver. If the ACM_DRIVERPRIORITYF_BEGIN and
///            ACM_DRIVERPRIORITYF_END flags are specified, this parameter must be <b>NULL</b>.
///    dwPriority = New priority for a global ACM driver identifier. A zero value specifies that the priority of the driver
///                 identifier should remain unchanged. A value of 1 specifies that the driver should be placed as the highest search
///                 priority driver. A value of –1 specifies that the driver should be placed as the lowest search priority driver.
///                 Priorities are used only for global drivers.
///    fdwPriority = Flags for setting priorities of ACM drivers. The following values are defined. <table> <tr> <th>Value </th>
///                  <th>Meaning </th> </tr> <tr> <td>ACM_DRIVERPRIORITYF_BEGIN</td> <td>Change notification broadcasts should be
///                  deferred. An application must reenable notification broadcasts as soon as possible with the
///                  ACM_DRIVERPRIORITYF_END flag. Note that <i>hadid</i> must be <b>NULL</b>, <i>dwPriority</i> must be zero, and
///                  only the ACM_DRIVERPRIORITYF_BEGIN flag can be set.</td> </tr> <tr> <td>ACM_DRIVERPRIORITYF_DISABLE</td> <td>ACM
///                  driver should be disabled if it is currently enabled. Disabling a disabled driver does nothing.</td> </tr> <tr>
///                  <td>ACM_DRIVERPRIORITYF_ENABLE</td> <td>ACM driver should be enabled if it is currently disabled. Enabling an
///                  enabled driver does nothing.</td> </tr> <tr> <td>ACM_DRIVERPRIORITYF_END</td> <td>Calling task wants to reenable
///                  change notification broadcasts. An application must call <b>acmDriverPriority</b> with ACM_DRIVERPRIORITYF_END
///                  for each successful call with the ACM_DRIVERPRIORITYF_BEGIN flag. Note that <i>hadid</i> must be <b>NULL</b>,
///                  <i>dwPriority</i> must be zero, and only the ACM_DRIVERPRIORITYF_END flag can be set.</td> </tr> </table>
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_ALLOCATED</b></dt>
///    </dl> </td> <td width="60%"> The deferred broadcast lock is owned by a different task. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>MMSYSERR_INVALFLAG</b></dt> </dl> </td> <td width="60%"> At least one flag is invalid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The
///    specified handle is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl>
///    </td> <td width="60%"> At least one parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_NOTSUPPORTED</b></dt> </dl> </td> <td width="60%"> The requested operation is not supported for
///    the specified driver. For example, local and notify driver identifiers do not support priorities (but can be
///    enabled and disabled). If an application specifies a nonzero value for <i>dwPriority</i> for local and notify
///    driver identifiers, this error will be returned. </td> </tr> </table>
///    
@DllImport("MSACM32")
uint acmDriverPriority(HACMDRIVERID__* hadid, uint dwPriority, uint fdwPriority);

///The <b>acmDriverDetails</b> function queries a specified ACM driver to determine its capabilities.
///Params:
///    hadid = Handle to the driver identifier of an installed ACM driver. Disabled drivers can be queried for details.
///    padd = Pointer to an [ACMDRIVERDETAILS](./nf-msacm-acmdriverdetails.md) structure that will receive the driver details.
///           The <b>cbStruct</b> member must be initialized to the size, in bytes, of the structure.
///    fdwDetails = Reserved; must be zero.
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALFLAG</b></dt>
///    </dl> </td> <td width="60%"> At least one flag is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified handle is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%"> At least one
///    parameter is invalid. </td> </tr> </table>
///    
@DllImport("MSACM32")
uint acmDriverDetailsA(HACMDRIVERID__* hadid, tACMDRIVERDETAILSA* padd, uint fdwDetails);

///The <b>acmDriverDetails</b> function queries a specified ACM driver to determine its capabilities.
///Params:
///    hadid = Handle to the driver identifier of an installed ACM driver. Disabled drivers can be queried for details.
///    padd = Pointer to an [ACMDRIVERDETAILS](./nf-msacm-acmdriverdetails.md) structure that will receive the driver details.
///           The <b>cbStruct</b> member must be initialized to the size, in bytes, of the structure.
///    fdwDetails = Reserved; must be zero.
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALFLAG</b></dt>
///    </dl> </td> <td width="60%"> At least one flag is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified handle is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%"> At least one
///    parameter is invalid. </td> </tr> </table>
///    
@DllImport("MSACM32")
uint acmDriverDetailsW(HACMDRIVERID__* hadid, tACMDRIVERDETAILSW* padd, uint fdwDetails);

///The <b>acmFormatTagDetails</b> function queries the ACM for details on a specific waveform-audio format tag.
///Params:
///    had = Handle to the ACM driver to query for waveform-audio format tag details. If this parameter is <b>NULL</b>, the
///          ACM uses the details from the first suitable ACM driver. An application must specify a valid handle or driver
///          identifier when using the ACM_FORMATTAGDETAILSF_INDEX query type. Driver identifiers for disabled drivers are not
///          allowed.
///    paftd = Pointer to the [ACMFORMATTAGDETAILS](./nf-msacm-acmformattagdetails.md) structure that is to receive the format
///            tag details.
///    fdwDetails = Flags for getting the details. The following values are defined. <table> <tr> <th>Value </th> <th>Meaning </th>
///                 </tr> <tr> <td>ACM_FORMATTAGDETAILSF_FORMATTAG</td> [ACMFORMATTAGDETAILS](./nf-msacm-acmformattagdetails.md)
///                 structure. The format tag details will be returned in the structure pointed to by <i>paftd</i>. If an application
///                 specifies an ACM driver handle for <i>had</i>, details on the format tag will be returned for that driver. If an
///                 application specifies <b>NULL</b> for <i>had</i>, the ACM finds the first acceptable driver to return the
///                 details.</td> </tr> <tr> <td>ACM_FORMATTAGDETAILSF_INDEX</td> [ACMDRIVERDETAILS](./nf-msacm-acmdriverdetails.md)
///                 structure for an ACM driver. An application must specify a driver handle for <i>had</i> when retrieving format
///                 tag details with this flag.</td> </tr> <tr> <td>ACM_FORMATTAGDETAILSF_LARGESTSIZE</td>
///                 [ACMFORMATTAGDETAILS](./nf-msacm-acmformattagdetails.md) structure must either be WAVE_FORMAT_UNKNOWN or the
///                 format tag to find the largest size for. If an application specifies an ACM driver handle for <i>had</i>, details
///                 on the largest format tag will be returned for that driver. If an application specifies <b>NULL</b> for
///                 <i>had</i>, the ACM finds an acceptable driver with the largest format tag requested to return the details.</td>
///                 </tr> </table>
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ACMERR_NOTPOSSIBLE</b></dt>
///    </dl> </td> <td width="60%"> The details requested are not available. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALFLAG</b></dt> </dl> </td> <td width="60%"> At least one flag is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified handle is
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%">
///    At least one parameter is invalid. </td> </tr> </table>
///    
@DllImport("MSACM32")
uint acmFormatTagDetailsA(HACMDRIVER__* had, tACMFORMATTAGDETAILSA* paftd, uint fdwDetails);

///The <b>acmFormatTagDetails</b> function queries the ACM for details on a specific waveform-audio format tag.
///Params:
///    had = Handle to the ACM driver to query for waveform-audio format tag details. If this parameter is <b>NULL</b>, the
///          ACM uses the details from the first suitable ACM driver. An application must specify a valid handle or driver
///          identifier when using the ACM_FORMATTAGDETAILSF_INDEX query type. Driver identifiers for disabled drivers are not
///          allowed.
///    paftd = Pointer to the [ACMFORMATTAGDETAILS](./nf-msacm-acmformattagdetails.md) structure that is to receive the format
///            tag details.
///    fdwDetails = Flags for getting the details. The following values are defined. <table> <tr> <th>Value </th> <th>Meaning </th>
///                 </tr> <tr> <td>ACM_FORMATTAGDETAILSF_FORMATTAG</td> [ACMFORMATTAGDETAILS](./nf-msacm-acmformattagdetails.md)
///                 structure. The format tag details will be returned in the structure pointed to by <i>paftd</i>. If an application
///                 specifies an ACM driver handle for <i>had</i>, details on the format tag will be returned for that driver. If an
///                 application specifies <b>NULL</b> for <i>had</i>, the ACM finds the first acceptable driver to return the
///                 details.</td> </tr> <tr> <td>ACM_FORMATTAGDETAILSF_INDEX</td> [ACMDRIVERDETAILS](./nf-msacm-acmdriverdetails.md)
///                 structure for an ACM driver. An application must specify a driver handle for <i>had</i> when retrieving format
///                 tag details with this flag.</td> </tr> <tr> <td>ACM_FORMATTAGDETAILSF_LARGESTSIZE</td>
///                 [ACMFORMATTAGDETAILS](./nf-msacm-acmformattagdetails.md) structure must either be WAVE_FORMAT_UNKNOWN or the
///                 format tag to find the largest size for. If an application specifies an ACM driver handle for <i>had</i>, details
///                 on the largest format tag will be returned for that driver. If an application specifies <b>NULL</b> for
///                 <i>had</i>, the ACM finds an acceptable driver with the largest format tag requested to return the details.</td>
///                 </tr> </table>
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ACMERR_NOTPOSSIBLE</b></dt>
///    </dl> </td> <td width="60%"> The details requested are not available. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALFLAG</b></dt> </dl> </td> <td width="60%"> At least one flag is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified handle is
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%">
///    At least one parameter is invalid. </td> </tr> </table>
///    
@DllImport("MSACM32")
uint acmFormatTagDetailsW(HACMDRIVER__* had, tACMFORMATTAGDETAILSW* paftd, uint fdwDetails);

///The <b>acmFormatTagEnum</b> function enumerates waveform-audio format tags available from an ACM driver. This
///function continues enumerating until there are no more suitable format tags or the callback function returns
///<b>FALSE</b>.
///Params:
///    had = Handle to the ACM driver to query for waveform-audio format tag details. If this parameter is <b>NULL</b>, the
///          ACM uses the details from the first suitable ACM driver.
///    paftd = Pointer to the [ACMFORMATTAGDETAILS](./nf-msacm-acmformattagdetails.md) structure that is to receive the format
///            tag details passed to the function specified in <i>fnCallback</i>. This structure must have the <b>cbStruct</b>
///            member of the <b>ACMFORMATTAGDETAILS</b> structure initialized.
///    fnCallback = Procedure instance address of the application-defined callback function.
///    dwInstance = A 64-bit (DWORD_PTR) or 32-bit (DWORD) application-defined value that is passed to the callback function along
///                 with ACM format tag details.
///    fdwEnum = Reserved; must be zero.
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALFLAG</b></dt>
///    </dl> </td> <td width="60%"> At least one flag is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified handle is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%"> At least one
///    parameter is invalid. </td> </tr> </table>
///    
@DllImport("MSACM32")
uint acmFormatTagEnumA(HACMDRIVER__* had, tACMFORMATTAGDETAILSA* paftd, ACMFORMATTAGENUMCBA fnCallback, 
                       size_t dwInstance, uint fdwEnum);

///The <b>acmFormatTagEnum</b> function enumerates waveform-audio format tags available from an ACM driver. This
///function continues enumerating until there are no more suitable format tags or the callback function returns
///<b>FALSE</b>.
///Params:
///    had = Handle to the ACM driver to query for waveform-audio format tag details. If this parameter is <b>NULL</b>, the
///          ACM uses the details from the first suitable ACM driver.
///    paftd = Pointer to the [ACMFORMATTAGDETAILS](./nf-msacm-acmformattagdetails.md) structure that is to receive the format
///            tag details passed to the function specified in <i>fnCallback</i>. This structure must have the <b>cbStruct</b>
///            member of the <b>ACMFORMATTAGDETAILS</b> structure initialized.
///    fnCallback = Procedure instance address of the application-defined callback function.
///    dwInstance = A 64-bit (DWORD_PTR) or 32-bit (DWORD) application-defined value that is passed to the callback function along
///                 with ACM format tag details.
///    fdwEnum = Reserved; must be zero.
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALFLAG</b></dt>
///    </dl> </td> <td width="60%"> At least one flag is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified handle is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%"> At least one
///    parameter is invalid. </td> </tr> </table>
///    
@DllImport("MSACM32")
uint acmFormatTagEnumW(HACMDRIVER__* had, tACMFORMATTAGDETAILSW* paftd, ACMFORMATTAGENUMCBW fnCallback, 
                       size_t dwInstance, uint fdwEnum);

///The <b>acmFormatDetails</b> function queries the ACM for format details for a specific waveform-audio format tag.
///Params:
///    had = Handle to the ACM driver to query for waveform-audio format details for a format tag. If this parameter is
///          <b>NULL</b>, the ACM uses the details from the first suitable ACM driver.
///    pafd = Pointer to an [ACMFORMATDETAILS](./nf-msacm-acmformatdetails.md) structure to contain the format details for the
///           given format tag.
///    fdwDetails = Flags for getting the waveform-audio format tag details. The following values are defined. <table> <tr> <th>Value
///                 </th> <th>Meaning </th> </tr> <tr> <td>ACM_FORMATDETAILSF_FORMAT</td>
///                 [ACMFORMATDETAILS](./nf-msacm-acmformatdetails.md) structure was given and the remaining details should be
///                 returned. The <b>dwFormatTag</b> member of the <b>ACMFORMATDETAILS</b> structure must be initialized to the same
///                 format tag as <b>pwfx</b> specifies. This query type can be used to get a string description of an arbitrary
///                 format structure. If an application specifies an ACM driver handle for <i>had</i>, details on the format will be
///                 returned for that driver. If an application specifies <b>NULL</b> for <i>had</i>, the ACM finds the first
///                 acceptable driver to return the details.</td> </tr> <tr> <td>ACM_FORMATDETAILSF_INDEX</td> <td>A format index for
///                 the format tag was given in the <b>dwFormatIndex</b> member of the <b>ACMFORMATDETAILS</b> structure. The format
///                 details will be returned in the structure defined by <i>pafd</i>. The index ranges from zero to one less than the
///                 <b>cStandardFormats</b> member returned in the <b>ACMFORMATTAGDETAILS</b> structure for a format tag. An
///                 application must specify a driver handle for <i>had</i> when retrieving format details with this flag. For
///                 information about which members should be initialized before calling this function, see the
///                 <b>ACMFORMATDETAILS</b> structure.</td> </tr> </table>
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ACMERR_NOTPOSSIBLE</b></dt>
///    </dl> </td> <td width="60%"> The details requested are not available. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALFLAG</b></dt> </dl> </td> <td width="60%"> At least one flag is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified handle is
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%">
///    At least one parameter is invalid. </td> </tr> </table>
///    
@DllImport("MSACM32")
uint acmFormatDetailsA(HACMDRIVER__* had, tACMFORMATDETAILSA* pafd, uint fdwDetails);

///The <b>acmFormatDetails</b> function queries the ACM for format details for a specific waveform-audio format tag.
///Params:
///    had = Handle to the ACM driver to query for waveform-audio format details for a format tag. If this parameter is
///          <b>NULL</b>, the ACM uses the details from the first suitable ACM driver.
///    pafd = Pointer to an [ACMFORMATDETAILS](./nf-msacm-acmformatdetails.md) structure to contain the format details for the
///           given format tag.
///    fdwDetails = Flags for getting the waveform-audio format tag details. The following values are defined. <table> <tr> <th>Value
///                 </th> <th>Meaning </th> </tr> <tr> <td>ACM_FORMATDETAILSF_FORMAT</td>
///                 [ACMFORMATDETAILS](./nf-msacm-acmformatdetails.md) structure was given and the remaining details should be
///                 returned. The <b>dwFormatTag</b> member of the <b>ACMFORMATDETAILS</b> structure must be initialized to the same
///                 format tag as <b>pwfx</b> specifies. This query type can be used to get a string description of an arbitrary
///                 format structure. If an application specifies an ACM driver handle for <i>had</i>, details on the format will be
///                 returned for that driver. If an application specifies <b>NULL</b> for <i>had</i>, the ACM finds the first
///                 acceptable driver to return the details.</td> </tr> <tr> <td>ACM_FORMATDETAILSF_INDEX</td> <td>A format index for
///                 the format tag was given in the <b>dwFormatIndex</b> member of the <b>ACMFORMATDETAILS</b> structure. The format
///                 details will be returned in the structure defined by <i>pafd</i>. The index ranges from zero to one less than the
///                 <b>cStandardFormats</b> member returned in the <b>ACMFORMATTAGDETAILS</b> structure for a format tag. An
///                 application must specify a driver handle for <i>had</i> when retrieving format details with this flag. For
///                 information about which members should be initialized before calling this function, see the
///                 <b>ACMFORMATDETAILS</b> structure.</td> </tr> </table>
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ACMERR_NOTPOSSIBLE</b></dt>
///    </dl> </td> <td width="60%"> The details requested are not available. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALFLAG</b></dt> </dl> </td> <td width="60%"> At least one flag is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified handle is
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%">
///    At least one parameter is invalid. </td> </tr> </table>
///    
@DllImport("MSACM32")
uint acmFormatDetailsW(HACMDRIVER__* had, tACMFORMATDETAILSW* pafd, uint fdwDetails);

///The <b>acmFormatEnum</b> function enumerates waveform-audio formats available for a given format tag from an ACM
///driver. This function continues enumerating until there are no more suitable formats for the format tag or the
///callback function returns <b>FALSE</b>.
///Params:
///    had = Handle to the ACM driver to query for waveform-audio format details. If this parameter is <b>NULL</b>, the ACM
///          uses the details from the first suitable ACM driver.
///    pafd = Pointer to an [ACMFORMATDETAILS](./nf-msacm-acmformatdetails.md) structure to contain the format details passed
///           to the <b>fnCallback</b> function. This structure must have the <b>cbStruct</b>, <b>pwfx</b>, and <b>cbwfx</b>
///           members of the <b>ACMFORMATDETAILS</b> structure initialized. The <b>dwFormatTag</b> member must also be
///           initialized to either WAVE_FORMAT_UNKNOWN or a valid format tag. The <b>fdwSupport</b> member of the structure
///           must be initialized to zero. To find the required size of the <b>pwfx</b> buffer, call acmMetrics with the
///           ACM_METRIC_MAX_SIZE_FORMAT flag.
///    fnCallback = Address of an application-defined callback function. See acmFormatEnumCallback. This parameter cannot be
///                 <b>NULL</b>.
///    dwInstance = A 64-bit (DWORD_PTR) or 32-bit (DWORD) application-defined value that is passed to the callback function along
///                 with ACM format details.
///    fdwEnum = Flags for enumerating the formats for a given format tag. The following values are defined. <table> <tr>
///              <th>Value </th> <th>Meaning </th> </tr> <tr> <td>ACM_FORMATENUMF_CONVERT</td>
///              [ACMFORMATDETAILS](./nf-msacm-acmformatdetails.md) structure is valid. The enumerator will only enumerate
///              destination formats that can be converted from the given <b>pwfx</b> format.If this flag is used, the
///              <b>wFormatTag</b> member of the <b>WAVEFORMATEX</b> structure cannot be WAVE_FORMAT_UNKNOWN. </td> </tr> <tr>
///              <td>ACM_FORMATENUMF_HARDWARE</td> <td>The enumerator should only enumerate formats that are supported as native
///              input or output formats on one or more of the installed waveform-audio devices. This flag provides a way for an
///              application to choose only formats native to an installed waveform-audio device. This flag must be used with one
///              or both of the ACM_FORMATENUMF_INPUT and ACM_FORMATENUMF_OUTPUT flags. Specifying both ACM_FORMATENUMF_INPUT and
///              ACM_FORMATENUMF_OUTPUT will enumerate only formats that can be opened for input or output. This is true
///              regardless of whether this flag is specified.</td> </tr> <tr> <td>ACM_FORMATENUMF_INPUT</td> <td>Enumerator
///              should enumerate only formats that are supported for input (recording).</td> </tr> <tr>
///              <td>ACM_FORMATENUMF_NCHANNELS</td> [ACMFORMATDETAILS](./nf-msacm-acmformatdetails.md) structure is valid. The
///              enumerator will enumerate only a format that conforms to this attribute.</td> </tr> <tr>
///              <td>ACM_FORMATENUMF_NSAMPLESPERSEC</td> <td>The <b>nSamplesPerSec</b> member of the <b>WAVEFORMATEX</b> structure
///              pointed to by the <b>pwfx</b> member of the <b>ACMFORMATDETAILS</b> structure is valid. The enumerator will
///              enumerate only a format that conforms to this attribute.</td> </tr> <tr> <td>ACM_FORMATENUMF_OUTPUT</td>
///              <td>Enumerator should enumerate only formats that are supported for output (playback).</td> </tr> <tr>
///              <td>ACM_FORMATENUMF_SUGGEST</td> [ACMFORMATDETAILS](./nf-msacm-acmformatdetails.md) structure is valid. The
///              enumerator will enumerate all suggested destination formats for the given <b>pwfx</b> format. This mechanism can
///              be used instead of the acmFormatSuggest function to allow an application to choose the best suggested format for
///              conversion. The <b>dwFormatIndex</b> member will always be set to zero on return.If this flag is used, the
///              <b>wFormatTag</b> member of the <b>WAVEFORMATEX</b> structure cannot be WAVE_FORMAT_UNKNOWN. </td> </tr> <tr>
///              <td>ACM_FORMATENUMF_WBITSPERSAMPLE</td> <td>The <b>wBitsPerSample</b> member of the <b>WAVEFORMATEX</b> structure
///              pointed to by the <b>pwfx</b> member of the <b>ACMFORMATDETAILS</b> structure is valid. The enumerator will
///              enumerate only a format that conforms to this attribute.</td> </tr> <tr> <td>ACM_FORMATENUMF_WFORMATTAG</td>
///              <td>The <b>wFormatTag</b> member of the <b>WAVEFORMATEX</b> structure pointed to by the <b>pwfx</b> member of the
///              <b>ACMFORMATDETAILS</b> structure is valid. The enumerator will enumerate only a format that conforms to this
///              attribute. The <b>dwFormatTag</b> member of the <b>ACMFORMATDETAILS</b> structure must be equal to the
///              <b>wFormatTag</b> member.The value of <b>wFormatTag</b> cannot be WAVE_FORMAT_UNKNOWN in this case. </td> </tr>
///              </table>
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ACMERR_NOTPOSSIBLE</b></dt>
///    </dl> </td> <td width="60%"> The details for the format cannot be returned. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>MMSYSERR_INVALFLAG</b></dt> </dl> </td> <td width="60%"> At least one flag is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified handle
///    is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td
///    width="60%"> At least one parameter is invalid. </td> </tr> </table>
///    
@DllImport("MSACM32")
uint acmFormatEnumA(HACMDRIVER__* had, tACMFORMATDETAILSA* pafd, ACMFORMATENUMCBA fnCallback, size_t dwInstance, 
                    uint fdwEnum);

///The <b>acmFormatEnum</b> function enumerates waveform-audio formats available for a given format tag from an ACM
///driver. This function continues enumerating until there are no more suitable formats for the format tag or the
///callback function returns <b>FALSE</b>.
///Params:
///    had = Handle to the ACM driver to query for waveform-audio format details. If this parameter is <b>NULL</b>, the ACM
///          uses the details from the first suitable ACM driver.
///    pafd = Pointer to an [ACMFORMATDETAILS](./nf-msacm-acmformatdetails.md) structure to contain the format details passed
///           to the <b>fnCallback</b> function. This structure must have the <b>cbStruct</b>, <b>pwfx</b>, and <b>cbwfx</b>
///           members of the <b>ACMFORMATDETAILS</b> structure initialized. The <b>dwFormatTag</b> member must also be
///           initialized to either WAVE_FORMAT_UNKNOWN or a valid format tag. The <b>fdwSupport</b> member of the structure
///           must be initialized to zero. To find the required size of the <b>pwfx</b> buffer, call acmMetrics with the
///           ACM_METRIC_MAX_SIZE_FORMAT flag.
///    fnCallback = Address of an application-defined callback function. See acmFormatEnumCallback. This parameter cannot be
///                 <b>NULL</b>.
///    dwInstance = A 64-bit (DWORD_PTR) or 32-bit (DWORD) application-defined value that is passed to the callback function along
///                 with ACM format details.
///    fdwEnum = Flags for enumerating the formats for a given format tag. The following values are defined. <table> <tr>
///              <th>Value </th> <th>Meaning </th> </tr> <tr> <td>ACM_FORMATENUMF_CONVERT</td>
///              [ACMFORMATDETAILS](./nf-msacm-acmformatdetails.md) structure is valid. The enumerator will only enumerate
///              destination formats that can be converted from the given <b>pwfx</b> format.If this flag is used, the
///              <b>wFormatTag</b> member of the <b>WAVEFORMATEX</b> structure cannot be WAVE_FORMAT_UNKNOWN. </td> </tr> <tr>
///              <td>ACM_FORMATENUMF_HARDWARE</td> <td>The enumerator should only enumerate formats that are supported as native
///              input or output formats on one or more of the installed waveform-audio devices. This flag provides a way for an
///              application to choose only formats native to an installed waveform-audio device. This flag must be used with one
///              or both of the ACM_FORMATENUMF_INPUT and ACM_FORMATENUMF_OUTPUT flags. Specifying both ACM_FORMATENUMF_INPUT and
///              ACM_FORMATENUMF_OUTPUT will enumerate only formats that can be opened for input or output. This is true
///              regardless of whether this flag is specified.</td> </tr> <tr> <td>ACM_FORMATENUMF_INPUT</td> <td>Enumerator
///              should enumerate only formats that are supported for input (recording).</td> </tr> <tr>
///              <td>ACM_FORMATENUMF_NCHANNELS</td> [ACMFORMATDETAILS](./nf-msacm-acmformatdetails.md) structure is valid. The
///              enumerator will enumerate only a format that conforms to this attribute.</td> </tr> <tr>
///              <td>ACM_FORMATENUMF_NSAMPLESPERSEC</td> <td>The <b>nSamplesPerSec</b> member of the <b>WAVEFORMATEX</b> structure
///              pointed to by the <b>pwfx</b> member of the <b>ACMFORMATDETAILS</b> structure is valid. The enumerator will
///              enumerate only a format that conforms to this attribute.</td> </tr> <tr> <td>ACM_FORMATENUMF_OUTPUT</td>
///              <td>Enumerator should enumerate only formats that are supported for output (playback).</td> </tr> <tr>
///              <td>ACM_FORMATENUMF_SUGGEST</td> [ACMFORMATDETAILS](./nf-msacm-acmformatdetails.md) structure is valid. The
///              enumerator will enumerate all suggested destination formats for the given <b>pwfx</b> format. This mechanism can
///              be used instead of the acmFormatSuggest function to allow an application to choose the best suggested format for
///              conversion. The <b>dwFormatIndex</b> member will always be set to zero on return.If this flag is used, the
///              <b>wFormatTag</b> member of the <b>WAVEFORMATEX</b> structure cannot be WAVE_FORMAT_UNKNOWN. </td> </tr> <tr>
///              <td>ACM_FORMATENUMF_WBITSPERSAMPLE</td> <td>The <b>wBitsPerSample</b> member of the <b>WAVEFORMATEX</b> structure
///              pointed to by the <b>pwfx</b> member of the <b>ACMFORMATDETAILS</b> structure is valid. The enumerator will
///              enumerate only a format that conforms to this attribute.</td> </tr> <tr> <td>ACM_FORMATENUMF_WFORMATTAG</td>
///              <td>The <b>wFormatTag</b> member of the <b>WAVEFORMATEX</b> structure pointed to by the <b>pwfx</b> member of the
///              <b>ACMFORMATDETAILS</b> structure is valid. The enumerator will enumerate only a format that conforms to this
///              attribute. The <b>dwFormatTag</b> member of the <b>ACMFORMATDETAILS</b> structure must be equal to the
///              <b>wFormatTag</b> member.The value of <b>wFormatTag</b> cannot be WAVE_FORMAT_UNKNOWN in this case. </td> </tr>
///              </table>
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ACMERR_NOTPOSSIBLE</b></dt>
///    </dl> </td> <td width="60%"> The details for the format cannot be returned. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>MMSYSERR_INVALFLAG</b></dt> </dl> </td> <td width="60%"> At least one flag is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified handle
///    is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td
///    width="60%"> At least one parameter is invalid. </td> </tr> </table>
///    
@DllImport("MSACM32")
uint acmFormatEnumW(HACMDRIVER__* had, tACMFORMATDETAILSW* pafd, ACMFORMATENUMCBW fnCallback, size_t dwInstance, 
                    uint fdwEnum);

///The <b>acmFormatSuggest</b> function queries the ACM or a specified ACM driver to suggest a destination format for
///the supplied source format. For example, an application can use this function to determine one or more valid PCM
///formats to which a compressed format can be decompressed.
///Params:
///    had = Handle to an open instance of a driver to query for a suggested destination format. If this parameter is
///          <b>NULL</b>, the ACM attempts to find the best driver to suggest a destination format.
///    pwfxSrc = Pointer to a WAVEFORMATEX structure that identifies the source format for which a destination format will be
///              suggested by the ACM or specified driver.
///    pwfxDst = Pointer to a WAVEFORMATEX structure that will receive the suggested destination format for the <i>pwfxSrc</i>
///              format. Depending on the <i>fdwSuggest</i> parameter, some members of the structure pointed to by <i>pwfxDst</i>
///              may require initialization.
///    cbwfxDst = Size, in bytes, available for the destination format. The acmMetrics and acmFormatTagDetails functions can be
///               used to determine the maximum size required for any format available for the specified driver (or for all
///               installed ACM drivers).
///    fdwSuggest = Flags for matching the desired destination format. The following values are defined. <table> <tr> <th>Value </th>
///                 <th>Meaning </th> </tr> <tr> <td>ACM_FORMATSUGGESTF_NCHANNELS</td> <td>The <b>nChannels</b> member of the
///                 structure pointed to by <i>pwfxDst</i> is valid. The ACM will query acceptable installed drivers that can suggest
///                 a destination format matching <b>nChannels</b> or fail.</td> </tr> <tr>
///                 <td>ACM_FORMATSUGGESTF_NSAMPLESPERSEC</td> <td>The <b>nSamplesPerSec</b> member of the structure pointed to by
///                 <i>pwfxDst</i> is valid. The ACM will query acceptable installed drivers that can suggest a destination format
///                 matching <b>nSamplesPerSec</b> or fail.</td> </tr> <tr> <td>ACM_FORMATSUGGESTF_WBITSPERSAMPLE</td> <td>The
///                 <b>wBitsPerSample</b> member of the structure pointed to by <i>pwfxDst</i> is valid. The ACM will query
///                 acceptable installed drivers that can suggest a destination format matching <b>wBitsPerSample</b> or fail.</td>
///                 </tr> <tr> <td>ACM_FORMATSUGGESTF_WFORMATTAG</td> <td>The <b>wFormatTag</b> member of the structure pointed to by
///                 <i>pwfxDst</i> is valid. The ACM will query acceptable installed drivers that can suggest a destination format
///                 matching <b>wFormatTag</b> or fail.</td> </tr> </table>
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALFLAG</b></dt>
///    </dl> </td> <td width="60%"> At least one flag is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified handle is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%"> At least one
///    parameter is invalid. </td> </tr> </table>
///    
@DllImport("MSACM32")
uint acmFormatSuggest(HACMDRIVER__* had, WAVEFORMATEX* pwfxSrc, WAVEFORMATEX* pwfxDst, uint cbwfxDst, 
                      uint fdwSuggest);

///The <b>acmFormatChoose</b> function creates an ACM-defined dialog box that enables the user to select a
///waveform-audio format.
///Params:
///    pafmtc = Pointer to an [ACMFORMATCHOOSE](./nf-msacm-acmformatchoose.md) structure that contains information used to
///             initialize the dialog box. When this function returns, this structure contains information about the user's
///             format selection. The <b>pwfx</b> member of this structure must contain a valid pointer to a memory location that
///             will contain the returned format header structure. Moreover, the <b>cbwfx</b> member must be filled in with the
///             size, in bytes, of this memory buffer.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible return values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ACMERR_CANCELED</b></dt> </dl> </td> <td width="60%"> The user chose the Cancel button or the Close
///    command on the System menu to close the dialog box. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ACMERR_NOTPOSSIBLE</b></dt> </dl> </td> <td width="60%"> The buffer identified by the <b>pwfx</b> member
///    of the <b>ACMFORMATCHOOSE</b> structure is too small to contain the selected format. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>MMSYSERR_INVALFLAG</b></dt> </dl> </td> <td width="60%"> At least one flag is invalid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The
///    specified handle is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl>
///    </td> <td width="60%"> At least one parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> A suitable driver is not available to provide
///    valid format selections. </td> </tr> </table>
///    
@DllImport("MSACM32")
uint acmFormatChooseA(tACMFORMATCHOOSEA* pafmtc);

///The <b>acmFormatChoose</b> function creates an ACM-defined dialog box that enables the user to select a
///waveform-audio format.
///Params:
///    pafmtc = Pointer to an [ACMFORMATCHOOSE](./nf-msacm-acmformatchoose.md) structure that contains information used to
///             initialize the dialog box. When this function returns, this structure contains information about the user's
///             format selection. The <b>pwfx</b> member of this structure must contain a valid pointer to a memory location that
///             will contain the returned format header structure. Moreover, the <b>cbwfx</b> member must be filled in with the
///             size, in bytes, of this memory buffer.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible return values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ACMERR_CANCELED</b></dt> </dl> </td> <td width="60%"> The user chose the Cancel button or the Close
///    command on the System menu to close the dialog box. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ACMERR_NOTPOSSIBLE</b></dt> </dl> </td> <td width="60%"> The buffer identified by the <b>pwfx</b> member
///    of the <b>ACMFORMATCHOOSE</b> structure is too small to contain the selected format. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>MMSYSERR_INVALFLAG</b></dt> </dl> </td> <td width="60%"> At least one flag is invalid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The
///    specified handle is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl>
///    </td> <td width="60%"> At least one parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> A suitable driver is not available to provide
///    valid format selections. </td> </tr> </table>
///    
@DllImport("MSACM32")
uint acmFormatChooseW(tACMFORMATCHOOSEW* pafmtc);

///The <b>acmFilterTagDetails</b> function queries the ACM for details about a specific waveform-audio filter tag.
///Params:
///    had = Handle to the ACM driver to query for waveform-audio filter tag details. If this parameter is <b>NULL</b>, the
///          ACM uses the details from the first suitable ACM driver. An application must specify a valid <b>HACMDRIVER</b> or
///          <b>HACMDRIVERID</b> identifier when using the ACM_FILTERTAGDETAILSF_INDEX query type. Driver identifiers for
///          disabled drivers are not allowed.
///    paftd = Pointer to the [ACMFILTERTAGDETAILS](./nf-msacm-acmfiltertagdetails.md) structure that is to receive the filter
///            tag details.
///    fdwDetails = Flags for getting the details. The following values are defined. <table> <tr> <th>Value </th> <th>Meaning </th>
///                 </tr> <tr> <td>ACM_FILTERTAGDETAILSF_FILTERTAG</td> [ACMFILTERTAGDETAILS](./nf-msacm-acmfiltertagdetails.md)
///                 structure. The filter tag details will be returned in the structure pointed to by <i>paftd</i>. If an application
///                 specifies an ACM driver handle for <i>had</i>, details on the filter tag will be returned for that driver. If an
///                 application specifies <b>NULL</b> for <i>had</i>, the ACM finds the first acceptable driver to return the
///                 details.</td> </tr> <tr> <td>ACM_FILTERTAGDETAILSF_INDEX</td> [ACMDRIVERDETAILS](./nf-msacm-acmdriverdetails.md)
///                 structure for an ACM driver. An application must specify a driver handle for <i>had</i> when retrieving filter
///                 tag details with this flag.</td> </tr> <tr> <td>ACM_FILTERTAGDETAILSF_LARGESTSIZE</td> <td>Details on the filter
///                 tag with the largest filter size, in bytes, are to be returned. The <b>dwFilterTag</b> member must either be
///                 WAVE_FILTER_UNKNOWN or the filter tag to find the largest size for. If an application specifies an ACM driver
///                 handle for <i>had</i>, details on the largest filter tag will be returned for that driver. If an application
///                 specifies <b>NULL</b> for <i>had</i>, the ACM finds an acceptable driver with the largest filter tag requested to
///                 return the details.</td> </tr> </table>
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ACMERR_NOTPOSSIBLE</b></dt>
///    </dl> </td> <td width="60%"> The details requested are not available. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALFLAG</b></dt> </dl> </td> <td width="60%"> At least one flag is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified handle is
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%">
///    At least one parameter is invalid. </td> </tr> </table>
///    
@DllImport("MSACM32")
uint acmFilterTagDetailsA(HACMDRIVER__* had, tACMFILTERTAGDETAILSA* paftd, uint fdwDetails);

///The <b>acmFilterTagDetails</b> function queries the ACM for details about a specific waveform-audio filter tag.
///Params:
///    had = Handle to the ACM driver to query for waveform-audio filter tag details. If this parameter is <b>NULL</b>, the
///          ACM uses the details from the first suitable ACM driver. An application must specify a valid <b>HACMDRIVER</b> or
///          <b>HACMDRIVERID</b> identifier when using the ACM_FILTERTAGDETAILSF_INDEX query type. Driver identifiers for
///          disabled drivers are not allowed.
///    paftd = Pointer to the [ACMFILTERTAGDETAILS](./nf-msacm-acmfiltertagdetails.md) structure that is to receive the filter
///            tag details.
///    fdwDetails = Flags for getting the details. The following values are defined. <table> <tr> <th>Value </th> <th>Meaning </th>
///                 </tr> <tr> <td>ACM_FILTERTAGDETAILSF_FILTERTAG</td> [ACMFILTERTAGDETAILS](./nf-msacm-acmfiltertagdetails.md)
///                 structure. The filter tag details will be returned in the structure pointed to by <i>paftd</i>. If an application
///                 specifies an ACM driver handle for <i>had</i>, details on the filter tag will be returned for that driver. If an
///                 application specifies <b>NULL</b> for <i>had</i>, the ACM finds the first acceptable driver to return the
///                 details.</td> </tr> <tr> <td>ACM_FILTERTAGDETAILSF_INDEX</td> [ACMDRIVERDETAILS](./nf-msacm-acmdriverdetails.md)
///                 structure for an ACM driver. An application must specify a driver handle for <i>had</i> when retrieving filter
///                 tag details with this flag.</td> </tr> <tr> <td>ACM_FILTERTAGDETAILSF_LARGESTSIZE</td> <td>Details on the filter
///                 tag with the largest filter size, in bytes, are to be returned. The <b>dwFilterTag</b> member must either be
///                 WAVE_FILTER_UNKNOWN or the filter tag to find the largest size for. If an application specifies an ACM driver
///                 handle for <i>had</i>, details on the largest filter tag will be returned for that driver. If an application
///                 specifies <b>NULL</b> for <i>had</i>, the ACM finds an acceptable driver with the largest filter tag requested to
///                 return the details.</td> </tr> </table>
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ACMERR_NOTPOSSIBLE</b></dt>
///    </dl> </td> <td width="60%"> The details requested are not available. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALFLAG</b></dt> </dl> </td> <td width="60%"> At least one flag is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified handle is
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%">
///    At least one parameter is invalid. </td> </tr> </table>
///    
@DllImport("MSACM32")
uint acmFilterTagDetailsW(HACMDRIVER__* had, tACMFILTERTAGDETAILSW* paftd, uint fdwDetails);

///The <b>acmFilterTagEnum</b> function enumerates waveform-audio filter tags available from an ACM driver. This
///function continues enumerating until there are no more suitable filter tags or the callback function returns
///<b>FALSE</b>.
///Params:
///    had = Handle to the ACM driver to query for waveform-audio filter tag details. If this parameter is <b>NULL</b>, the
///          ACM uses the details from the first suitable ACM driver.
///    paftd = Pointer to the [ACMFILTERTAGDETAILS](./nf-msacm-acmfiltertagdetails.md) structure that contains the filter tag
///            details when it is passed to the <b>fnCallback</b> function. When your application calls <b>acmFilterTagEnum</b>,
///            the <b>cbStruct</b> member of this structure must be initialized.
///    fnCallback = Procedure instance address of the application-defined callback function.
///    dwInstance = A 64-bit (DWORD_PTR) or 32-bit (DWORD) application-defined value that is passed to the callback function along
///                 with ACM filter tag details.
///    fdwEnum = Reserved; must be zero.
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALFLAG</b></dt>
///    </dl> </td> <td width="60%"> At least one flag is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified handle is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%"> At least one
///    parameter is invalid. </td> </tr> </table>
///    
@DllImport("MSACM32")
uint acmFilterTagEnumA(HACMDRIVER__* had, tACMFILTERTAGDETAILSA* paftd, ACMFILTERTAGENUMCBA fnCallback, 
                       size_t dwInstance, uint fdwEnum);

///The <b>acmFilterTagEnum</b> function enumerates waveform-audio filter tags available from an ACM driver. This
///function continues enumerating until there are no more suitable filter tags or the callback function returns
///<b>FALSE</b>.
///Params:
///    had = Handle to the ACM driver to query for waveform-audio filter tag details. If this parameter is <b>NULL</b>, the
///          ACM uses the details from the first suitable ACM driver.
///    paftd = Pointer to the [ACMFILTERTAGDETAILS](./nf-msacm-acmfiltertagdetails.md) structure that contains the filter tag
///            details when it is passed to the <b>fnCallback</b> function. When your application calls <b>acmFilterTagEnum</b>,
///            the <b>cbStruct</b> member of this structure must be initialized.
///    fnCallback = Procedure instance address of the application-defined callback function.
///    dwInstance = A 64-bit (DWORD_PTR) or 32-bit (DWORD) application-defined value that is passed to the callback function along
///                 with ACM filter tag details.
///    fdwEnum = Reserved; must be zero.
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALFLAG</b></dt>
///    </dl> </td> <td width="60%"> At least one flag is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified handle is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%"> At least one
///    parameter is invalid. </td> </tr> </table>
///    
@DllImport("MSACM32")
uint acmFilterTagEnumW(HACMDRIVER__* had, tACMFILTERTAGDETAILSW* paftd, ACMFILTERTAGENUMCBW fnCallback, 
                       size_t dwInstance, uint fdwEnum);

///The <b>acmFilterDetails</b> function queries the ACM for details about a filter with a specific waveform-audio filter
///tag.
///Params:
///    had = Handle to the ACM driver to query for waveform-audio filter details for a filter tag. If this parameter is
///          <b>NULL</b>, the ACM uses the details from the first suitable ACM driver.
///    pafd = Pointer to the [ACMFILTERDETAILS](./nf-msacm-acmfilterdetails.md) structure that is to receive the filter details
///           for the given filter tag.
///    fdwDetails = Flags for getting the details. The following values are defined. <table> <tr> <th>Value </th> <th>Meaning </th>
///                 </tr> <tr> <td>ACM_FILTERDETAILSF_FILTER</td> [ACMFILTERDETAILS](./nf-msacm-acmfilterdetails.md) structure was
///                 given and the remaining details should be returned. The <b>dwFilterTag</b> member of the <b>ACMFILTERDETAILS</b>
///                 structure must be initialized to the same filter tag <b>pwfltr</b> specifies. This query type can be used to get
///                 a string description of an arbitrary filter structure. If an application specifies an ACM driver handle for
///                 <i>had</i>, details on the filter will be returned for that driver. If an application specifies <b>NULL</b> for
///                 <i>had</i>, the ACM finds the first acceptable driver to return the details.</td> </tr> <tr>
///                 <td>ACM_FILTERDETAILSF_INDEX</td> <td>A filter index for the filter tag was given in the <b>dwFilterIndex</b>
///                 member of the <b>ACMFILTERDETAILS</b> structure. The filter details will be returned in the structure defined by
///                 <i>pafd</i>. The index ranges from zero to one less than the <b>cStandardFilters</b> member returned in the
///                 <b>ACMFILTERTAGDETAILS</b> structure for a filter tag. An application must specify a driver handle for <i>had</i>
///                 when retrieving filter details with this flag. For information about what members should be initialized before
///                 calling this function, see the <b>ACMFILTERDETAILS</b> structure.</td> </tr> </table>
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ACMERR_NOTPOSSIBLE</b></dt>
///    </dl> </td> <td width="60%"> The details requested are not available. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALFLAG</b></dt> </dl> </td> <td width="60%"> At least one flag is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified handle is
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%">
///    At least one parameter is invalid. </td> </tr> </table>
///    
@DllImport("MSACM32")
uint acmFilterDetailsA(HACMDRIVER__* had, tACMFILTERDETAILSA* pafd, uint fdwDetails);

///The <b>acmFilterDetails</b> function queries the ACM for details about a filter with a specific waveform-audio filter
///tag.
///Params:
///    had = Handle to the ACM driver to query for waveform-audio filter details for a filter tag. If this parameter is
///          <b>NULL</b>, the ACM uses the details from the first suitable ACM driver.
///    pafd = Pointer to the [ACMFILTERDETAILS](./nf-msacm-acmfilterdetails.md) structure that is to receive the filter details
///           for the given filter tag.
///    fdwDetails = Flags for getting the details. The following values are defined. <table> <tr> <th>Value </th> <th>Meaning </th>
///                 </tr> <tr> <td>ACM_FILTERDETAILSF_FILTER</td> [ACMFILTERDETAILS](./nf-msacm-acmfilterdetails.md) structure was
///                 given and the remaining details should be returned. The <b>dwFilterTag</b> member of the <b>ACMFILTERDETAILS</b>
///                 structure must be initialized to the same filter tag <b>pwfltr</b> specifies. This query type can be used to get
///                 a string description of an arbitrary filter structure. If an application specifies an ACM driver handle for
///                 <i>had</i>, details on the filter will be returned for that driver. If an application specifies <b>NULL</b> for
///                 <i>had</i>, the ACM finds the first acceptable driver to return the details.</td> </tr> <tr>
///                 <td>ACM_FILTERDETAILSF_INDEX</td> <td>A filter index for the filter tag was given in the <b>dwFilterIndex</b>
///                 member of the <b>ACMFILTERDETAILS</b> structure. The filter details will be returned in the structure defined by
///                 <i>pafd</i>. The index ranges from zero to one less than the <b>cStandardFilters</b> member returned in the
///                 <b>ACMFILTERTAGDETAILS</b> structure for a filter tag. An application must specify a driver handle for <i>had</i>
///                 when retrieving filter details with this flag. For information about what members should be initialized before
///                 calling this function, see the <b>ACMFILTERDETAILS</b> structure.</td> </tr> </table>
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ACMERR_NOTPOSSIBLE</b></dt>
///    </dl> </td> <td width="60%"> The details requested are not available. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALFLAG</b></dt> </dl> </td> <td width="60%"> At least one flag is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified handle is
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%">
///    At least one parameter is invalid. </td> </tr> </table>
///    
@DllImport("MSACM32")
uint acmFilterDetailsW(HACMDRIVER__* had, tACMFILTERDETAILSW* pafd, uint fdwDetails);

///The <b>acmFilterEnum</b> function enumerates waveform-audio filters available for a given filter tag from an ACM
///driver. This function continues enumerating until there are no more suitable filters for the filter tag or the
///callback function returns <b>FALSE</b>.
///Params:
///    had = Handle to the ACM driver to query for waveform-audio filter details. If this parameter is <b>NULL</b>, the ACM
///          uses the details from the first suitable ACM driver.
///    pafd = Pointer to the [ACMFILTERDETAILS](./nf-msacm-acmfilterdetails.md) structure that contains the filter details when
///           it is passed to the function specified by <i>fnCallback</i>. When your application calls <b>acmFilterEnum</b>,
///           the <b>cbStruct</b>, <b>pwfltr</b>, and <b>cbwfltr</b> members of this structure must be initialized. The
///           <b>dwFilterTag</b> member must also be initialized to either WAVE_FILTER_UNKNOWN or a valid filter tag.
///    fnCallback = Procedure-instance address of the application-defined callback function.
///    dwInstance = A 32-bit (DWORD), 64-bit (DWORD_PTR) application-defined value that is passed to the callback function along with
///                 ACM filter details.
///    fdwEnum = Flags for enumerating the filters for a given filter tag. The following values are defined. <table> <tr>
///              <th>Value </th> <th>Meaning </th> </tr> <tr> <td>ACM_FILTERENUMF_DWFILTERTAG</td>
///              [ACMFILTERDETAILS](./nf-msacm-acmfilterdetails.md) structure is valid. The enumerator will enumerate only a
///              filter that conforms to this attribute. The <b>dwFilterTag</b> member of the <b>ACMFILTERDETAILS</b> structure
///              must be equal to the <b>dwFilterTag</b> member of the <b>WAVEFILTER</b> structure.</td> </tr> </table>
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ACMERR_NOTPOSSIBLE</b></dt>
///    </dl> </td> <td width="60%"> The details for the filter cannot be returned. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>MMSYSERR_INVALFLAG</b></dt> </dl> </td> <td width="60%"> At least one flag is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified handle
///    is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td
///    width="60%"> At least one parameter is invalid. </td> </tr> </table>
///    
@DllImport("MSACM32")
uint acmFilterEnumA(HACMDRIVER__* had, tACMFILTERDETAILSA* pafd, ACMFILTERENUMCBA fnCallback, size_t dwInstance, 
                    uint fdwEnum);

///The <b>acmFilterEnum</b> function enumerates waveform-audio filters available for a given filter tag from an ACM
///driver. This function continues enumerating until there are no more suitable filters for the filter tag or the
///callback function returns <b>FALSE</b>.
///Params:
///    had = Handle to the ACM driver to query for waveform-audio filter details. If this parameter is <b>NULL</b>, the ACM
///          uses the details from the first suitable ACM driver.
///    pafd = Pointer to the [ACMFILTERDETAILS](./nf-msacm-acmfilterdetails.md) structure that contains the filter details when
///           it is passed to the function specified by <i>fnCallback</i>. When your application calls <b>acmFilterEnum</b>,
///           the <b>cbStruct</b>, <b>pwfltr</b>, and <b>cbwfltr</b> members of this structure must be initialized. The
///           <b>dwFilterTag</b> member must also be initialized to either WAVE_FILTER_UNKNOWN or a valid filter tag.
///    fnCallback = Procedure-instance address of the application-defined callback function.
///    dwInstance = A 32-bit (DWORD), 64-bit (DWORD_PTR) application-defined value that is passed to the callback function along with
///                 ACM filter details.
///    fdwEnum = Flags for enumerating the filters for a given filter tag. The following values are defined. <table> <tr>
///              <th>Value </th> <th>Meaning </th> </tr> <tr> <td>ACM_FILTERENUMF_DWFILTERTAG</td>
///              [ACMFILTERDETAILS](./nf-msacm-acmfilterdetails.md) structure is valid. The enumerator will enumerate only a
///              filter that conforms to this attribute. The <b>dwFilterTag</b> member of the <b>ACMFILTERDETAILS</b> structure
///              must be equal to the <b>dwFilterTag</b> member of the <b>WAVEFILTER</b> structure.</td> </tr> </table>
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ACMERR_NOTPOSSIBLE</b></dt>
///    </dl> </td> <td width="60%"> The details for the filter cannot be returned. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>MMSYSERR_INVALFLAG</b></dt> </dl> </td> <td width="60%"> At least one flag is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified handle
///    is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td
///    width="60%"> At least one parameter is invalid. </td> </tr> </table>
///    
@DllImport("MSACM32")
uint acmFilterEnumW(HACMDRIVER__* had, tACMFILTERDETAILSW* pafd, ACMFILTERENUMCBW fnCallback, size_t dwInstance, 
                    uint fdwEnum);

///The <b>acmFilterChoose</b> function creates an ACM-defined dialog box that enables the user to select a
///waveform-audio filter.
///Params:
///    pafltrc = Pointer to an [ACMFILTERCHOOSE](./nf-msacm-acmfilterchoose.md) structure that contains information used to
///              initialize the dialog box. When <b>acmFilterChoose</b> returns, this structure contains information about the
///              user's filter selection. The <b>pwfltr</b> member of this structure must contain a valid pointer to a memory
///              location that will contain the returned filter header structure. The <b>cbwfltr</b> member must be filled in with
///              the size, in bytes, of this memory buffer.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ACMERR_CANCELED</b></dt> </dl> </td> <td width="60%"> The user chose the Cancel button or the Close
///    command on the System menu to close the dialog box. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ACMERR_NOTPOSSIBLE</b></dt> </dl> </td> <td width="60%"> The buffer identified by the
///    [ACMFILTERCHOOSE](./nf-msacm-acmfilterchoose.md) structure is too small to contain the selected filter. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALFLAG</b></dt> </dl> </td> <td width="60%"> At least one
///    flag is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td
///    width="60%"> The specified handle is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%"> At least one parameter is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> A suitable driver is
///    not available to provide valid filter selections. </td> </tr> </table>
///    
@DllImport("MSACM32")
uint acmFilterChooseA(tACMFILTERCHOOSEA* pafltrc);

///The <b>acmFilterChoose</b> function creates an ACM-defined dialog box that enables the user to select a
///waveform-audio filter.
///Params:
///    pafltrc = Pointer to an [ACMFILTERCHOOSE](./nf-msacm-acmfilterchoose.md) structure that contains information used to
///              initialize the dialog box. When <b>acmFilterChoose</b> returns, this structure contains information about the
///              user's filter selection. The <b>pwfltr</b> member of this structure must contain a valid pointer to a memory
///              location that will contain the returned filter header structure. The <b>cbwfltr</b> member must be filled in with
///              the size, in bytes, of this memory buffer.
///Returns:
///    Returns MMSYSERR_NOERROR if successful or an error otherwise. Possible error values include the following.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ACMERR_CANCELED</b></dt> </dl> </td> <td width="60%"> The user chose the Cancel button or the Close
///    command on the System menu to close the dialog box. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ACMERR_NOTPOSSIBLE</b></dt> </dl> </td> <td width="60%"> The buffer identified by the
///    [ACMFILTERCHOOSE](./nf-msacm-acmfilterchoose.md) structure is too small to contain the selected filter. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALFLAG</b></dt> </dl> </td> <td width="60%"> At least one
///    flag is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td
///    width="60%"> The specified handle is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%"> At least one parameter is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NODRIVER</b></dt> </dl> </td> <td width="60%"> A suitable driver is
///    not available to provide valid filter selections. </td> </tr> </table>
///    
@DllImport("MSACM32")
uint acmFilterChooseW(tACMFILTERCHOOSEW* pafltrc);

///The <b>acmStreamOpen</b> function opens an ACM conversion stream. Conversion streams are used to convert data from
///one specified audio format to another.
///Params:
///    phas = Pointer to a handle that will receive the new stream handle that can be used to perform conversions. This handle
///           is used to identify the stream in calls to other ACM stream conversion functions. If the ACM_STREAMOPENF_QUERY
///           flag is specified, this parameter should be <b>NULL</b>.
///    had = Handle to an ACM driver. If this handle is specified, it identifies a specific driver to be used for a conversion
///          stream. If this parameter is <b>NULL</b>, all suitable installed ACM drivers are queried until a match is found.
///    pwfxSrc = Pointer to a WAVEFORMATEX structure that identifies the desired source format for the conversion.
///    pwfxDst = Pointer to a WAVEFORMATEX structure that identifies the desired destination format for the conversion.
///    pwfltr = Pointer to a [WAVEFILTER](../mmreg/ns-mmreg-wavefilter.md) structure that identifies the desired filtering
///             operation to perform on the conversion stream. If no filtering operation is desired, this parameter can be
///             <b>NULL</b>. If a filter is specified, the source (<i>pwfxSrc</i>) and destination (<i>pwfxDst</i>) formats must
///             be the same.
///    dwCallback = Pointer to a callback function, a handle of a window, or a handle of an event. A callback function will be called
///                 only if the conversion stream is opened with the ACM_STREAMOPENF_ASYNC flag. A callback function is notified when
///                 the conversion stream is opened or closed and after each buffer is converted. If the conversion stream is opened
///                 without the ACM_STREAMOPENF_ASYNC flag, this parameter should be set to zero.
///    dwInstance = User-instance data passed to the callback function specified by the <i>dwCallback</i> parameter. This parameter
///                 is not used with window and event callbacks. If the conversion stream is opened without the ACM_STREAMOPENF_ASYNC
///                 flag, this parameter should be set to zero.
///    fdwOpen = Flags for opening the conversion stream. The following values are defined. <table> <tr> <th>Value </th>
///              <th>Meaning </th> </tr> <tr> <td>ACM_STREAMOPENF_ASYNC</td> [ACMSTREAMHEADER](./ns-msacm-acmstreamheader.md)
///              structure for the ACMSTREAMHEADER_STATUSF_DONE flag.</td> </tr> <tr> <td>ACM_STREAMOPENF_NONREALTIME</td> <td>ACM
///              will not consider time constraints when converting the data. By default, the driver will attempt to convert the
///              data in real time. For some formats, specifying this flag might improve the audio quality or other
///              characteristics.</td> </tr> <tr> <td>ACM_STREAMOPENF_QUERY</td> <td>ACM will be queried to determine whether it
///              supports the given conversion. A conversion stream will not be opened, and no handle will be returned in the
///              <i>phas</i> parameter.</td> </tr> <tr> <td>CALLBACK_EVENT</td> <td>The <i>dwCallback</i> parameter is a handle of
///              an event.</td> </tr> <tr> <td>CALLBACK_FUNCTION</td> <td>The <i>dwCallback</i> parameter is a callback procedure
///              address. The function prototype must conform to the acmStreamConvertCallback prototype.</td> </tr> <tr>
///              <td>CALLBACK_WINDOW</td> <td>The <i>dwCallback</i> parameter is a window handle.</td> </tr> </table>
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ACMERR_NOTPOSSIBLE</b></dt>
///    </dl> </td> <td width="60%"> The requested operation cannot be performed. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALFLAG</b></dt> </dl> </td> <td width="60%"> At least one flag is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified handle is
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%">
///    At least one parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl>
///    </td> <td width="60%"> The system is unable to allocate resources. </td> </tr> </table>
///    
@DllImport("MSACM32")
uint acmStreamOpen(HACMSTREAM__** phas, HACMDRIVER__* had, WAVEFORMATEX* pwfxSrc, WAVEFORMATEX* pwfxDst, 
                   WAVEFILTER* pwfltr, size_t dwCallback, size_t dwInstance, uint fdwOpen);

///The <b>acmStreamClose</b> function closes an ACM conversion stream. If the function is successful, the handle is
///invalidated.
///Params:
///    has = Handle to the open conversion stream to be closed.
///    fdwClose = Reserved; must be zero.
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ACMERR_BUSY</b></dt> </dl>
///    </td> <td width="60%"> The conversion stream cannot be closed because an asynchronous conversion is still in
///    progress. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALFLAG</b></dt> </dl> </td> <td width="60%">
///    At least one flag is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl>
///    </td> <td width="60%"> The specified handle is invalid. </td> </tr> </table>
///    
@DllImport("MSACM32")
uint acmStreamClose(HACMSTREAM__* has, uint fdwClose);

///The <b>acmStreamSize</b> function returns a recommended size for a source or destination buffer on an ACM stream.
///Params:
///    has = Handle to the conversion stream.
///    cbInput = Size, in bytes, of the source or destination buffer. The <i>fdwSize</i> flags specify what the input parameter
///              defines. This parameter must be nonzero.
///    pdwOutputBytes = Pointer to a variable that contains the size, in bytes, of the source or destination buffer. The <i>fdwSize</i>
///                     flags specify what the output parameter defines. If the <b>acmStreamSize</b> function succeeds, this location
///                     will always be filled with a nonzero value.
///    fdwSize = Flags for the stream size query. The following values are defined: <table> <tr> <th>Value </th> <th>Meaning </th>
///              </tr> <tr> <td>ACM_STREAMSIZEF_DESTINATION</td> <td>The <i>cbInput</i> parameter contains the size of the
///              destination buffer. The <i>pdwOutputBytes</i> parameter will receive the recommended source buffer size, in
///              bytes.</td> </tr> <tr> <td>ACM_STREAMSIZEF_SOURCE</td> <td>The <i>cbInput</i> parameter contains the size of the
///              source buffer. The <i>pdwOutputBytes</i> parameter will receive the recommended destination buffer size, in
///              bytes.</td> </tr> </table>
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ACMERR_NOTPOSSIBLE</b></dt>
///    </dl> </td> <td width="60%"> The requested operation cannot be performed. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALFLAG</b></dt> </dl> </td> <td width="60%"> At least one flag is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified handle is
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%">
///    At least one parameter is invalid. </td> </tr> </table>
///    
@DllImport("MSACM32")
uint acmStreamSize(HACMSTREAM__* has, uint cbInput, uint* pdwOutputBytes, uint fdwSize);

///The <b>acmStreamReset</b> function stops conversions for a given ACM stream. All pending buffers are marked as done
///and returned to the application.
///Params:
///    has = Handle to the conversion stream.
///    fdwReset = Reserved; must be zero.
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALFLAG</b></dt>
///    </dl> </td> <td width="60%"> At least one flag is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified handle is invalid. </td> </tr>
///    </table>
///    
@DllImport("MSACM32")
uint acmStreamReset(HACMSTREAM__* has, uint fdwReset);

///The <b>acmStreamMessage</b> function sends a driver-specific message to an ACM driver.
///Params:
///    has = Handle to an open conversion stream.
///    uMsg = Message to send.
///    lParam1 = Message parameter.
///    lParam2 = Message parameter.
///Returns:
///    Returns the value returned by the ACM device driver.
///    
@DllImport("MSACM32")
uint acmStreamMessage(HACMSTREAM__* has, uint uMsg, LPARAM lParam1, LPARAM lParam2);

///The <b>acmStreamConvert</b> function requests the ACM to perform a conversion on the specified conversion stream. A
///conversion may be synchronous or asynchronous, depending on how the stream was opened.
///Params:
///    has = Handle to the open conversion stream.
///    pash = Pointer to a stream header that describes source and destination buffers for a conversion. This header must have
///           been prepared previously by using the acmStreamPrepareHeader function.
///    fdwConvert = Flags for doing the conversion. The following values are defined. <table> <tr> <th>Value </th> <th>Meaning </th>
///                 </tr> <tr> <td>ACM_STREAMCONVERTF_BLOCKALIGN</td> <td>Only integral numbers of blocks will be converted.
///                 Converted data will end on block-aligned boundaries. An application should use this flag for all conversions on a
///                 stream until there is not enough source data to convert to a block-aligned destination. In this case, the last
///                 conversion should be specified without this flag.</td> </tr> <tr> <td>ACM_STREAMCONVERTF_END</td> <td>ACM
///                 conversion stream should begin returning pending instance data. For example, if a conversion stream holds
///                 instance data, such as the end of an echo filter operation, this flag will cause the stream to start returning
///                 this remaining data with optional source data. This flag can be specified with the ACM_STREAMCONVERTF_START
///                 flag.</td> </tr> <tr> <td>ACM_STREAMCONVERTF_START</td> <td>ACM conversion stream should reinitialize its
///                 instance data. For example, if a conversion stream holds instance data, such as delta or predictor information,
///                 this flag will restore the stream to starting defaults. This flag can be specified with the
///                 ACM_STREAMCONVERTF_END flag.</td> </tr> </table>
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ACMERR_BUSY</b></dt> </dl>
///    </td> <td width="60%"> The stream header specified in <i>pash</i> is currently in use and cannot be reused. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ACMERR_UNPREPARED</b></dt> </dl> </td> <td width="60%"> The stream header
///    specified in <i>pash</i> is currently not prepared by the acmStreamPrepareHeader function. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>MMSYSERR_INVALFLAG</b></dt> </dl> </td> <td width="60%"> At least one flag is invalid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The
///    specified handle is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl>
///    </td> <td width="60%"> At least one parameter is invalid. </td> </tr> </table>
///    
@DllImport("MSACM32")
uint acmStreamConvert(HACMSTREAM__* has, ACMSTREAMHEADER* pash, uint fdwConvert);

///The [ACMSTREAMHEADER](./ns-msacm-acmstreamheader.md) structure for an ACM stream conversion. This function must be
///called for every stream header before it can be used in a conversion stream. An application needs to prepare a stream
///header only once for the life of a given stream. The stream header can be reused as long as the sizes of the source
///and destination buffers do not exceed the sizes used when the stream header was originally prepared.
///Params:
///    has = Handle to the conversion steam.
///    pash = Pointer to an [ACMSTREAMHEADER](./ns-msacm-acmstreamheader.md) structure that identifies the source and
///           destination buffers to be prepared.
///    fdwPrepare = Reserved; must be zero.
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALFLAG</b></dt>
///    </dl> </td> <td width="60%"> At least one flag is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%"> The specified handle is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl> </td> <td width="60%"> At least one
///    parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_NOMEM</b></dt> </dl> </td> <td
///    width="60%"> The system is unable to allocate resources. </td> </tr> </table>
///    
@DllImport("MSACM32")
uint acmStreamPrepareHeader(HACMSTREAM__* has, ACMSTREAMHEADER* pash, uint fdwPrepare);

///The <b>acmStreamUnprepareHeader</b> function cleans up the preparation performed by the acmStreamPrepareHeader
///function for an ACM stream. This function must be called after the ACM is finished with the given buffers. An
///application must call this function before freeing the source and destination buffers.
///Params:
///    has = Handle to the conversion steam.
///    pash = Pointer to an [ACMSTREAMHEADER](./ns-msacm-acmstreamheader.md) structure that identifies the source and
///           destination buffers to be unprepared.
///    fdwUnprepare = Reserved; must be zero.
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ACMERR_BUSY</b></dt> </dl>
///    </td> <td width="60%"> The stream header specified in <i>pash</i> is currently in use and cannot be unprepared.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ACMERR_UNPREPARED</b></dt> </dl> </td> <td width="60%"> The stream
///    header specified in <i>pash</i> is currently not prepared by the acmStreamPrepareHeader function. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALFLAG</b></dt> </dl> </td> <td width="60%"> At least one flag is
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALHANDLE</b></dt> </dl> </td> <td width="60%">
///    The specified handle is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MMSYSERR_INVALPARAM</b></dt> </dl>
///    </td> <td width="60%"> At least one parameter is invalid. </td> </tr> </table>
///    
@DllImport("MSACM32")
uint acmStreamUnprepareHeader(HACMSTREAM__* has, ACMSTREAMHEADER* pash, uint fdwUnprepare);

@DllImport("MSVFW32")
uint VideoForWindowsVersion();

///The <b>ICInfo</b> function retrieves information about specific installed compressors or enumerates the installed
///compressors.
///Params:
///    fccType = Four-character code indicating the type of compressor. Specify zero to match all compressor types.
///    fccHandler = Four-character code identifying a specific compressor or a number between zero and the number of installed
///                 compressors of the type specified by <i>fccType</i>.
///    lpicinfo = Pointer to a ICINFO structure to return information about the compressor.
///Returns:
///    Returns <b>TRUE</b> if successful or an error otherwise.
///    
@DllImport("MSVFW32")
BOOL ICInfo(uint fccType, uint fccHandler, ICINFO* lpicinfo);

///The <b>ICInstall</b> function installs a new compressor or decompressor.
///Params:
///    fccType = Four-character code indicating the type of data used by the compressor or decompressor. Specify "VIDC" for a
///              video compressor or decompressor.
///    fccHandler = Four-character code identifying a specific compressor or decompressor.
///    lParam = Pointer to a null-terminated string containing the name of the compressor or decompressor, or the address of a
///             function used for compression or decompression. The contents of this parameter are defined by the flags set for
///             <i>wFlags</i>.
///    szDesc = Reserved; do not use.
///    wFlags = Flags defining the contents of <i>lParam</i>. The following values are defined. <table> <tr> <th>Value </th>
///             <th>Meaning </th> </tr> <tr> <td>ICINSTALL_DRIVER</td> <td>The <i>lParam</i> parameter contains the address of a
///             null-terminated string that names the compressor to install.</td> </tr> <tr> <td>ICINSTALL_FUNCTION</td> <td>The
///             <i>lParam</i> parameter contains the address of a compressor function. This function should be structured like
///             the DriverProc entry point function used by compressors.</td> </tr> </table>
///Returns:
///    Returns ICERR_OK if successful or an error otherwise.
///    
@DllImport("MSVFW32")
BOOL ICInstall(uint fccType, uint fccHandler, LPARAM lParam, PSTR szDesc, uint wFlags);

///The <b>ICRemove</b> function removes an installed compressor.
///Params:
///    fccType = Four-character code indicating the type of data used by the compressor or decompressor. Specify "VIDC" for a
///              video compressor or decompressor.
///    fccHandler = Four-character code identifying a specific compressor or a number between zero and the number of installed
///                 compressors of the type specified by <i>fccType</i>.
///    wFlags = Reserved; do not use.
///Returns:
///    Returns <b>TRUE</b> if successful or <b>FALSE</b> otherwise.
///    
@DllImport("MSVFW32")
BOOL ICRemove(uint fccType, uint fccHandler, uint wFlags);

///The <b>ICGetInfo</b> function obtains information about a compressor.
///Params:
///    hic = Handle to a compressor.
///    picinfo = Pointer to the ICINFO structure to return information about the compressor.
///    cb = Size, in bytes, of the structure pointed to by <i>lpicinfo</i>.
///Returns:
///    Returns the number of bytes copied into the structure or zero if an error occurs.
///    
@DllImport("MSVFW32")
LRESULT ICGetInfo(HIC__* hic, ICINFO* picinfo, uint cb);

///The <b>ICOpen</b> function opens a compressor or decompressor.
///Params:
///    fccType = Four-character code indicating the type of compressor or decompressor to open. For video streams, the value of
///              this parameter is "VIDC".
///    fccHandler = Preferred handler of the specified type. Typically, the handler type is stored in the stream header in an AVI
///                 file.
///    wMode = Flag defining the use of the compressor or decompressor. The following values are defined. <table> <tr> <th>Value
///            </th> <th>Meaning </th> </tr> <tr> <td>ICMODE_COMPRESS</td> <td>Compressor will perform normal compression.</td>
///            </tr> <tr> <td>ICMODE_DECOMPRESS</td> <td>Decompressor will perform normal decompression.</td> </tr> <tr>
///            <td>ICMODE_DRAW</td> <td>Decompressor will decompress and draw the data directly to hardware.</td> </tr> <tr>
///            <td>ICMODE_FASTCOMPRESS</td> <td>Compressor will perform fast (real-time) compression.</td> </tr> <tr>
///            <td>ICMODE_FASTDECOMPRESS</td> <td>Decompressor will perform fast (real-time) decompression.</td> </tr> <tr>
///            <td>ICMODE_QUERY</td> <td>Queries the compressor or decompressor for information.</td> </tr> </table>
///Returns:
///    Returns a handle to a compressor or decompressor if successful or zero otherwise.
///    
@DllImport("MSVFW32")
HIC__* ICOpen(uint fccType, uint fccHandler, uint wMode);

///The <b>ICOpenFunction</b> function opens a compressor or decompressor defined as a function.
///Params:
///    fccType = Type of compressor to open. For video, the value of this parameter is ICTYPE_VIDEO.
///    fccHandler = Preferred handler of the specified type. Typically, this comes from the stream header in an AVI file.
///    wMode = Flag to define the use of the compressor or decompressor. The following values are defined. <table> <tr>
///            <th>Value </th> <th>Meaning </th> </tr> <tr> <td>ICMODE_COMPRESS</td> <td>Compressor will perform normal
///            compression.</td> </tr> <tr> <td>ICMODE_DECOMPRESS</td> <td>Decompressor will perform normal decompression.</td>
///            </tr> <tr> <td>ICMODE_DRAW</td> <td>Decompressor will decompress and draw the data directly to hardware.</td>
///            </tr> <tr> <td>ICMODE_FASTCOMPRESS</td> <td>Compressor will perform fast (real-time) compression.</td> </tr> <tr>
///            <td>ICMODE_FASTDECOMPRESS</td> <td>Decompressor will perform fast (real-time) decompression.</td> </tr> <tr>
///            <td>ICMODE_QUERY</td> <td>Queries the compressor or decompressor for information.</td> </tr> </table>
///    lpfnHandler = Pointer to the function used as the compressor or decompressor.
///Returns:
///    Returns a handle to a compressor or decompressor if successful or zero otherwise.
///    
@DllImport("MSVFW32")
HIC__* ICOpenFunction(uint fccType, uint fccHandler, uint wMode, FARPROC lpfnHandler);

///The <b>ICClose</b> function closes a compressor or decompressor.
///Params:
///    hic = Handle to a compressor or decompressor.
///Returns:
///    Returns ICERR_OK if successful or an error otherwise.
///    
@DllImport("MSVFW32")
LRESULT ICClose(HIC__* hic);

///The <b>ICSendMessage</b> function sends a message to a compressor.
///Params:
///    hic = Handle to the compressor to receive the message.
///    msg = Message to send.
///    dw1 = Additional message-specific information.
///    dw2 = Additional message-specific information.
///Returns:
///    Returns a message-specific result.
///    
@DllImport("MSVFW32")
LRESULT ICSendMessage(HIC__* hic, uint msg, size_t dw1, size_t dw2);

///The <b>ICCompress</b> function compresses a single video image.
///Params:
///    hic = Handle to the compressor to use.
///    dwFlags = Compression flag. The following value is defined:
///    lpbiOutput = Pointer to a BITMAPINFOHEADER structure containing the output format.
///    lpData = Pointer to an output buffer large enough to contain a compressed frame.
///    lpbiInput = Pointer to a BITMAPINFOHEADER structure containing the input format.
///    lpBits = Pointer to the input buffer.
///    lpckid = Reserved; do not use.
///    lpdwFlags = Pointer to the return flags used in the AVI index. The following value is defined:
///    lFrameNum = Frame number.
///    dwFrameSize = Requested frame size, in bytes. Specify a nonzero value if the compressor supports a suggested frame size, as
///                  indicated by the presence of the <b>VIDCF_CRUNCH</b> flag returned by the ICGetInfo function. If this flag is not
///                  set or a data rate for the frame is not specified, specify zero for this parameter. A compressor might have to
///                  sacrifice image quality or make some other trade-off to obtain the size goal specified in this parameter.
///    dwQuality = Requested quality value for the frame. Specify a nonzero value if the compressor supports a suggested quality
///                value, as indicated by the presence of the <b>VIDCF_QUALITY</b> flag returned by ICGetInfo. Otherwise, specify
///                zero for this parameter.
///    lpbiPrev = Pointer to a BITMAPINFOHEADER structure containing the format of the previous frame.
///    lpPrev = Pointer to the uncompressed image of the previous frame. This parameter is not used for fast temporal
///             compression. Specify <b>NULL</b> for this parameter when compressing a key frame, if the compressor does not
///             support temporal compression, or if the compressor does not require an external buffer to store the format and
///             data of the previous image.
///Returns:
///    Returns <b>ICERR_OK</b> if successful or an error otherwise.
///    
@DllImport("MSVFW32")
uint ICCompress(HIC__* hic, uint dwFlags, BITMAPINFOHEADER* lpbiOutput, void* lpData, BITMAPINFOHEADER* lpbiInput, 
                void* lpBits, uint* lpckid, uint* lpdwFlags, int lFrameNum, uint dwFrameSize, uint dwQuality, 
                BITMAPINFOHEADER* lpbiPrev, void* lpPrev);

///The <b>ICDecompress</b> function decompresses a single video frame.
///Params:
///    hic = Handle to the decompressor to use.
///    dwFlags = Applicable decompression flags. The following values are defined. <table> <tr> <th>Value </th> <th>Meaning </th>
///              </tr> <tr> <td><b>ICDECOMPRESS_HURRYUP</b></td> <td>Tries to decompress at a faster rate. When an application
///              uses this flag, the driver should buffer the decompressed data but not draw the image.</td> </tr> <tr>
///              <td><b>ICDECOMPRESS_NOTKEYFRAME</b></td> <td>Current frame is not a key frame.</td> </tr> <tr>
///              <td><b>ICDECOMPRESS_NULLFRAME</b></td> <td>Current frame does not contain data and the decompressed image should
///              be left the same.</td> </tr> <tr> <td><b>ICDECOMPRESS_PREROLL</b></td> <td>Current frame precedes the point in
///              the movie where playback starts and, therefore, will not be drawn.</td> </tr> <tr>
///              <td><b>ICDECOMPRESS_UPDATE</b></td> <td>Screen is being updated or refreshed.</td> </tr> </table>
///    lpbiFormat = Pointer to a BITMAPINFOHEADER structure containing the format of the compressed data.
///    lpData = Pointer to the input data.
///    lpbi = Pointer to a BITMAPINFOHEADER structure containing the output format.
///    lpBits = Pointer to a buffer that is large enough to contain the decompressed data.
///Returns:
///    Returns ICERR_OK if successful or an error otherwise.
///    
@DllImport("MSVFW32")
uint ICDecompress(HIC__* hic, uint dwFlags, BITMAPINFOHEADER* lpbiFormat, void* lpData, BITMAPINFOHEADER* lpbi, 
                  void* lpBits);

///The <b>ICDrawBegin</b> function initializes the renderer and prepares the drawing destination for drawing.
///Params:
///    hic = Handle to the decompressor to use.
///    dwFlags = Decompression flags. The following values are defined. <table> <tr> <th>Value </th> <th>Meaning </th> </tr> <tr>
///              <td><b>ICDRAW_ANIMATE</b></td> <td>Application can animate the palette.</td> </tr> <tr>
///              <td><b>ICDRAW_CONTINUE</b></td> <td>Drawing is a continuation of the previous frame.</td> </tr> <tr>
///              <td><b>ICDRAW_FULLSCREEN</b></td> <td>Draws the decompressed data on the full screen.</td> </tr> <tr>
///              <td><b>ICDRAW_HDC</b></td> <td>Draws the decompressed data to a window or a DC.</td> </tr> <tr>
///              <td><b>ICDRAW_MEMORYDC</b></td> <td>DC is off-screen.</td> </tr> <tr> <td><b>ICDRAW_QUERY</b></td> <td>Determines
///              if the decompressor can decompress the data. The driver does not decompress the data.</td> </tr> <tr>
///              <td><b>ICDRAW_UPDATING</b></td> <td>Current frame is being updated rather than played.</td> </tr> </table>
///    hpal = Handle to the palette used for drawing.
///    hwnd = Handle to the window used for drawing.
///    hdc = DC used for drawing.
///    xDst = The x-coordinate of the upper right corner of the destination rectangle.
///    yDst = The y-coordinate of the upper right corner of the destination rectangle.
///    dxDst = Width of the destination rectangle.
///    dyDst = Height of the destination rectangle.
///    lpbi = Pointer to a BITMAPINFOHEADER structure containing the format of the input data to be decompressed.
///    xSrc = The x-coordinate of the upper right corner of the source rectangle.
///    ySrc = The y-coordinate of the upper right corner of the source rectangle.
///    dxSrc = Width of the source rectangle.
///    dySrc = Height of the source rectangle.
///    dwRate = Frame rate numerator. The frame rate, in frames per second, is obtained by dividing <i>dwRate</i> by
///             <i>dwScale</i>.
///    dwScale = Frame rate denominator. The frame rate, in frames per second, is obtained by dividing <i>dwRate</i> by
///              <i>dwScale</i>.
///Returns:
///    Returns ICERR_OK if the renderer can decompress the data or <b>ICERR_UNSUPPORTED</b> otherwise.
///    
@DllImport("MSVFW32")
uint ICDrawBegin(HIC__* hic, uint dwFlags, HPALETTE hpal, HWND hwnd, HDC hdc, int xDst, int yDst, int dxDst, 
                 int dyDst, BITMAPINFOHEADER* lpbi, int xSrc, int ySrc, int dxSrc, int dySrc, uint dwRate, 
                 uint dwScale);

///The <b>ICDraw</b> function decompresses an image for drawing.
///Params:
///    hic = Handle to an decompressor.
///    dwFlags = Decompression flags. The following values are defined. <table> <tr> <th>Value </th> <th>Meaning </th> </tr> <tr>
///              <td><b>ICDRAW_HURRYUP</b></td> <td>Data is buffered and not drawn to the screen. Use this flag for fastest
///              decompression.</td> </tr> <tr> <td><b>ICDRAW_NOTKEYFRAME</b></td> <td>Current frame is not a key frame.</td>
///              </tr> <tr> <td><b>ICDRAW_NULLFRAME</b></td> <td>Current frame does not contain any data and the previous frame
///              should be redrawn.</td> </tr> <tr> <td><b>ICDRAW_PREROLL</b></td> <td>Current frame of video occurs before
///              playback should start. For example, if playback will begin on frame 10, and frame 0 is the nearest previous key
///              frame, frames 0 through 9 are sent to the driver with the <b>ICDRAW_PREROLL</b> flag set. The driver needs this
///              data to display frame 10 properly.</td> </tr> <tr> <td><b>ICDRAW_UPDATE</b></td> <td>Updates the screen based on
///              previously received data. Set <i>lpData</i> to <b>NULL</b> when this flag is used.</td> </tr> </table>
///    lpFormat = Pointer to a BITMAPINFOHEADER structure containing the input format of the data.
///    lpData = Pointer to the input data.
///    cbData = Size of the input data, in bytes.
///    lTime = Time, in samples, to draw this frame. The units for video data are frames. For a definition of the playback rate,
///            see the <b>dwRate</b> and <b>dwScale</b> members of the ICDRAWBEGIN structure.
///Returns:
///    Returns<b> ICERR_OK</b> if successful or an error otherwise.
///    
@DllImport("MSVFW32")
uint ICDraw(HIC__* hic, uint dwFlags, void* lpFormat, void* lpData, uint cbData, int lTime);

///The <b>ICLocate</b> function finds a compressor or decompressor that can handle images with the specified formats, or
///finds a driver that can decompress an image with a specified format directly to hardware.
///Params:
///    fccType = Four-character code indicating the type of compressor or decompressor to open. For video streams, the value of
///              this parameter is 'VIDC'.
///    fccHandler = Preferred handler of the specified type. Typically, the handler type is stored in the stream header in an AVI
///                 file. Specify <b>NULL</b> if your application can use any handler type or it does not know the handler type to
///                 use.
///    lpbiIn = Pointer to a BITMAPINFOHEADER structure defining the input format. A compressor handle is not returned unless it
///             supports this format.
///    lpbiOut = Pointer to a BITMAPINFOHEADER structure defining an optional decompressed format. You can also specify zero to
///              use the default output format associated with the input format. If this parameter is nonzero, a compressor handle
///              is not returned unless it can create this output format.
///    wFlags = Flags that describe the search criteria for a compressor or decompressor. The following values are defined:
///             <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="ICMODE_COMPRESS"></a><a
///             id="icmode_compress"></a><dl> <dt><b>ICMODE_COMPRESS</b></dt> </dl> </td> <td width="60%"> Finds a compressor
///             that can compress an image with a format defined by <i>lpbiIn</i> to the format defined by <i>lpbiOut</i>. </td>
///             </tr> <tr> <td width="40%"><a id="ICMODE_DECOMPRESS"></a><a id="icmode_decompress"></a><dl>
///             <dt><b>ICMODE_DECOMPRESS</b></dt> </dl> </td> <td width="60%"> Finds a decompressor that can decompress an image
///             with a format defined by <i>lpbiIn</i> to the format defined by <i>lpbiOut</i>. </td> </tr> <tr> <td
///             width="40%"><a id="ICMODE_DRAW"></a><a id="icmode_draw"></a><dl> <dt><b>ICMODE_DRAW</b></dt> </dl> </td> <td
///             width="60%"> Finds a decompressor that can decompress an image with a format defined by <i>lpbiIn</i> and draw it
///             directly to hardware. </td> </tr> <tr> <td width="40%"><a id="ICMODE_FASTCOMPRESS"></a><a
///             id="icmode_fastcompress"></a><dl> <dt><b>ICMODE_FASTCOMPRESS</b></dt> </dl> </td> <td width="60%"> Has the same
///             meaning as <b>ICMODE_COMPRESS</b> except the compressor is used for a real-time operation and emphasizes speed
///             over quality. </td> </tr> <tr> <td width="40%"><a id="ICMODE_FASTDECOMPRESS"></a><a
///             id="icmode_fastdecompress"></a><dl> <dt><b>ICMODE_FASTDECOMPRESS</b></dt> </dl> </td> <td width="60%"> Has the
///             same meaning as <b>ICMODE_DECOMPRESS</b> except the decompressor is used for a real-time operation and emphasizes
///             speed over quality. </td> </tr> </table>
///Returns:
///    Returns a handle to a compressor or decompressor if successful or zero otherwise.
///    
@DllImport("MSVFW32")
HIC__* ICLocate(uint fccType, uint fccHandler, BITMAPINFOHEADER* lpbiIn, BITMAPINFOHEADER* lpbiOut, ushort wFlags);

///The <b>ICGetDisplayFormat</b> function determines the best format available for displaying a compressed image. The
///function also opens a compressor if a handle of an open compressor is not specified.
///Params:
///    hic = Handle to the compressor to use. Specify <b>NULL</b> to have VCM select and open an appropriate compressor.
///    lpbiIn = Pointer to BITMAPINFOHEADER structure containing the compressed format.
///    lpbiOut = Pointer to a buffer to return the decompressed format. The buffer should be large enough for a BITMAPINFOHEADER
///              structure and 256 color entries.
///    BitDepth = Preferred bit depth, if nonzero.
///    dx = Width multiplier to stretch the image. If this parameter is zero, that dimension is not stretched.
///    dy = Height multiplier to stretch the image. If this parameter is zero, that dimension is not stretched.
///Returns:
///    Returns a handle to a decompressor if successful or zero otherwise.
///    
@DllImport("MSVFW32")
HIC__* ICGetDisplayFormat(HIC__* hic, BITMAPINFOHEADER* lpbiIn, BITMAPINFOHEADER* lpbiOut, int BitDepth, int dx, 
                          int dy);

///The <b>ICImageCompress</b> function compresses an image to a given size. This function does not require
///initialization functions.
///Params:
///    hic = Handle to a compressor opened with the ICOpen function. Specify <b>NULL</b> to have VCM select an appropriate
///          compressor for the compression format. An application can have the user select the compressor by using the
///          ICCompressorChoose function, which opens the selected compressor and returns a handle of the compressor in this
///          parameter.
///    uiFlags = Reserved; must be zero.
///    lpbiIn = Pointer to the BITMAPINFO structure containing the input data format.
///    lpBits = Pointer to input data bits to compress. The data bits exclude header and format information.
///    lpbiOut = Pointer to the BITMAPINFO structure containing the compressed output format. Specify <b>NULL</b> to have the
///              compressor use an appropriate format.
///    lQuality = Quality value used by the compressor. Values range from 0 to 10,000.
///    plSize = Maximum size desired for the compressed image. The compressor might not be able to compress the data to fit
///             within this size. When the function returns, this parameter points to the size of the compressed image. Image
///             sizes are specified in bytes.
///Returns:
///    Returns a handle to a compressed DIB. The image data follows the format header.
///    
@DllImport("MSVFW32")
HANDLE ICImageCompress(HIC__* hic, uint uiFlags, BITMAPINFO* lpbiIn, void* lpBits, BITMAPINFO* lpbiOut, 
                       int lQuality, int* plSize);

///The <b>ICImageDecompress</b> function decompresses an image without using initialization functions.
///Params:
///    hic = Handle to a decompressor opened with the ICOpen function. Specify <b>NULL</b> to have VCM select an appropriate
///          decompressor for the compressed image.
///    uiFlags = Reserved; must be zero.
///    lpbiIn = Compressed input data format.
///    lpBits = Pointer to input data bits to compress. The data bits exclude header and format information.
///    lpbiOut = Decompressed output format. Specify <b>NULL</b> to let decompressor use an appropriate format.
///Returns:
///    Returns a handle to an uncompressed DIB in the CF_DIB format if successful or <b>NULL</b> otherwise. Image data
///    follows the format header.
///    
@DllImport("MSVFW32")
HANDLE ICImageDecompress(HIC__* hic, uint uiFlags, BITMAPINFO* lpbiIn, void* lpBits, BITMAPINFO* lpbiOut);

///The <b>ICCompressorChoose</b> function displays a dialog box in which a user can select a compressor. This function
///can display all registered compressors or list only the compressors that support a specific format.
///Params:
///    hwnd = Handle to a parent window for the dialog box.
///    uiFlags = Applicable flags. The following values are defined. <table> <tr> <th>Value </th> <th>Meaning </th> </tr> <tr>
///              <td>ICMF_CHOOSE_ALLCOMPRESSORS</td> <td>All compressors should appear in the selection list. If this flag is not
///              specified, only the compressors that can handle the input format appear in the selection list.</td> </tr> <tr>
///              <td>ICMF_CHOOSE_DATARATE</td> <td>Displays a check box and edit box to enter the data rate for the movie.</td>
///              </tr> <tr> <td>ICMF_CHOOSE_KEYFRAME</td> <td>Displays a check box and edit box to enter the frequency of key
///              frames.</td> </tr> <tr> <td>ICMF_CHOOSE_PREVIEW</td> <td>Displays a button to expand the dialog box to include a
///              preview window. The preview window shows how frames of your movie will appear when compressed with the current
///              settings.</td> </tr> </table>
///    pvIn = Uncompressed data input format. Only compressors that support the specified data input format are included in the
///           compressor list. This parameter is optional.
///    lpData = Pointer to an AVI stream interface to use in the preview window. You must specify a video stream. This parameter
///             is optional.
///    pc = Pointer to a COMPVARS structure. The information returned initializes the structure for use with other functions.
///    lpszTitle = Pointer to a null-terminated string containing a title for the dialog box. This parameter is optional.
///Returns:
///    Returns <b>TRUE</b> if the user chooses a compressor and presses OK. Returns <b>FALSE</b> on error or if the user
///    presses CANCEL.
///    
@DllImport("MSVFW32")
BOOL ICCompressorChoose(HWND hwnd, uint uiFlags, void* pvIn, void* lpData, COMPVARS* pc, PSTR lpszTitle);

///The <b>ICSeqCompressFrameStart</b> function initializes resources for compressing a sequence of frames using the
///ICSeqCompressFrame function.
///Params:
///    pc = Pointer to a COMPVARS structure initialized with information for compression.
///    lpbiIn = Format of the data to be compressed.
///Returns:
///    Returns <b>TRUE</b> if successful or <b>FALSE</b> otherwise.
///    
@DllImport("MSVFW32")
BOOL ICSeqCompressFrameStart(COMPVARS* pc, BITMAPINFO* lpbiIn);

///The <b>ICSeqCompressFrameEnd</b> function ends sequence compression that was initiated by using the
///ICSeqCompressFrameStart and ICSeqCompressFrame functions.
///Params:
///    pc = Pointer to a COMPVARS structure used during sequence compression.
///Returns:
///    This function does not return a value.
///    
@DllImport("MSVFW32")
void ICSeqCompressFrameEnd(COMPVARS* pc);

///The <b>ICSeqCompressFrame</b> function compresses one frame in a sequence of frames.
///Params:
///    pc = Pointer to a COMPVARS structure initialized with information about the compression.
///    uiFlags = Reserved; must be zero.
///    lpBits = Pointer to the data bits to compress. (The data bits exclude header or format information.)
///    pfKey = Returns whether or not the frame was compressed into a key frame.
///    plSize = Maximum size desired for the compressed image. The compressor might not be able to compress the data to fit
///             within this size. When the function returns, the parameter points to the size of the compressed image. Images
///             sizes are specified in bytes.
///Returns:
///    Returns the address of the compressed bits if successful or <b>NULL</b> otherwise.
///    
@DllImport("MSVFW32")
void* ICSeqCompressFrame(COMPVARS* pc, uint uiFlags, void* lpBits, BOOL* pfKey, int* plSize);

///The <b>ICCompressorFree</b> function frees the resources in the COMPVARS structure used by other VCM functions.
///Params:
///    pc = Pointer to the COMPVARS structure containing the resources to be freed.
///Returns:
///    This function does not return a value.
///    
@DllImport("MSVFW32")
void ICCompressorFree(COMPVARS* pc);

///The <b>DrawDibOpen</b> function opens the DrawDib library for use and creates a DrawDib DC for drawing.
///Returns:
///    Returns a handle to a DrawDib DC if successful or <b>NULL</b> otherwise.
///    
@DllImport("MSVFW32")
ptrdiff_t DrawDibOpen();

///The <b>DrawDibClose</b> function closes a DrawDib DC and frees the resources DrawDib allocated for it.
///Params:
///    hdd = Handle to a DrawDib DC.
///Returns:
///    Returns <b>TRUE</b> if successful or <b>FALSE</b> otherwise.
///    
@DllImport("MSVFW32")
BOOL DrawDibClose(ptrdiff_t hdd);

///The <b>DrawDibGetBuffer</b> function retrieves the location of the buffer used by DrawDib for decompression.
///Params:
///    hdd = Handle to a DrawDib DC.
///    lpbi = Pointer to a BITMAPINFO structure. This structure is made up of a BITMAPINFOHEADER structure and a 256-entry
///           table defining the colors used by the bitmap.
///    dwSize = Size, in bytes, of the BITMAPINFO structure pointed to by <i>lpbi</i>
///    dwFlags = Reserved; must be zero.
///Returns:
///    Returns the address of the buffer or <b>NULL</b> if no buffer is used. if <i>lpbr</i> is not <b>NULL</b>, it is
///    filled with a copy of the BITMAPINFO structure describing the buffer.
///    
@DllImport("MSVFW32")
void* DrawDibGetBuffer(ptrdiff_t hdd, BITMAPINFOHEADER* lpbi, uint dwSize, uint dwFlags);

///The <b>DrawDibGetPalette</b> function retrieves the palette used by a DrawDib DC.
///Params:
///    hdd = Handle to a DrawDib DC.
///Returns:
///    Returns a handle to the palette if successful or <b>NULL</b> otherwise.
///    
@DllImport("MSVFW32")
HPALETTE DrawDibGetPalette(ptrdiff_t hdd);

///The <b>DrawDibSetPalette</b> function sets the palette used for drawing DIBs.
///Params:
///    hdd = Handle to a DrawDib DC.
///    hpal = Handle to the palette. Specify <b>NULL</b> to use the default palette.
///Returns:
///    Returns <b>TRUE</b> if successful or <b>FALSE</b> otherwise.
///    
@DllImport("MSVFW32")
BOOL DrawDibSetPalette(ptrdiff_t hdd, HPALETTE hpal);

///The <b>DrawDibChangePalette</b> function sets the palette entries used for drawing DIBs.
///Params:
///    hdd = Handle to a DrawDib DC.
///    iStart = Starting palette entry number.
///    iLen = Number of palette entries.
///    lppe = Pointer to an array of palette entries.
///Returns:
///    Returns <b>TRUE</b> if successful or <b>FALSE</b> otherwise.
///    
@DllImport("MSVFW32")
BOOL DrawDibChangePalette(ptrdiff_t hdd, int iStart, int iLen, PALETTEENTRY* lppe);

///The <b>DrawDibRealize</b> function realizes the palette of the DrawDib DC for use with the specified DC.
///Params:
///    hdd = Handle to a DrawDib DC.
///    hdc = Handle to the DC containing the palette.
///    fBackground = Background palette flag. If this value is nonzero, the palette is a background palette. If this value is zero and
///                  the DC is attached to a window, the logical palette becomes the foreground palette when the window has the input
///                  focus. (A DC is attached to a window when the window class style is CS_OWNDC or when the DC is obtained by using
///                  the GetDC function.)
///Returns:
///    Returns the number of entries in the logical palette mapped to different values in the system palette. If an
///    error occurs or no colors were updated, it returns zero.
///    
@DllImport("MSVFW32")
uint DrawDibRealize(ptrdiff_t hdd, HDC hdc, BOOL fBackground);

///The <b>DrawDibStart</b> function prepares a DrawDib DC for streaming playback.
///Params:
///    hdd = Handle to a DrawDib DC.
///    rate = Playback rate, in microseconds per frame.
///Returns:
///    Returns <b>TRUE</b> if successful or <b>FALSE</b> otherwise.
///    
@DllImport("MSVFW32")
BOOL DrawDibStart(ptrdiff_t hdd, uint rate);

///The <b>DrawDibStop</b> function frees the resources used by a DrawDib DC for streaming playback.
///Params:
///    hdd = Handle to a DrawDib DC.
///Returns:
///    Returns <b>TRUE</b> if successful or <b>FALSE</b> otherwise.
///    
@DllImport("MSVFW32")
BOOL DrawDibStop(ptrdiff_t hdd);

///The <b>DrawDib</b> function changes parameters of a DrawDib DC or initializes a new DrawDib DC.
///Params:
///    hdd = Handle to a DrawDib DC.
///    hdc = Handle to a DC for drawing. This parameter is optional.
///    dxDst = Width, in <b>MM_TEXT</b> client units, of the destination rectangle.
///    dyDst = Height, in <b>MM_TEXT</b> client units, of the destination rectangle.
///    lpbi = Pointer to a BITMAPINFOHEADER structure containing the image format. The color table for the DIB follows the
///           image format and the <b>biHeight</b> member must be a positive value.
///    dxSrc = Width, in pixels, of the source rectangle.
///    dySrc = Height, in pixels, of the source rectangle.
///    wFlags = Applicable flags for the function. The following values are defined. <table> <tr> <th>Value </th> <th>Meaning
///             </th> </tr> <tr> <td>DDF_ANIMATE</td> <td>Allows palette animation. If this value is present, DrawDib reserves as
///             many entries as possible by setting <b>PC_RESERVED</b> in the <b>palPalEntry</b> array entries of the LOGPALETTE
///             structure, and the palette can be animated by using the DrawDibChangePalette function. If your application uses
///             the <b>DrawDibBegin</b> function with the DrawDibDraw function, set this value with <b>DrawDibBegin</b> rather
///             than <b>DrawDibDraw</b>.</td> </tr> <tr> <td>DDF_BACKGROUNDPAL</td> <td>Realizes the palette used for drawing as
///             a background task, leaving the current palette used for the display unchanged. (This value is mutually exclusive
///             of <b>DDF_SAME_HDC</b>.)</td> </tr> <tr> <td>DDF_BUFFER</td> <td>Causes DrawDib to try to use an off-screen
///             buffer so <b>DDF_UPDATE</b> can be used. This disables decompression and drawing directly to the screen. If
///             DrawDib is unable to create an off-screen buffer, it will decompress or draw directly to the screen. For more
///             information, see the <b>DDF_UPDATE</b> and <b>DDF_DONTDRAW</b> values described for DrawDibDraw.</td> </tr> <tr>
///             <td>DDF_DONTDRAW</td> <td>Current image is not drawn, but is decompressed. <b>DDF_UPDATE</b> can be used later to
///             draw the image. This flag supersedes the <b>DDF_PREROLL</b> flag.</td> </tr> <tr> <td>DDF_FULLSCREEN</td> <td>Not
///             supported.</td> </tr> <tr> <td>DDF_HALFTONE</td> <td>Always dithers the DIB to a standard palette regardless of
///             the palette of the DIB. If your application uses <b>DrawDibBegin</b> with DrawDibDraw, set this value with
///             <b>DrawDibBegin</b> rather than <b>DrawDibDraw</b>.</td> </tr> <tr> <td>DDF_JUSTDRAWIT</td> <td>Draws the image
///             by using GDI. Prohibits DrawDib functions from decompressing, stretching, or dithering the image. This strips
///             DrawDib of capabilities that differentiate it from the StretchDIBits function.</td> </tr> <tr>
///             <td>DDF_SAME_DRAW</td> <td>Use the current drawing parameters for DrawDibDraw. Use this value only if
///             <i>lpbi</i>, <i>dxDest</i>, <i>dyDest</i>, <i>dxSrc</i>, and <i>dySrc</i> have not changed since using
///             <b>DrawDibDraw</b> or <b>DrawDibBegin</b>. This flag supersedes the <b>DDF_SAME_DIB</b> and <b>DDF_SAME_SIZE</b>
///             flags.</td> </tr> <tr> <td>DDF_SAME_HDC</td> <td>Use the current DC handle and the palette currently associated
///             with the DC.</td> </tr> <tr> <td>DDF_UPDATE</td> <td>Last buffered bitmap needs to be redrawn. If drawing fails
///             with this value, a buffered image is not available and a new image needs to be specified before the display can
///             be updated.</td> </tr> </table>
///Returns:
///    Returns <b>TRUE</b> if successful or <b>FALSE</b> otherwise.
///    
@DllImport("MSVFW32")
BOOL DrawDibBegin(ptrdiff_t hdd, HDC hdc, int dxDst, int dyDst, BITMAPINFOHEADER* lpbi, int dxSrc, int dySrc, 
                  uint wFlags);

///The <b>DrawDibDraw</b> function draws a DIB to the screen.
///Params:
///    hdd = Handle to a DrawDib DC.
///    hdc = Handle to the DC.
///    xDst = The x-coordinate, in <b>MM_TEXT</b> client coordinates, of the upper left corner of the destination rectangle.
///    yDst = The y-coordinate, in <b>MM_TEXT</b> client coordinates, of the upper left corner of the destination rectangle.
///    dxDst = Width, in <b>MM_TEXT</b> client coordinates, of the destination rectangle. If <i>dxDst</i> is â€“1, the
///            width of the bitmap is used.
///    dyDst = Height, in <b>MM_TEXT</b> client coordinates, of the destination rectangle. If <i>dyDst</i> is â€“1, the
///            height of the bitmap is used.
///    lpbi = Pointer to the BITMAPINFOHEADER structure containing the image format. The color table for the DIB within
///           <b>BITMAPINFOHEADER</b> follows the format and the <b>biHeight</b> member must be a positive value;
///           <b>DrawDibDraw</b> will not draw inverted DIBs.
///    lpBits = Pointer to the buffer that contains the bitmap bits.
///    xSrc = The x-coordinate, in pixels, of the upper left corner of the source rectangle. The coordinates (0,0) represent
///           the upper left corner of the bitmap.
///    ySrc = The y-coordinate, in pixels, of the upper left corner of the source rectangle. The coordinates (0,0) represent
///           the upper left corner of the bitmap.
///    dxSrc = Width, in pixels, of the source rectangle.
///    dySrc = Height, in pixels, of the source rectangle.
///    wFlags = Applicable flags for drawing. The following values are defined. <table> <tr> <th>Value </th> <th>Meaning </th>
///             </tr> <tr> <td><b>DDF_BACKGROUNDPAL</b></td> <td>Realizes the palette used for drawing in the background, leaving
///             the actual palette used for display unchanged. This value is valid only if <b>DDF_SAME_HDC</b> is not set.</td>
///             </tr> <tr> <td><b>DDF_DONTDRAW</b></td> <td>Current image is decompressed but not drawn. This flag supersedes the
///             <b>DDF_PREROLL</b> flag.</td> </tr> <tr> <td><b>DDF_FULLSCREEN</b></td> <td>Not supported.</td> </tr> <tr>
///             <td><b>DDF_HALFTONE</b></td> <td>Always dithers the DIB to a standard palette regardless of the palette of the
///             DIB. If your application uses the DrawDibBegin function, set this value in <b>DrawDibBegin</b> rather than in
///             <b>DrawDibDraw</b>.</td> </tr> <tr> <td><b>DDF_HURRYUP</b></td> <td>Data does not have to be drawn (that is, it
///             can be dropped) and <b>DDF_UPDATE</b> will not be used to recall this information. DrawDib checks this value only
///             if it is required to build the next frame; otherwise, the value is ignored.This value is usually used to
///             synchronize video and audio. When synchronizing data, applications should send the image with this value in case
///             the driver needs to buffer the frame to decompress subsequent frames. </td> </tr> <tr>
///             <td><b>DDF_NOTKEYFRAME</b></td> <td>DIB data is not a key frame.</td> </tr> <tr> <td><b>DDF_SAME_HDC</b></td>
///             <td>Use the current DC handle and the palette currently associated with the DC.</td> </tr> <tr>
///             <td><b>DDF_SAME_DRAW</b></td> <td>Use the current drawing parameters for <b>DrawDibDraw</b>. Use this value only
///             if <i>lpbi</i>, <i>dxDst</i>, <i>dyDst</i>, <i>dxSrc</i>, and <i>dySrc</i> have not changed since using
///             <b>DrawDibDraw</b> or DrawDibBegin. <b>DrawDibDraw</b> typically checks the parameters, and if they have changed,
///             <b>DrawDibBegin</b> prepares the DrawDib DC for drawing. This flag supersedes the <b>DDF_SAME_DIB</b> and
///             <b>DDF_SAME_SIZE</b> flags.</td> </tr> <tr> <td><b>DDF_UPDATE</b></td> <td>Last buffered bitmap is to be redrawn.
///             If drawing fails with this value, a buffered image is not available and a new image needs to be specified before
///             the display can be updated.</td> </tr> </table>
///Returns:
///    Returns <b>TRUE</b> if successful or <b>FALSE</b> otherwise.
///    
@DllImport("MSVFW32")
BOOL DrawDibDraw(ptrdiff_t hdd, HDC hdc, int xDst, int yDst, int dxDst, int dyDst, BITMAPINFOHEADER* lpbi, 
                 void* lpBits, int xSrc, int ySrc, int dxSrc, int dySrc, uint wFlags);

///The <b>DrawDibEnd</b> function clears the flags and other settings of a DrawDib DC that are set by the DrawDibBegin
///or DrawDibDraw functions.
///Params:
///    hdd = Handle to the DrawDib DC to free.
///Returns:
///    Returns <b>TRUE</b> if successful or <b>FALSE</b> otherwise.
///    
@DllImport("MSVFW32")
BOOL DrawDibEnd(ptrdiff_t hdd);

///The <b>DrawDibTime</b> function retrieves timing information about the drawing operation and is used during debug
///operations.
///Params:
///    hdd = Handle to a DrawDib DC.
///    lpddtime = Pointer to a DRAWDIBTIME structure.
///Returns:
///    Returns <b>TRUE</b> if successful or <b>FALSE</b> otherwise.
///    
@DllImport("MSVFW32")
BOOL DrawDibTime(ptrdiff_t hdd, DRAWDIBTIME* lpddtime);

///The <b>DrawDibProfileDisplay</b> function determines settings for the display system when using DrawDib functions.
///Params:
///    lpbi = Pointer to a BITMAPINFOHEADER structure that contains bitmap information. You can also specify <b>NULL</b> to
///           verify that the profile information is current. If the profile information is not current, DrawDib will rerun the
///           profile tests to obtain a current set of information. When you call <b>DrawDibProfileDisplay</b> with this
///           parameter set to <b>NULL</b>, the return value is meaningless.
///Returns:
///    Returns a value that indicates the fastest drawing and stretching capabilities of the display system. This value
///    can be zero if the bitmap format is not supported or one or more of the following values. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PD_CAN_DRAW_DIB</b></dt> </dl> </td> <td
///    width="60%"> DrawDib can draw images using this format. Stretching might or might not also be supported. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>PD_CAN_STRETCHDIB</b></dt> </dl> </td> <td width="60%"> DrawDib can
///    stretch and draw images using this format. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PD_STRETCHDIB_1_1_OK</b></dt> </dl> </td> <td width="60%"> StretchDIBits draws unstretched images using
///    this format faster than an alternative method. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PD_STRETCHDIB_1_2_OK</b></dt> </dl> </td> <td width="60%"> StretchDIBits draws stretched images (in a 1:2
///    ratio) using this format faster than an alternative method. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>PD_STRETCHDIB_1_N_OK</b></dt> </dl> </td> <td width="60%"> StretchDIBits draws stretched images (in a 1:N
///    ratio) using this format faster than an alternative method. </td> </tr> </table>
///    
@DllImport("MSVFW32")
LRESULT DrawDibProfileDisplay(BITMAPINFOHEADER* lpbi);

///The <b>AVIFileInit</b> function initializes the AVIFile library. The AVIFile library maintains a count of the number
///of times it is initialized, but not the number of times it was released. Use the AVIFileExit function to release the
///AVIFile library and decrement the reference count. Call <b>AVIFileInit</b> before using any other AVIFile functions.
///This function supersedes the obsolete <b>AVIStreamInit</b> function.
@DllImport("AVIFIL32")
void AVIFileInit();

///The <b>AVIFileExit</b> function exits the AVIFile library and decrements the reference count for the library. This
///function supersedes the obsolete <b>AVIStreamExit</b> function.
@DllImport("AVIFIL32")
void AVIFileExit();

///The <b>AVIFileAddRef</b> function increments the reference count of an AVI file.
///Params:
///    pfile = Handle to an open AVI file.
///Returns:
///    Returns the updated reference count for the file interface.
///    
@DllImport("AVIFIL32")
uint AVIFileAddRef(IAVIFile pfile);

///The <b>AVIFileRelease</b> function decrements the reference count of an AVI file interface handle and closes the file
///if the count reaches zero. This function supersedes the obsolete <b>AVIFileClose</b> function.
///Params:
///    pfile = Handle to an open AVI file.
///Returns:
///    Returns the reference count of the file. This return value should be used only for debugging purposes.
///    
@DllImport("AVIFIL32")
uint AVIFileRelease(IAVIFile pfile);

///The <b>AVIFileOpen</b> function opens an AVI file and returns the address of a file interface used to access it. The
///AVIFile library maintains a count of the number of times a file is opened, but not the number of times it was
///released. Use the AVIFileRelease function to release the file and decrement the count.
///Params:
///    ppfile = Pointer to a buffer that receives the new IAVIFile interface pointer.
///    szFile = Null-terminated string containing the name of the file to open.
///    uMode = Access mode to use when opening the file. The default access mode is OF_READ. The following access modes can be
///            specified with <b>AVIFileOpen</b>. <table> <tr> <th>Value </th> <th>Meaning </th> </tr> <tr> <td>OF_CREATE</td>
///            <td>Creates a new file. If the file already exists, it is truncated to zero length.</td> </tr> <tr>
///            <td>OF_PARSE</td> <td>Skips time-consuming operations, such as building an index. Set this flag if you want the
///            function to return as quickly as possible—for example, if you are going to query the file properties but not
///            read the file.</td> </tr> <tr> <td>OF_READ</td> <td>Opens the file for reading.</td> </tr> <tr>
///            <td>OF_READWRITE</td> <td>Opens the file for reading and writing.</td> </tr> <tr> <td>OF_SHARE_DENY_NONE</td>
///            <td>Opens the file nonexclusively. Other processes can open the file with read or write access.
///            <b>AVIFileOpen</b> fails if another process has opened the file in compatibility mode.</td> </tr> <tr>
///            <td>OF_SHARE_DENY_READ</td> <td>Opens the file nonexclusively. Other processes can open the file with write
///            access. <b>AVIFileOpen</b> fails if another process has opened the file in compatibility mode or has read access
///            to it.</td> </tr> <tr> <td>OF_SHARE_DENY_WRITE</td> <td>Opens the file nonexclusively. Other processes can open
///            the file with read access. <b>AVIFileOpen</b> fails if another process has opened the file in compatibility mode
///            or has write access to it.</td> </tr> <tr> <td>OF_SHARE_EXCLUSIVE</td> <td>Opens the file and denies other
///            processes any access to it. <b>AVIFileOpen</b> fails if any other process has opened the file.</td> </tr> <tr>
///            <td>OF_WRITE</td> <td>Opens the file for writing.</td> </tr> </table>
///    lpHandler = Pointer to a class identifier of the standard or custom handler you want to use. If the value is <b>NULL</b>, the
///                system chooses a handler from the registry based on the file extension or the RIFF type specified in the file.
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>AVIERR_BADFORMAT</b></dt> </dl>
///    </td> <td width="60%"> The file couldn't be read, indicating a corrupt file or an unrecognized format. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>AVIERR_MEMORY</b></dt> </dl> </td> <td width="60%"> The file could not be
///    opened because of insufficient memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>AVIERR_FILEREAD</b></dt>
///    </dl> </td> <td width="60%"> A disk error occurred while reading the file. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>AVIERR_FILEOPEN</b></dt> </dl> </td> <td width="60%"> A disk error occurred while opening the file. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>REGDB_E_CLASSNOTREG</b></dt> </dl> </td> <td width="60%"> According to
///    the registry, the type of file specified in <b>AVIFileOpen</b> does not have a handler to process it. </td> </tr>
///    </table>
///    
@DllImport("AVIFIL32")
HRESULT AVIFileOpenA(IAVIFile* ppfile, const(PSTR) szFile, uint uMode, GUID* lpHandler);

///The <b>AVIFileOpen</b> function opens an AVI file and returns the address of a file interface used to access it. The
///AVIFile library maintains a count of the number of times a file is opened, but not the number of times it was
///released. Use the AVIFileRelease function to release the file and decrement the count.
///Params:
///    ppfile = Pointer to a buffer that receives the new IAVIFile interface pointer.
///    szFile = Null-terminated string containing the name of the file to open.
///    uMode = Access mode to use when opening the file. The default access mode is OF_READ. The following access modes can be
///            specified with <b>AVIFileOpen</b>. <table> <tr> <th>Value </th> <th>Meaning </th> </tr> <tr> <td>OF_CREATE</td>
///            <td>Creates a new file. If the file already exists, it is truncated to zero length.</td> </tr> <tr>
///            <td>OF_PARSE</td> <td>Skips time-consuming operations, such as building an index. Set this flag if you want the
///            function to return as quickly as possible—for example, if you are going to query the file properties but not
///            read the file.</td> </tr> <tr> <td>OF_READ</td> <td>Opens the file for reading.</td> </tr> <tr>
///            <td>OF_READWRITE</td> <td>Opens the file for reading and writing.</td> </tr> <tr> <td>OF_SHARE_DENY_NONE</td>
///            <td>Opens the file nonexclusively. Other processes can open the file with read or write access.
///            <b>AVIFileOpen</b> fails if another process has opened the file in compatibility mode.</td> </tr> <tr>
///            <td>OF_SHARE_DENY_READ</td> <td>Opens the file nonexclusively. Other processes can open the file with write
///            access. <b>AVIFileOpen</b> fails if another process has opened the file in compatibility mode or has read access
///            to it.</td> </tr> <tr> <td>OF_SHARE_DENY_WRITE</td> <td>Opens the file nonexclusively. Other processes can open
///            the file with read access. <b>AVIFileOpen</b> fails if another process has opened the file in compatibility mode
///            or has write access to it.</td> </tr> <tr> <td>OF_SHARE_EXCLUSIVE</td> <td>Opens the file and denies other
///            processes any access to it. <b>AVIFileOpen</b> fails if any other process has opened the file.</td> </tr> <tr>
///            <td>OF_WRITE</td> <td>Opens the file for writing.</td> </tr> </table>
///    lpHandler = Pointer to a class identifier of the standard or custom handler you want to use. If the value is <b>NULL</b>, the
///                system chooses a handler from the registry based on the file extension or the RIFF type specified in the file.
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>AVIERR_BADFORMAT</b></dt> </dl>
///    </td> <td width="60%"> The file couldn't be read, indicating a corrupt file or an unrecognized format. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>AVIERR_MEMORY</b></dt> </dl> </td> <td width="60%"> The file could not be
///    opened because of insufficient memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>AVIERR_FILEREAD</b></dt>
///    </dl> </td> <td width="60%"> A disk error occurred while reading the file. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>AVIERR_FILEOPEN</b></dt> </dl> </td> <td width="60%"> A disk error occurred while opening the file. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>REGDB_E_CLASSNOTREG</b></dt> </dl> </td> <td width="60%"> According to
///    the registry, the type of file specified in <b>AVIFileOpen</b> does not have a handler to process it. </td> </tr>
///    </table>
///    
@DllImport("AVIFIL32")
HRESULT AVIFileOpenW(IAVIFile* ppfile, const(PWSTR) szFile, uint uMode, GUID* lpHandler);

///The <b>AVIFileInfo</b> function obtains information about an AVI file.
///Params:
///    pfile = Handle to an open AVI file.
///    pfi = Pointer to the structure used to return file information. Typically, this parameter points to an AVIFILEINFO
///          structure.
///    lSize = Size, in bytes, of the structure.
///Returns:
///    Returns zero if successful or an error otherwise.
///    
@DllImport("AVIFIL32")
HRESULT AVIFileInfoW(IAVIFile pfile, AVIFILEINFOW* pfi, int lSize);

///The <b>AVIFileInfo</b> function obtains information about an AVI file.
///Params:
///    pfile = Handle to an open AVI file.
///    pfi = Pointer to the structure used to return file information. Typically, this parameter points to an AVIFILEINFO
///          structure.
///    lSize = Size, in bytes, of the structure.
///Returns:
///    Returns zero if successful or an error otherwise.
///    
@DllImport("AVIFIL32")
HRESULT AVIFileInfoA(IAVIFile pfile, AVIFILEINFOA* pfi, int lSize);

///The <b>AVIFileGetStream</b> function returns the address of a stream interface that is associated with a specified
///AVI file.
///Params:
///    pfile = Handle to an open AVI file.
///    ppavi = Pointer to the new stream interface.
///    fccType = Four-character code indicating the type of stream to open. Zero indicates any stream can be opened. The following
///              definitions apply to the data commonly found in AVI streams. <table> <tr> <th>Value </th> <th>Description </th>
///              </tr> <tr> <td>streamtypeAUDIO</td> <td>Indicates an audio stream.</td> </tr> <tr> <td>streamtypeMIDI</td>
///              <td>Indicates a MIDI stream.</td> </tr> <tr> <td>streamtypeTEXT</td> <td>Indicates a text stream.</td> </tr> <tr>
///              <td>streamtypeVIDEO</td> <td>Indicates a video stream.</td> </tr> </table>
///    lParam = Count of the stream type. Identifies which occurrence of the specified stream type to access.
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>AVIERR_NODATA</b></dt> </dl>
///    </td> <td width="60%"> The file does not contain a stream corresponding to the values of <i>fccType</i> and
///    <i>lParam</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>AVIERR_MEMORY</b></dt> </dl> </td> <td width="60%">
///    Not enough memory. </td> </tr> </table>
///    
@DllImport("AVIFIL32")
HRESULT AVIFileGetStream(IAVIFile pfile, IAVIStream* ppavi, uint fccType, int lParam);

///The <b>AVIFileCreateStream</b> function creates a new stream in an existing file and creates an interface to the new
///stream.
///Params:
///    pfile = Handle to an open AVI file.
///    ppavi = Pointer to the new stream interface.
///    psi = Pointer to a structure containing information about the new stream, including the stream type and its sample
///          rate.
///Returns:
///    Returns zero if successful or an error otherwise. Unless the file has been opened with write permission, this
///    function returns AVIERR_READONLY.
///    
@DllImport("AVIFIL32")
HRESULT AVIFileCreateStreamW(IAVIFile pfile, IAVIStream* ppavi, AVISTREAMINFOW* psi);

///The <b>AVIFileCreateStream</b> function creates a new stream in an existing file and creates an interface to the new
///stream.
///Params:
///    pfile = Handle to an open AVI file.
///    ppavi = Pointer to the new stream interface.
///    psi = Pointer to a structure containing information about the new stream, including the stream type and its sample
///          rate.
///Returns:
///    Returns zero if successful or an error otherwise. Unless the file has been opened with write permission, this
///    function returns AVIERR_READONLY.
///    
@DllImport("AVIFIL32")
HRESULT AVIFileCreateStreamA(IAVIFile pfile, IAVIStream* ppavi, AVISTREAMINFOA* psi);

///The <b>AVIFileWriteData</b> function writes supplementary data (other than normal header, format, and stream data) to
///the file.
///Params:
///    pfile = Handle to an open AVI file.
///    ckid = RIFF chunk identifier (four-character code) of the data.
///    lpData = Pointer to the buffer used to write the data.
///    cbData = Size, in bytes, of the memory block referenced by <i>lpData</i>.
///Returns:
///    Returns zero if successful or an error otherwise. In an application has read-only access to the file, the error
///    code AVIERR_READONLY is returned.
///    
@DllImport("AVIFIL32")
HRESULT AVIFileWriteData(IAVIFile pfile, uint ckid, void* lpData, int cbData);

///The <b>AVIFileReadData</b> function reads optional header data that applies to the entire file, such as author or
///copyright information.
///Params:
///    pfile = Handle to an open AVI file.
///    ckid = RIFF chunk identifier (four-character code) of the data.
///    lpData = Pointer to the buffer used to return the data read.
///    lpcbData = Pointer to a location indicating the size of the memory block referenced by <i>lpData</i>. If the data is read
///               successfully, the value is changed to indicate the amount of data read.
///Returns:
///    Returns zero if successful or an error otherwise. The return value AVIERR_NODATA indicates that data with the
///    requested chunk identifier does not exist.
///    
@DllImport("AVIFIL32")
HRESULT AVIFileReadData(IAVIFile pfile, uint ckid, void* lpData, int* lpcbData);

///The <b>AVIFileEndRecord</b> function marks the end of a record when writing an interleaved file that uses a 1:1
///interleave factor of video to audio data. (Each frame of video is interspersed with an equivalent amount of audio
///data.)
///Params:
///    pfile = Handle to an open AVI file.
///Returns:
///    Returns zero if successful or an error otherwise.
///    
@DllImport("AVIFIL32")
HRESULT AVIFileEndRecord(IAVIFile pfile);

///The <b>AVIStreamAddRef</b> function increments the reference count of an AVI stream.
///Params:
///    pavi = Handle to an open AVI stream.
///Returns:
///    Returns the current reference count of the stream. This value should be used only for debugging purposes.
///    
@DllImport("AVIFIL32")
uint AVIStreamAddRef(IAVIStream pavi);

///The <b>AVIStreamRelease</b> function decrements the reference count of an AVI stream interface handle, and closes the
///stream if the count reaches zero. This function supersedes the obsolete <b>AVIStreamClose</b> function.
///Params:
///    pavi = Handle to an open stream.
///Returns:
///    Returns the current reference count of the stream. This value should be used only for debugging purposes. The
///    argument <i>pavi</i> is a pointer to an IAVIStream interface.
///    
@DllImport("AVIFIL32")
uint AVIStreamRelease(IAVIStream pavi);

///The <b>AVIStreamInfo</b> function obtains stream header information.
///Params:
///    pavi = Handle to an open stream.
///    psi = Pointer to a structure to contain the stream information.
///    lSize = Size, in bytes, of the structure used forpsi.
///Returns:
///    Returns zero if successful or an error otherwise. The argument <i>pavi</i> is a pointer to an IAVIStream
///    interface.
///    
@DllImport("AVIFIL32")
HRESULT AVIStreamInfoW(IAVIStream pavi, AVISTREAMINFOW* psi, int lSize);

///The <b>AVIStreamInfo</b> function obtains stream header information.
///Params:
///    pavi = Handle to an open stream.
///    psi = Pointer to a structure to contain the stream information.
///    lSize = Size, in bytes, of the structure used forpsi.
///Returns:
///    Returns zero if successful or an error otherwise. The argument <i>pavi</i> is a pointer to an IAVIStream
///    interface.
///    
@DllImport("AVIFIL32")
HRESULT AVIStreamInfoA(IAVIStream pavi, AVISTREAMINFOA* psi, int lSize);

///The <b>AVIStreamFindSample</b> function returns the position of a sample (key frame, nonempty frame, or a frame
///containing a format change) relative to the specified position. This function supersedes the obsolete
///<b>AVIStreamFindKeyFrame</b> function.
///Params:
///    pavi = Handle to an open stream.
///    lPos = Starting frame for the search.
///    lFlags = Flags that designate the type of frame to locate, the direction in the stream to search, and the type of return
///             information. The following flags are defined. <table> <tr> <th>Value </th> <th>Meaning </th> </tr> <tr>
///             <td>FIND_ANY</td> <td>Finds a nonempty frame. This flag supersedes the SEARCH_ANY flag.</td> </tr> <tr>
///             <td>FIND_KEY</td> <td>Finds a key frame. This flag supersedes the SEARCH_KEY flag.</td> </tr> <tr>
///             <td>FIND_FORMAT</td> <td>Finds a format change.</td> </tr> <tr> <td>FIND_NEXT</td> <td>Finds nearest sample,
///             frame, or format change searching forward. The current sample is included in the search. Use this flag with the
///             FIND_ANY, FIND_KEY, or FIND_FORMAT flag. This flag supersedes the SEARCH_FORWARD flag.</td> </tr> <tr>
///             <td>FIND_PREV</td> <td>Finds nearest sample, frame, or format change searching backward. The current sample is
///             included in the search. Use this flag with the FIND_ANY, FIND_KEY, or FIND_FORMAT flag. This flag supersedes the
///             SEARCH_NEAREST and SEARCH_BACKWARD flags.</td> </tr> <tr> <td>FIND_FROM_START</td> <td>Finds first sample, frame,
///             or format change beginning from the start of the stream. Use this flag with the FIND_ANY, FIND_KEY, or
///             FIND_FORMAT flag.</td> </tr> </table>
///Returns:
///    Returns the position of the frame found or -1 if the search is unsuccessful.
///    
@DllImport("AVIFIL32")
int AVIStreamFindSample(IAVIStream pavi, int lPos, int lFlags);

///The <b>AVIStreamReadFormat</b> function reads the stream format data.
///Params:
///    pavi = Handle to an open stream.
///    lPos = Position in the stream used to obtain the format data.
///    lpFormat = Pointer to a buffer to contain the format data.
///    lpcbFormat = Pointer to a location indicating the size of the memory block referenced by <i>lpFormat</i>. On return, the value
///                 is changed to indicate the amount of data read. If <i>lpFormat</i> is <b>NULL</b>, this parameter can be used to
///                 obtain the amount of memory needed to return the format.
///Returns:
///    Returns zero if successful or an error otherwise. The argument <i>pavi</i> is a pointer to an IAVIStream
///    interface.
///    
@DllImport("AVIFIL32")
HRESULT AVIStreamReadFormat(IAVIStream pavi, int lPos, void* lpFormat, int* lpcbFormat);

///The <b>AVIStreamSetFormat</b> function sets the format of a stream at the specified position.
///Params:
///    pavi = Handle to an open stream.
///    lPos = Position in the stream to receive the format.
///    lpFormat = Pointer to a structure containing the new format.
///    cbFormat = Size, in bytes, of the block of memory referenced by <i>lpFormat</i>.
///Returns:
///    Returns zero if successful or an error otherwise.
///    
@DllImport("AVIFIL32")
HRESULT AVIStreamSetFormat(IAVIStream pavi, int lPos, void* lpFormat, int cbFormat);

///The <b>AVIStreamReadData</b> function reads optional header data from a stream.
///Params:
///    pavi = Handle to an open stream.
///    fcc = Four-character code identifying the data.
///    lp = Pointer to the buffer to contain the optional header data.
///    lpcb = Pointer to the location that specifies the buffer size used for <i>lpData</i>. If the read is successful, AVIFile
///           changes this value to indicate the amount of data written into the buffer for <i>lpData</i>.
///Returns:
///    Returns zero if successful or an error otherwise. The return value AVIERR_NODATA indicates the system could not
///    find any data with the specified chunk identifier.
///    
@DllImport("AVIFIL32")
HRESULT AVIStreamReadData(IAVIStream pavi, uint fcc, void* lp, int* lpcb);

///The <b>AVIStreamWriteData</b> function writes optional header information to the stream.
///Params:
///    pavi = Handle to an open stream.
///    fcc = Four-character code identifying the data.
///    lp = Pointer to a buffer containing the data to write.
///    cb = Number of bytes of data to write into the stream.
///Returns:
///    Returns zero if successful or an error otherwise. The return value AVIERR_READONLY indicates the file was opened
///    without write access.
///    
@DllImport("AVIFIL32")
HRESULT AVIStreamWriteData(IAVIStream pavi, uint fcc, void* lp, int cb);

///The <b>AVIStreamRead</b> function reads audio, video or other data from a stream according to the stream type.
///Params:
///    pavi = Handle to an open stream.
///    lStart = First sample to read.
///    lSamples = Number of samples to read. You can also specify the value AVISTREAMREAD_CONVENIENT to let the stream handler
///               determine the number of samples to read.
///    lpBuffer = Pointer to a buffer to contain the data.
///    cbBuffer = Size, in bytes, of the buffer pointed to by <i>lpBuffer</i>.
///    plBytes = Pointer to a buffer that receives the number of bytes of data written in the buffer referenced by
///              <i>lpBuffer</i>. This value can be <b>NULL</b>.
///    plSamples = Pointer to a buffer that receives the number of samples written in the buffer referenced by <i>lpBuffer</i>. This
///                value can be <b>NULL</b>.
///Returns:
///    Returns zero if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>AVIERR_BUFFERTOOSMALL</b></dt>
///    </dl> </td> <td width="60%"> The buffer size <i>cbBuffer</i> was smaller than a single sample of data. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>AVIERR_MEMORY</b></dt> </dl> </td> <td width="60%"> There was not enough
///    memory to complete the read operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>AVIERR_FILEREAD</b></dt>
///    </dl> </td> <td width="60%"> A disk error occurred while reading the file. </td> </tr> </table>
///    
@DllImport("AVIFIL32")
HRESULT AVIStreamRead(IAVIStream pavi, int lStart, int lSamples, void* lpBuffer, int cbBuffer, int* plBytes, 
                      int* plSamples);

///The <b>AVIStreamWrite</b> function writes data to a stream.
///Params:
///    pavi = Handle to an open stream.
///    lStart = First sample to write.
///    lSamples = Number of samples to write.
///    lpBuffer = Pointer to a buffer containing the data to write.
///    cbBuffer = Size of the buffer referenced by <i>lpBuffer</i>.
///    dwFlags = Flag associated with this data. The following flag is defined: <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///              <tr> <td width="40%"><a id="AVIIF_KEYFRAME"></a><a id="aviif_keyframe"></a><dl> <dt><b>AVIIF_KEYFRAME</b></dt>
///              </dl> </td> <td width="60%"> Indicates this data does not rely on preceding data in the file. </td> </tr>
///              </table>
///    plSampWritten = Pointer to a buffer that receives the number of samples written. This can be set to <b>NULL</b>.
///    plBytesWritten = Pointer to a buffer that receives the number of bytes written. This can be set to <b>NULL</b>.
///Returns:
///    Returns zero if successful or an error otherwise.
///    
@DllImport("AVIFIL32")
HRESULT AVIStreamWrite(IAVIStream pavi, int lStart, int lSamples, void* lpBuffer, int cbBuffer, uint dwFlags, 
                       int* plSampWritten, int* plBytesWritten);

///The <b>AVIStreamStart</b> function returns the starting sample number for the stream.
///Params:
///    pavi = Handle to an open stream.
///Returns:
///    Returns the number if successful or -1 otherwise.
///    
@DllImport("AVIFIL32")
int AVIStreamStart(IAVIStream pavi);

///The <b>AVIStreamLength</b> function returns the length of the stream.
///Params:
///    pavi = Handle to an open stream.
///Returns:
///    Returns the stream's length, in samples, if successful or -1 otherwise. The argument <i>pavi</i> is a pointer to
///    an IAVIStream interface.
///    
@DllImport("AVIFIL32")
int AVIStreamLength(IAVIStream pavi);

///The <b>AVIStreamTimeToSample</b> function converts from milliseconds to samples.
///Params:
///    pavi = Handle to an open stream.
///    lTime = Time, expressed in milliseconds.
///Returns:
///    Returns the converted time if successful or -1 otherwise.
///    
@DllImport("AVIFIL32")
int AVIStreamTimeToSample(IAVIStream pavi, int lTime);

///The <b>AVIStreamSampleToTime</b> function converts a stream position from samples to milliseconds.
///Params:
///    pavi = Handle to an open stream.
///    lSample = Position information. A sample can correspond to blocks of audio, a video frame, or other format, depending on
///              the stream type.
///Returns:
///    Returns the converted time if successful or â€“1 otherwise.
///    
@DllImport("AVIFIL32")
int AVIStreamSampleToTime(IAVIStream pavi, int lSample);

///The <b>AVIStreamBeginStreaming</b> function specifies the parameters used in streaming and lets a stream handler
///prepare for streaming.
///Params:
///    pavi = Pointer to a stream.
///    lStart = Starting frame for streaming.
///    lEnd = Ending frame for streaming.
///    lRate = Speed at which the file is read relative to its natural speed. Specify 1000 for the normal speed. Values less
///            than 1000 indicate a slower-than-normal speed; values greater than 1000 indicate a faster-than-normal speed.
///Returns:
///    Returns zero if successful or an error otherwise.
///    
@DllImport("AVIFIL32")
HRESULT AVIStreamBeginStreaming(IAVIStream pavi, int lStart, int lEnd, int lRate);

///The <b>AVIStreamEndStreaming</b> function ends streaming.
///Params:
///    pavi = Pointer to a stream.
///Returns:
///    Returns zero if successful or an error otherwise.
///    
@DllImport("AVIFIL32")
HRESULT AVIStreamEndStreaming(IAVIStream pavi);

///The <b>AVIStreamGetFrameOpen</b> function prepares to decompress video frames from the specified video stream.
///Params:
///    pavi = Pointer to the video stream used as the video source.
///    lpbiWanted = Pointer to a structure that defines the desired video format. Specify <b>NULL</b> to use a default format. You
///                 can also specify AVIGETFRAMEF_BESTDISPLAYFMT to decode the frames to the best format for your display.
///Returns:
///    Returns a <b>GetFrame</b> object that can be used with the AVIStreamGetFrame function. If the system cannot find
///    a decompressor that can decompress the stream to the given format, or to any RGB format, the function returns
///    <b>NULL</b>. The argument <i>pavi</i> is a pointer to an IAVIStream interface.
///    
@DllImport("AVIFIL32")
IGetFrame AVIStreamGetFrameOpen(IAVIStream pavi, BITMAPINFOHEADER* lpbiWanted);

///The <b>AVIStreamGetFrame</b> function returns the address of a decompressed video frame.
///Params:
///    pg = Pointer to the IGetFrame interface.
///    lPos = Position, in samples, within the stream of the desired frame.
///Returns:
///    Returns a pointer to the frame data if successful or <b>NULL</b> otherwise. The frame data is returned as a
///    packed DIB.
///    
@DllImport("AVIFIL32")
void* AVIStreamGetFrame(IGetFrame pg, int lPos);

///The <b>AVIStreamGetFrameClose</b> function releases resources used to decompress video frames.
///Params:
///    pg = Handle returned from the AVIStreamGetFrameOpen function. After calling this function, the handle is invalid.
///Returns:
///    Returns zero if successful or an error otherwise.
///    
@DllImport("AVIFIL32")
HRESULT AVIStreamGetFrameClose(IGetFrame pg);

///The <b>AVIStreamOpenFromFile</b> function opens a single stream from a file.
///Params:
///    ppavi = Pointer to a buffer that receives the new stream handle.
///    szFile = Null-terminated string containing the name of the file to open.
///    fccType = Four-character code indicating the type of stream to be opened. Zero indicates that any stream can be opened. The
///              following definitions apply to the data commonly found in AVI streams: <table> <tr> <th>Value </th>
///              <th>Description </th> </tr> <tr> <td>streamtypeAUDIO</td> <td>Indicates an audio stream.</td> </tr> <tr>
///              <td>streamtypeMIDI</td> <td>Indicates a MIDI stream.</td> </tr> <tr> <td>streamtypeTEXT</td> <td>Indicates a text
///              stream.</td> </tr> <tr> <td>streamtypeVIDEO</td> <td>Indicates a video stream.</td> </tr> </table>
///    lParam = Stream of the type specified in <i>fccType</i> to access. This parameter is zero-based; use zero to specify the
///             first occurrence.
///    mode = Access mode to use when opening the file. This function can open only existing streams, so the OF_CREATE mode
///           flag cannot be used. For more information about the available flags for the <i>mode</i> parameter, see the
///           <b>OpenFile</b> function.
///    pclsidHandler = Pointer to a class identifier of the handler you want to use. If the value is <b>NULL</b>, the system chooses one
///                    from the registry based on the file extension or the file RIFF type.
///Returns:
///    Returns zero if successful or an error otherwise.
///    
@DllImport("AVIFIL32")
HRESULT AVIStreamOpenFromFileA(IAVIStream* ppavi, const(PSTR) szFile, uint fccType, int lParam, uint mode, 
                               GUID* pclsidHandler);

///The <b>AVIStreamOpenFromFile</b> function opens a single stream from a file.
///Params:
///    ppavi = Pointer to a buffer that receives the new stream handle.
///    szFile = Null-terminated string containing the name of the file to open.
///    fccType = Four-character code indicating the type of stream to be opened. Zero indicates that any stream can be opened. The
///              following definitions apply to the data commonly found in AVI streams: <table> <tr> <th>Value </th>
///              <th>Description </th> </tr> <tr> <td>streamtypeAUDIO</td> <td>Indicates an audio stream.</td> </tr> <tr>
///              <td>streamtypeMIDI</td> <td>Indicates a MIDI stream.</td> </tr> <tr> <td>streamtypeTEXT</td> <td>Indicates a text
///              stream.</td> </tr> <tr> <td>streamtypeVIDEO</td> <td>Indicates a video stream.</td> </tr> </table>
///    lParam = Stream of the type specified in <i>fccType</i> to access. This parameter is zero-based; use zero to specify the
///             first occurrence.
///    mode = Access mode to use when opening the file. This function can open only existing streams, so the OF_CREATE mode
///           flag cannot be used. For more information about the available flags for the <i>mode</i> parameter, see the
///           <b>OpenFile</b> function.
///    pclsidHandler = Pointer to a class identifier of the handler you want to use. If the value is <b>NULL</b>, the system chooses one
///                    from the registry based on the file extension or the file RIFF type.
///Returns:
///    Returns zero if successful or an error otherwise.
///    
@DllImport("AVIFIL32")
HRESULT AVIStreamOpenFromFileW(IAVIStream* ppavi, const(PWSTR) szFile, uint fccType, int lParam, uint mode, 
                               GUID* pclsidHandler);

///The <b>AVIStreamCreate</b> function creates a stream not associated with any file.
///Params:
///    ppavi = Pointer to a buffer that receives the new stream interface.
///    lParam1 = Stream-handler specific information.
///    lParam2 = Stream-handler specific information.
///    pclsidHandler = Pointer to the class identifier used for the stream.
///Returns:
///    Returns zero if successful or an error otherwise.
///    
@DllImport("AVIFIL32")
HRESULT AVIStreamCreate(IAVIStream* ppavi, int lParam1, int lParam2, GUID* pclsidHandler);

///The <b>AVIMakeCompressedStream</b> function creates a compressed stream from an uncompressed stream and a compression
///filter, and returns the address of a pointer to the compressed stream. This function supports audio and video
///compression.
///Params:
///    ppsCompressed = Pointer to a buffer that receives the compressed stream pointer.
///    ppsSource = Pointer to the stream to be compressed.
///    lpOptions = Pointer to a structure that identifies the type of compression to use and the options to apply. You can specify
///                video compression by identifying an appropriate handler in the AVICOMPRESSOPTIONS structure. For audio
///                compression, specify the compressed data format.
///    pclsidHandler = Pointer to a class identifier used to create the stream.
///Returns:
///    Returns AVIERR_OK if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>AVIERR_NOCOMPRESSOR</b></dt>
///    </dl> </td> <td width="60%"> A suitable compressor cannot be found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>AVIERR_MEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to complete the operation.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>AVIERR_UNSUPPORTED</b></dt> </dl> </td> <td width="60%">
///    Compression is not supported for this type of data. This error might be returned if you try to compress data that
///    is not audio or video. </td> </tr> </table>
///    
@DllImport("AVIFIL32")
HRESULT AVIMakeCompressedStream(IAVIStream* ppsCompressed, IAVIStream ppsSource, AVICOMPRESSOPTIONS* lpOptions, 
                                GUID* pclsidHandler);

///The <b>AVISave</b> function builds a file by combining data streams from other files or from memory.
///Params:
///    szFile = Null-terminated string containing the name of the file to save.
///    pclsidHandler = Pointer to the file handler used to write the file. The file is created by calling the AVIFileOpen function using
///                    this handler. If a handler is not specified, a default is selected from the registry based on the file extension.
///    lpfnCallback = Pointer to a callback function for the save operation.
///    nStreams = Number of streams saved in the file.
///    pfile = Pointer to an AVI stream. This parameter is paired with <i>lpOptions</i>. The parameter pair can be repeated as a
///            variable number of arguments.
///    lpOptions = Pointer to an application-defined AVICOMPRESSOPTIONS structure containing the compression options for the stream
///                referenced by <i>pavi</i>. This parameter is paired with pavi. The parameter pair can be repeated as a variable
///                number of arguments.
///    arg7 = 
///Returns:
///    Returns AVIERR_OK if successful or an error otherwise.
///    
@DllImport("AVIFIL32")
HRESULT AVISaveA(const(PSTR) szFile, GUID* pclsidHandler, AVISAVECALLBACK lpfnCallback, int nStreams, 
                 IAVIStream pfile, AVICOMPRESSOPTIONS* lpOptions);

///The <b>AVISaveV</b> function builds a file by combining data streams from other files or from memory.
///Params:
///    szFile = Null-terminated string containing the name of the file to save.
///    pclsidHandler = Pointer to the file handler used to write the file. The file is created by calling the AVIFileOpen function using
///                    this handler. If a handler is not specified, a default is selected from the registry based on the file extension.
///    lpfnCallback = Pointer to a callback function used to display status information and to let the user cancel the save operation.
///    nStreams = Number of streams to save.
///    ppavi = Pointer to an array of pointers to the <b>AVISTREAM</b> function structures. The array uses one pointer for each
///            stream.
///    plpOptions = Pointer to an array of pointers to AVICOMPRESSOPTIONS structures. The array uses one pointer for each stream.
///Returns:
///    Returns AVIERR_OK if successful or an error otherwise.
///    
@DllImport("AVIFIL32")
HRESULT AVISaveVA(const(PSTR) szFile, GUID* pclsidHandler, AVISAVECALLBACK lpfnCallback, int nStreams, 
                  IAVIStream* ppavi, AVICOMPRESSOPTIONS** plpOptions);

///The <b>AVISave</b> function builds a file by combining data streams from other files or from memory.
///Params:
///    szFile = Null-terminated string containing the name of the file to save.
///    pclsidHandler = Pointer to the file handler used to write the file. The file is created by calling the AVIFileOpen function using
///                    this handler. If a handler is not specified, a default is selected from the registry based on the file extension.
///    lpfnCallback = Pointer to a callback function for the save operation.
///    nStreams = Number of streams saved in the file.
///    pfile = Pointer to an AVI stream. This parameter is paired with <i>lpOptions</i>. The parameter pair can be repeated as a
///            variable number of arguments.
///    lpOptions = Pointer to an application-defined AVICOMPRESSOPTIONS structure containing the compression options for the stream
///                referenced by <i>pavi</i>. This parameter is paired with pavi. The parameter pair can be repeated as a variable
///                number of arguments.
///    arg7 = 
///Returns:
///    Returns AVIERR_OK if successful or an error otherwise.
///    
@DllImport("AVIFIL32")
HRESULT AVISaveW(const(PWSTR) szFile, GUID* pclsidHandler, AVISAVECALLBACK lpfnCallback, int nStreams, 
                 IAVIStream pfile, AVICOMPRESSOPTIONS* lpOptions);

///The <b>AVISaveV</b> function builds a file by combining data streams from other files or from memory.
///Params:
///    szFile = Null-terminated string containing the name of the file to save.
///    pclsidHandler = Pointer to the file handler used to write the file. The file is created by calling the AVIFileOpen function using
///                    this handler. If a handler is not specified, a default is selected from the registry based on the file extension.
///    lpfnCallback = Pointer to a callback function used to display status information and to let the user cancel the save operation.
///    nStreams = Number of streams to save.
///    ppavi = Pointer to an array of pointers to the <b>AVISTREAM</b> function structures. The array uses one pointer for each
///            stream.
///    plpOptions = Pointer to an array of pointers to AVICOMPRESSOPTIONS structures. The array uses one pointer for each stream.
///Returns:
///    Returns AVIERR_OK if successful or an error otherwise.
///    
@DllImport("AVIFIL32")
HRESULT AVISaveVW(const(PWSTR) szFile, GUID* pclsidHandler, AVISAVECALLBACK lpfnCallback, int nStreams, 
                  IAVIStream* ppavi, AVICOMPRESSOPTIONS** plpOptions);

///The <b>AVISaveOptions</b> function retrieves the save options for a file and returns them in a buffer.
///Params:
///    hwnd = Handle to the parent window for the Compression Options dialog box.
///    uiFlags = Flags for displaying the Compression Options dialog box. The following flags are defined. <table> <tr> <th>Value
///              </th> <th>Meaning </th> </tr> <tr> <td>ICMF_CHOOSE_KEYFRAME</td> <td>Displays a Key Frame Every dialog box for
///              the video options. This is the same flag used in the ICCompressorChoose function.</td> </tr> <tr>
///              <td>ICMF_CHOOSE_DATARATE</td> <td>Displays a Data Rate dialog box for the video options. This is the same flag
///              used in ICCompressorChoose.</td> </tr> <tr> <td>ICMF_CHOOSE_PREVIEW</td> <td>Displays a Preview button for the
///              video options. This button previews the compression by using a frame from the stream. This is the same flag used
///              in ICCompressorChoose.</td> </tr> </table>
///    nStreams = Number of streams that have their options set by the dialog box.
///    ppavi = Pointer to an array of stream interface pointers. The <i>nStreams</i> parameter indicates the number of pointers
///            in the array.
///    plpOptions = Pointer to an array of pointers to AVICOMPRESSOPTIONS structures. These structures hold the compression options
///                 set by the dialog box. The <i>nStreams</i> parameter indicates the number of pointers in the array.
///Returns:
///    Returns <b>TRUE</b> if the user pressed OK, <b>FALSE</b> for CANCEL, or an error otherwise.
///    
@DllImport("AVIFIL32")
ptrdiff_t AVISaveOptions(HWND hwnd, uint uiFlags, int nStreams, IAVIStream* ppavi, AVICOMPRESSOPTIONS** plpOptions);

///The <b>AVISaveOptionsFree</b> function frees the resources allocated by the AVISaveOptions function.
///Params:
///    nStreams = Count of the AVICOMPRESSOPTIONS structures referenced in <i>plpOptions</i>.
///    plpOptions = Pointer to an array of pointers to AVICOMPRESSOPTIONS structures. These structures hold the compression options
///                 set by the dialog box. The resources allocated by AVISaveOptions for each of these structures will be freed.
///Returns:
///    Returns AVIERR_OK.
///    
@DllImport("AVIFIL32")
HRESULT AVISaveOptionsFree(int nStreams, AVICOMPRESSOPTIONS** plpOptions);

///The <b>AVIBuildFilter</b> function builds a filter specification that is subsequently used by the GetOpenFileName or
///GetSaveFileName function.
///Params:
///    lpszFilter = Pointer to the buffer containing the filter string.
///    cbFilter = Size, in characters, of buffer pointed to by <i>lpszFilter</i>.
///    fSaving = Flag that indicates whether the filter should include read or write formats. Specify <b>TRUE</b> to include write
///              formats or <b>FALSE</b> to include read formats.
///Returns:
///    Returns AVIERR_OK if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>AVIERR_BUFFERTOOSMALL</b></dt>
///    </dl> </td> <td width="60%"> The buffer size <i>cbFilter</i> was smaller than the generated filter specification.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>AVIERR_MEMORY</b></dt> </dl> </td> <td width="60%"> There was not
///    enough memory to complete the read operation. </td> </tr> </table>
///    
@DllImport("AVIFIL32")
HRESULT AVIBuildFilterW(PWSTR lpszFilter, int cbFilter, BOOL fSaving);

///The <b>AVIBuildFilter</b> function builds a filter specification that is subsequently used by the GetOpenFileName or
///GetSaveFileName function.
///Params:
///    lpszFilter = Pointer to the buffer containing the filter string.
///    cbFilter = Size, in characters, of buffer pointed to by <i>lpszFilter</i>.
///    fSaving = Flag that indicates whether the filter should include read or write formats. Specify <b>TRUE</b> to include write
///              formats or <b>FALSE</b> to include read formats.
///Returns:
///    Returns AVIERR_OK if successful or an error otherwise. Possible error values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>AVIERR_BUFFERTOOSMALL</b></dt>
///    </dl> </td> <td width="60%"> The buffer size <i>cbFilter</i> was smaller than the generated filter specification.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>AVIERR_MEMORY</b></dt> </dl> </td> <td width="60%"> There was not
///    enough memory to complete the read operation. </td> </tr> </table>
///    
@DllImport("AVIFIL32")
HRESULT AVIBuildFilterA(PSTR lpszFilter, int cbFilter, BOOL fSaving);

///The <b>AVIMakeFileFromStreams</b> function constructs an AVIFile interface pointer from separate streams.
///Params:
///    ppfile = Pointer to a buffer that receives the new file interface pointer.
///    nStreams = Count of the number of streams in the array of stream interface pointers referenced by papStreams.
///    papStreams = Pointer to an array of stream interface pointers.
///Returns:
///    Returns zero if successful or an error otherwise.
///    
@DllImport("AVIFIL32")
HRESULT AVIMakeFileFromStreams(IAVIFile* ppfile, int nStreams, IAVIStream* papStreams);

///The <b>AVIMakeStreamFromClipboard</b> function creates an editable stream from stream data on the clipboard.
///Params:
///    cfFormat = Clipboard flag.
///    hGlobal = Handle to stream data on the clipboard.
///    ppstream = Handle to the created stream.
///Returns:
///    Returns zero if successful or an error otherwise.
///    
@DllImport("AVIFIL32")
HRESULT AVIMakeStreamFromClipboard(uint cfFormat, HANDLE hGlobal, IAVIStream* ppstream);

///The <b>AVIPutFileOnClipboard</b> function copies an AVI file to the clipboard.
///Params:
///    pf = Handle to an open AVI file.
///Returns:
///    Returns zero if successful or an error otherwise.
///    
@DllImport("AVIFIL32")
HRESULT AVIPutFileOnClipboard(IAVIFile pf);

///The <b>AVIGetFromClipboard</b> function copies an AVI file from the clipboard.
///Params:
///    lppf = Pointer to the location used to return the handle created for the AVI file.
///Returns:
///    Returns zero if successful or an error otherwise.
///    
@DllImport("AVIFIL32")
HRESULT AVIGetFromClipboard(IAVIFile* lppf);

///The <b>AVIClearClipboard</b> function removes an AVI file from the clipboard.
///Returns:
///    Returns zero if successful or an error otherwise.
///    
@DllImport("AVIFIL32")
HRESULT AVIClearClipboard();

///The <b>CreateEditableStream</b> function creates an editable stream. Use this function before using other stream
///editing functions.
///Params:
///    ppsEditable = Pointer to a buffer that receives the new stream handle.
///    psSource = Handle to the stream supplying data for the new stream. Specify <b>NULL</b> to create an empty editable string
///               that you can copy and paste data into.
///Returns:
///    Returns zero if successful or an error otherwise.
///    
@DllImport("AVIFIL32")
HRESULT CreateEditableStream(IAVIStream* ppsEditable, IAVIStream psSource);

///The <b>EditStreamCut</b> function deletes all or part of an editable stream and creates a temporary editable stream
///from the deleted portion of the stream.
///Params:
///    pavi = Handle to the stream being edited.
///    plStart = Starting position of the data to cut from the stream referenced by <i>pavi</i>.
///    plLength = Amount of data to cut from the stream referenced by <i>pavi</i>.
///    ppResult = Pointer to the handle created for the new stream.
///Returns:
///    Returns zero if successful or an error otherwise.
///    
@DllImport("AVIFIL32")
HRESULT EditStreamCut(IAVIStream pavi, int* plStart, int* plLength, IAVIStream* ppResult);

///The <b>EditStreamCopy</b> function copies an editable stream (or a portion of it) into a temporary stream.
///Params:
///    pavi = Handle to the stream being copied.
///    plStart = Starting position within the stream being copied. The starting position is returned.
///    plLength = Amount of data to copy from the stream referenced by <i>pavi</i>. The length of the copied data is returned.
///    ppResult = Pointer to a buffer that receives the handle created for the new stream.
///Returns:
///    Returns zero if successful or an error otherwise.
///    
@DllImport("AVIFIL32")
HRESULT EditStreamCopy(IAVIStream pavi, int* plStart, int* plLength, IAVIStream* ppResult);

///The <b>EditStreamPaste</b> function copies a stream (or a portion of it) from one stream and pastes it within another
///stream at a specified location.
///Params:
///    pavi = Handle to an editable stream that will receive the copied stream data.
///    plPos = Starting position to paste the data within the destination stream (referenced by <i>pavi</i>).
///    plLength = Pointer to a buffer that receives the amount of data pasted in the stream.
///    pstream = Handle to a stream supplying the data to paste. This stream does not need to be an editable stream.
///    lStart = Starting position of the data to copy within the source stream.
///    lEnd = Amount of data to copy from the source stream. If <i>lLength</i> is -1, the entire stream referenced by
///           <i>pstream</i> is pasted in the other stream.
///Returns:
///    Returns zero if successful or an error otherwise.
///    
@DllImport("AVIFIL32")
HRESULT EditStreamPaste(IAVIStream pavi, int* plPos, int* plLength, IAVIStream pstream, int lStart, int lEnd);

///The <b>EditStreamClone</b> function creates a duplicate editable stream.
///Params:
///    pavi = Handle to an editable stream that will be copied.
///    ppResult = Pointer to a buffer that receives the new stream handle.
///Returns:
///    Returns zero if successful or an error otherwise.
///    
@DllImport("AVIFIL32")
HRESULT EditStreamClone(IAVIStream pavi, IAVIStream* ppResult);

///The <b>EditStreamSetName</b> function assigns a descriptive string to a stream.
///Params:
///    pavi = Handle to an open stream.
///    lpszName = Null-terminated string containing the description of the stream.
///Returns:
///    Returns zero if successful or an error otherwise.
///    
@DllImport("AVIFIL32")
HRESULT EditStreamSetNameA(IAVIStream pavi, const(PSTR) lpszName);

///The <b>EditStreamSetName</b> function assigns a descriptive string to a stream.
///Params:
///    pavi = Handle to an open stream.
///    lpszName = Null-terminated string containing the description of the stream.
///Returns:
///    Returns zero if successful or an error otherwise.
///    
@DllImport("AVIFIL32")
HRESULT EditStreamSetNameW(IAVIStream pavi, const(PWSTR) lpszName);

///The <b>EditStreamSetInfo</b> function changes characteristics of an editable stream.
///Params:
///    pavi = Handle to an open stream.
///    lpInfo = Pointer to an AVISTREAMINFO structure containing new information.
///    cbInfo = Size, in bytes, of the structure pointed to by <i>lpInfo</i>.
///Returns:
///    Returns zero if successful or an error otherwise.
///    
@DllImport("AVIFIL32")
HRESULT EditStreamSetInfoW(IAVIStream pavi, AVISTREAMINFOW* lpInfo, int cbInfo);

///The <b>EditStreamSetInfo</b> function changes characteristics of an editable stream.
///Params:
///    pavi = Handle to an open stream.
///    lpInfo = Pointer to an AVISTREAMINFO structure containing new information.
///    cbInfo = Size, in bytes, of the structure pointed to by <i>lpInfo</i>.
///Returns:
///    Returns zero if successful or an error otherwise.
///    
@DllImport("AVIFIL32")
HRESULT EditStreamSetInfoA(IAVIStream pavi, AVISTREAMINFOA* lpInfo, int cbInfo);

///The <b>MCIWndCreate</b> function registers the MCIWnd window class and creates an MCIWnd window for using MCI
///services. <b>MCIWndCreate</b> can also open an MCI device or file (such as an AVI file) and associate it with the
///MCIWnd window.
///Params:
///    hwndParent = Handle to the parent window.
///    hInstance = Handle to the module instance to associate with the MCIWnd window.
///    dwStyle = Flags defining the window style. In addition to specifying the window styles used with the CreateWindowEx
///              function, you can specify the following styles to use with MCIWnd windows. <table> <tr> <th>Value </th>
///              <th>Meaning </th> </tr> <tr> <td>MCIWNDF_NOAUTOSIZEWINDOW</td> <td>Will not change the dimensions of an MCIWnd
///              window when the image size changes.</td> </tr> <tr> <td>MCIWNDF_NOAUTOSIZEMOVIE</td> <td>Will not change the
///              dimensions of the destination rectangle when an MCIWnd window size changes.</td> </tr> <tr>
///              <td>MCIWNDF_NOERRORDLG</td> <td>Inhibits display of MCI errors to users.</td> </tr> <tr> <td>MCIWNDF_NOMENU</td>
///              <td>Hides the Menu button from view on the toolbar and prohibits users from accessing its pop-up menu.</td> </tr>
///              <tr> <td>MCIWNDF_NOOPEN</td> <td>Hides the open and close commands from the MCIWnd menu and prohibits users from
///              accessing these choices in the pop-up menu.</td> </tr> <tr> <td>MCIWNDF_NOPLAYBAR</td> <td>Hides the toolbar from
///              view and prohibits users from accessing it.</td> </tr> <tr> <td>MCIWNDF_NOTIFYANSI</td> <td>Causes MCIWnd to use
///              an ANSI string instead of a Unicode string when notifying the parent window of device mode changes. This flag is
///              used in combination with MCIWNDF_NOTIFYMODE.</td> </tr> <tr> <td>MCIWNDF_NOTIFYMODE</td> <td>Causes MCIWnd to
///              notify the parent window with an MCIWNDM_NOTIFYMODE message whenever the device changes operating modes. The
///              <i>lParam</i> parameter of this message identifies the new mode, such as MCI_MODE_STOP.</td> </tr> <tr>
///              <td>MCIWNDF_NOTIFYPOS</td> <td>Causes MCIWnd to notify the parent window with an MCIWNDM_NOTIFYPOS message
///              whenever a change in the playback or record position within the content occurs. The <i>lParam</i> parameter of
///              this message contains the new position in the content.</td> </tr> <tr> <td>MCIWNDF_NOTIFYMEDIA</td> <td>Causes
///              MCIWnd to notify the parent window with an MCIWNDM_NOTIFYMEDIA message whenever a new device is used or a data
///              file is opened or closed. The <i>lParam</i> parameter of this message contains a pointer to the new file
///              name.</td> </tr> <tr> <td>MCIWNDF_NOTIFYSIZE</td> <td>Causes MCIWnd to notify the parent window when the MCIWnd
///              window size changes.</td> </tr> <tr> <td>MCIWNDF_NOTIFYERROR</td> <td>Causes MCIWnd to notify the parent window
///              when an MCI error occurs.</td> </tr> <tr> <td>MCIWNDF_NOTIFYALL</td> <td>Causes all MCIWNDF window notification
///              styles to be used.</td> </tr> <tr> <td>MCIWNDF_RECORD</td> <td>Adds a Record button to the toolbar and adds a new
///              file command to the menu if the MCI device has recording capability.</td> </tr> <tr> <td>MCIWNDF_SHOWALL</td>
///              <td>Causes all MCIWNDF_SHOW styles to be used.</td> </tr> <tr> <td>MCIWNDF_SHOWMODE</td> <td>Displays the current
///              mode of the MCI device in the window title bar. For a list of device modes, see the MCIWndGetMode macro.</td>
///              </tr> <tr> <td>MCIWNDF_SHOWNAME</td> <td>Displays the name of the open MCI device or data file in the MCIWnd
///              window title bar.</td> </tr> <tr> <td>MCIWNDF_SHOWPOS</td> <td>Displays the current position within the content
///              of the MCI device in the window title bar.</td> </tr> </table>
///    szFile = Null-terminated string indicating the name of an MCI device or data file to open.
///Returns:
///    Returns the handle to an MCI window if successful or zero otherwise.
///    
@DllImport("MSVFW32")
HWND MCIWndCreateA(HWND hwndParent, HINSTANCE hInstance, uint dwStyle, const(PSTR) szFile);

///The <b>MCIWndCreate</b> function registers the MCIWnd window class and creates an MCIWnd window for using MCI
///services. <b>MCIWndCreate</b> can also open an MCI device or file (such as an AVI file) and associate it with the
///MCIWnd window.
///Params:
///    hwndParent = Handle to the parent window.
///    hInstance = Handle to the module instance to associate with the MCIWnd window.
///    dwStyle = Flags defining the window style. In addition to specifying the window styles used with the CreateWindowEx
///              function, you can specify the following styles to use with MCIWnd windows. <table> <tr> <th>Value </th>
///              <th>Meaning </th> </tr> <tr> <td>MCIWNDF_NOAUTOSIZEWINDOW</td> <td>Will not change the dimensions of an MCIWnd
///              window when the image size changes.</td> </tr> <tr> <td>MCIWNDF_NOAUTOSIZEMOVIE</td> <td>Will not change the
///              dimensions of the destination rectangle when an MCIWnd window size changes.</td> </tr> <tr>
///              <td>MCIWNDF_NOERRORDLG</td> <td>Inhibits display of MCI errors to users.</td> </tr> <tr> <td>MCIWNDF_NOMENU</td>
///              <td>Hides the Menu button from view on the toolbar and prohibits users from accessing its pop-up menu.</td> </tr>
///              <tr> <td>MCIWNDF_NOOPEN</td> <td>Hides the open and close commands from the MCIWnd menu and prohibits users from
///              accessing these choices in the pop-up menu.</td> </tr> <tr> <td>MCIWNDF_NOPLAYBAR</td> <td>Hides the toolbar from
///              view and prohibits users from accessing it.</td> </tr> <tr> <td>MCIWNDF_NOTIFYANSI</td> <td>Causes MCIWnd to use
///              an ANSI string instead of a Unicode string when notifying the parent window of device mode changes. This flag is
///              used in combination with MCIWNDF_NOTIFYMODE.</td> </tr> <tr> <td>MCIWNDF_NOTIFYMODE</td> <td>Causes MCIWnd to
///              notify the parent window with an MCIWNDM_NOTIFYMODE message whenever the device changes operating modes. The
///              <i>lParam</i> parameter of this message identifies the new mode, such as MCI_MODE_STOP.</td> </tr> <tr>
///              <td>MCIWNDF_NOTIFYPOS</td> <td>Causes MCIWnd to notify the parent window with an MCIWNDM_NOTIFYPOS message
///              whenever a change in the playback or record position within the content occurs. The <i>lParam</i> parameter of
///              this message contains the new position in the content.</td> </tr> <tr> <td>MCIWNDF_NOTIFYMEDIA</td> <td>Causes
///              MCIWnd to notify the parent window with an MCIWNDM_NOTIFYMEDIA message whenever a new device is used or a data
///              file is opened or closed. The <i>lParam</i> parameter of this message contains a pointer to the new file
///              name.</td> </tr> <tr> <td>MCIWNDF_NOTIFYSIZE</td> <td>Causes MCIWnd to notify the parent window when the MCIWnd
///              window size changes.</td> </tr> <tr> <td>MCIWNDF_NOTIFYERROR</td> <td>Causes MCIWnd to notify the parent window
///              when an MCI error occurs.</td> </tr> <tr> <td>MCIWNDF_NOTIFYALL</td> <td>Causes all MCIWNDF window notification
///              styles to be used.</td> </tr> <tr> <td>MCIWNDF_RECORD</td> <td>Adds a Record button to the toolbar and adds a new
///              file command to the menu if the MCI device has recording capability.</td> </tr> <tr> <td>MCIWNDF_SHOWALL</td>
///              <td>Causes all MCIWNDF_SHOW styles to be used.</td> </tr> <tr> <td>MCIWNDF_SHOWMODE</td> <td>Displays the current
///              mode of the MCI device in the window title bar. For a list of device modes, see the MCIWndGetMode macro.</td>
///              </tr> <tr> <td>MCIWNDF_SHOWNAME</td> <td>Displays the name of the open MCI device or data file in the MCIWnd
///              window title bar.</td> </tr> <tr> <td>MCIWNDF_SHOWPOS</td> <td>Displays the current position within the content
///              of the MCI device in the window title bar.</td> </tr> </table>
///    szFile = Null-terminated string indicating the name of an MCI device or data file to open.
///Returns:
///    Returns the handle to an MCI window if successful or zero otherwise.
///    
@DllImport("MSVFW32")
HWND MCIWndCreateW(HWND hwndParent, HINSTANCE hInstance, uint dwStyle, const(PWSTR) szFile);

///The <b>MCIWndRegisterClass</b> function registers the MCI window class MCIWND_WINDOW_CLASS.
///Returns:
///    Returns zero if successful.
///    
@DllImport("MSVFW32")
BOOL MCIWndRegisterClass();

///The <b>capCreateCaptureWindow</b> function creates a capture window.
///Params:
///    lpszWindowName = Null-terminated string containing the name used for the capture window.
///    dwStyle = Window styles used for the capture window. Window styles are described with the CreateWindowEx function.
///    x = The x-coordinate of the upper left corner of the capture window.
///    y = The y-coordinate of the upper left corner of the capture window.
///    nWidth = Width of the capture window.
///    nHeight = Height of the capture window.
///    hwndParent = Handle to the parent window.
///    nID = Window identifier.
///Returns:
///    Returns a handle of the capture window if successful or <b>NULL</b> otherwise.
///    
@DllImport("AVICAP32")
HWND capCreateCaptureWindowA(const(PSTR) lpszWindowName, uint dwStyle, int x, int y, int nWidth, int nHeight, 
                             HWND hwndParent, int nID);

///The <b>capGetDriverDescription</b> function retrieves the version description of the capture driver.
///Params:
///    wDriverIndex = Index of the capture driver. The index can range from 0 through 9. Plug-and-Play capture drivers are enumerated
///                   first, followed by capture drivers listed in the registry, which are then followed by capture drivers listed in
///                   SYSTEM.INI.
///    lpszName = Pointer to a buffer containing a null-terminated string corresponding to the capture driver name.
///    cbName = Length, in bytes, of the buffer pointed to by <i>lpszName</i>.
///    lpszVer = Pointer to a buffer containing a null-terminated string corresponding to the description of the capture driver.
///    cbVer = Length, in bytes, of the buffer pointed to by <i>lpszVer</i>.
///Returns:
///    Returns <b>TRUE</b> if successful or <b>FALSE</b> otherwise.
///    
@DllImport("AVICAP32")
BOOL capGetDriverDescriptionA(uint wDriverIndex, PSTR lpszName, int cbName, PSTR lpszVer, int cbVer);

///The <b>capCreateCaptureWindow</b> function creates a capture window.
///Params:
///    lpszWindowName = Null-terminated string containing the name used for the capture window.
///    dwStyle = Window styles used for the capture window. Window styles are described with the CreateWindowEx function.
///    x = The x-coordinate of the upper left corner of the capture window.
///    y = The y-coordinate of the upper left corner of the capture window.
///    nWidth = Width of the capture window.
///    nHeight = Height of the capture window.
///    hwndParent = Handle to the parent window.
///    nID = Window identifier.
///Returns:
///    Returns a handle of the capture window if successful or <b>NULL</b> otherwise.
///    
@DllImport("AVICAP32")
HWND capCreateCaptureWindowW(const(PWSTR) lpszWindowName, uint dwStyle, int x, int y, int nWidth, int nHeight, 
                             HWND hwndParent, int nID);

///The <b>capGetDriverDescription</b> function retrieves the version description of the capture driver.
///Params:
///    wDriverIndex = Index of the capture driver. The index can range from 0 through 9. Plug-and-Play capture drivers are enumerated
///                   first, followed by capture drivers listed in the registry, which are then followed by capture drivers listed in
///                   SYSTEM.INI.
///    lpszName = Pointer to a buffer containing a null-terminated string corresponding to the capture driver name.
///    cbName = Length, in bytes, of the buffer pointed to by <i>lpszName</i>.
///    lpszVer = Pointer to a buffer containing a null-terminated string corresponding to the description of the capture driver.
///    cbVer = Length, in bytes, of the buffer pointed to by <i>lpszVer</i>.
///Returns:
///    Returns <b>TRUE</b> if successful or <b>FALSE</b> otherwise.
///    
@DllImport("AVICAP32")
BOOL capGetDriverDescriptionW(uint wDriverIndex, PWSTR lpszName, int cbName, PWSTR lpszVer, int cbVer);

///The <b>GetOpenFileNamePreview</b> function selects a file by using the Open dialog box. The dialog box also allows
///the user to preview the currently specified AVI file. This function augments the capability found in the
///GetOpenFileName function.
///Params:
///    lpofn = Pointer to an <b>OPENFILENAME</b> structure used to initialize the dialog box. On return, the structure contains
///            information about the user's file selection.
///Returns:
///    Returns a handle to the selected file.
///    
@DllImport("MSVFW32")
BOOL GetOpenFileNamePreviewA(OPENFILENAMEA* lpofn);

///The <b>GetSaveFileNamePreview</b> function selects a file by using the Save As dialog box. The dialog box also allows
///the user to preview the currently specified file. This function augments the capability found in the GetSaveFileName
///function.
///Params:
///    lpofn = Pointer to an <b>OPENFILENAME</b> structure used to initialize the dialog box. On return, the structure contains
///            information about the user's file selection.
///Returns:
///    Returns a handle to the selected file.
///    
@DllImport("MSVFW32")
BOOL GetSaveFileNamePreviewA(OPENFILENAMEA* lpofn);

///The <b>GetOpenFileNamePreview</b> function selects a file by using the Open dialog box. The dialog box also allows
///the user to preview the currently specified AVI file. This function augments the capability found in the
///GetOpenFileName function.
///Params:
///    lpofn = Pointer to an <b>OPENFILENAME</b> structure used to initialize the dialog box. On return, the structure contains
///            information about the user's file selection.
///Returns:
///    Returns a handle to the selected file.
///    
@DllImport("MSVFW32")
BOOL GetOpenFileNamePreviewW(OPENFILENAMEW* lpofn);

///The <b>GetSaveFileNamePreview</b> function selects a file by using the Save As dialog box. The dialog box also allows
///the user to preview the currently specified file. This function augments the capability found in the GetSaveFileName
///function.
///Params:
///    lpofn = Pointer to an <b>OPENFILENAME</b> structure used to initialize the dialog box. On return, the structure contains
///            information about the user's file selection.
///Returns:
///    Returns a handle to the selected file.
///    
@DllImport("MSVFW32")
BOOL GetSaveFileNamePreviewW(OPENFILENAMEW* lpofn);

///The <b>mmTaskCreate</b> function is deprecated. Applications should not use this function.
///Params:
///    lpfn = Reserved.
///    lph = Reserved.
@DllImport("WINMM")
uint mmTaskCreate(LPTASKCALLBACK lpfn, HANDLE* lph, size_t dwInst);

///The <b>mmTaskBlock</b> function is deprecated. Applications should not use this function.
@DllImport("WINMM")
void mmTaskBlock(uint h);

///The <b>mmTaskSignal</b> function is deprecated. Applications should not use this function.
@DllImport("WINMM")
BOOL mmTaskSignal(uint h);

///The <b>mmTaskYield</b> function is deprecated. Applications should not use this function.
@DllImport("WINMM")
void mmTaskYield();

///The <b>mmGetCurrentTask</b> function is deprecated. Applications should not use this function.
@DllImport("WINMM")
uint mmGetCurrentTask();


// Interfaces

@GUID("00000001-0000-0010-8000-00AA00389B71")
struct KSDATAFORMAT_SUBTYPE_PCM;

@GUID("00000003-0000-0010-8000-00AA00389B71")
struct KSDATAFORMAT_SUBTYPE_IEEE_FLOAT;

@GUID("00000000-0000-0010-8000-00AA00389B71")
struct KSDATAFORMAT_SUBTYPE_WAVEFORMATEX;

///The <b>IAVIStream</b> interface supports creating and manipulating data streams within a file. Uses
///IUnknown::QueryInterface, IUnknown::AddRef, IUnknown::Release in addition to the following custom methods:
interface IAVIStream : IUnknown
{
    ///The <b>Create</b> method initializes a stream handler that is not associated with any file. Called when an
    ///application uses the AVIStreamCreate function.
    ///Params:
    ///    lParam1 = Stream handler-specific data.
    ///    lParam2 = Stream handler-specific data.
    ///Returns:
    ///    Returns the HRESULT defined by OLE.
    ///    
    HRESULT Create(LPARAM lParam1, LPARAM lParam2);
    ///The <b>Info</b> method fills and returns an AVISTREAMINFO structure with information about a stream. Called when
    ///an application uses the AVIStreamInfo function.
    ///Params:
    ///    psi = Pointer to an AVISTREAMINFO structure to contain stream information.
    ///    lSize = Size, in bytes, of the structure specified by <i>psi</i>.
    ///Returns:
    ///    Returns the HRESULT defined by OLE.
    ///    
    HRESULT Info(AVISTREAMINFOW* psi, int lSize);
    ///The <b>FindSample</b> method obtains the position in a stream of a key frame or a nonempty frame. Called when an
    ///application uses the AVIStreamFindSample function.
    ///Params:
    ///    lPos = Position of the sample or frame.
    ///    lFlags = Applicable flags. The following values are defined. <table> <tr> <th>Value </th> <th>Description </th> </tr>
    ///             <tr> <td>FIND_ANY</td> <td>Searches for a nonempty frame.</td> </tr> <tr> <td>FIND_FORMAT</td> <td>Searches
    ///             for a format change.</td> </tr> <tr> <td>FIND_KEY</td> <td>Searches for a key frame.</td> </tr> <tr>
    ///             <td>FIND_NEXT</td> <td>Searches forward through a stream, beginning with the current frame.</td> </tr> <tr>
    ///             <td>FIND_PREV</td> <td>Searches backward through a stream, beginning with the current frame.</td> </tr>
    ///             </table> The FIND_ANY, FIND_KEY, and FIND_FORMAT flags are mutually exclusive, as are the FIND_NEXT and
    ///             FIND_PREV flags. You must specify one value from each group.
    ///Returns:
    ///    Returns the location of the key frame corresponding to the frame specified by the application.
    ///    
    int     FindSample(int lPos, int lFlags);
    ///The <b>ReadFormat</b> method obtains format information from a stream. Fills and returns a structure with the
    ///data in an application-defined buffer. If no buffer is supplied, determines the buffer size needed to retrieve
    ///the buffer of format data. Called when an application uses the AVIStreamReadFormat function.
    ///Params:
    ///    lPos = Position of the sample or frame.
    ///    lpFormat = Pointer to the buffer for the format data. Specify <b>NULL</b> to request the required size of the buffer.
    ///    lpcbFormat = Pointer to a buffer that receives the size, in bytes, of the buffer specified by <i>lpFormat</i>. When this
    ///                 method is called, the contents of this parameter indicates the size of the buffer specified by
    ///                 <i>lpFormat</i>. When this method returns control to the application, the contents of this parameter
    ///                 specifies the amount of data read or the required size of the buffer.
    ///Returns:
    ///    Returns the HRESULT defined by OLE.
    ///    
    HRESULT ReadFormat(int lPos, void* lpFormat, int* lpcbFormat);
    ///The <b>SetFormat</b> method sets format information in a stream. Called when an application uses the
    ///AVIStreamSetFormat function.
    ///Params:
    ///    lPos = Pointer to the interface to a stream.
    ///    lpFormat = Pointer to the buffer for the format data.
    ///    cbFormat = Address containing the size, in bytes, of the buffer specified by <i>lpFormat</i>.
    ///Returns:
    ///    Returns the HRESULT defined by OLE.
    ///    
    HRESULT SetFormat(int lPos, void* lpFormat, int cbFormat);
    ///The <b>Read</b> method reads data from a stream and copies it to an application-defined buffer. If no buffer is
    ///supplied, it determines the buffer size needed to retrieve the next buffer of data. Called when an application
    ///uses the AVIStreamRead function.
    ///Params:
    ///    lStart = Starting sample or frame number to read.
    ///    lSamples = Number of samples to read.
    ///    lpBuffer = Pointer to the application-defined buffer to contain the stream data. You can also specify <b>NULL</b> to
    ///               request the required size of the buffer. Many applications precede each read operation with a query for the
    ///               buffer size to see how large a buffer is needed.
    ///    cbBuffer = Size, in bytes, of the buffer specified by <i>lpBuffer</i>.
    ///    plBytes = Pointer to a buffer that receives the number of bytes read.
    ///    plSamples = Pointer to a buffer that receives the number of samples read.
    ///Returns:
    ///    Returns AVIERR_OK if successful or AVIERR_BUFFERTOOSMALL if the buffer is not large enough to hold the data.
    ///    If successful, <b>Read</b> also returns either a buffer of data with the number of frames (samples) included
    ///    in the buffer or the required buffer size, in bytes.
    ///    
    HRESULT Read(int lStart, int lSamples, void* lpBuffer, int cbBuffer, int* plBytes, int* plSamples);
    ///The <b>Write</b> method writes data to a stream. Called when an application uses the AVIStreamWrite function.
    ///Params:
    ///    lStart = Starting sample or frame number to write.
    ///    lSamples = Number of samples to write.
    ///    lpBuffer = Pointer to the buffer for the data.
    ///    cbBuffer = Size, in bytes, of the buffer specified by <i>lpBuffer</i>.
    ///    dwFlags = Applicable flags. The AVIF_KEYFRAME flag is defined and indicates that this frame contains all the
    ///              information needed for a complete image.
    ///    plSampWritten = Pointer to a buffer used to contain the number of samples written.
    ///    plBytesWritten = Pointer to a buffer that receives the number of bytes written.
    ///Returns:
    ///    Returns the HRESULT defined by OLE.
    ///    
    HRESULT Write(int lStart, int lSamples, void* lpBuffer, int cbBuffer, uint dwFlags, int* plSampWritten, 
                  int* plBytesWritten);
    ///The <b>Delete</b> method deletes data from a stream.
    ///Params:
    ///    lStart = Starting sample or frame number to delete.
    ///    lSamples = Number of samples to delete.
    ///Returns:
    ///    Returns the HRESULT defined by OLE.
    ///    
    HRESULT Delete(int lStart, int lSamples);
    ///The <b>ReadData</b> method reads data headers of a stream. Called when an application uses the AVIStreamReadData
    ///function.
    ///Params:
    ///    fcc = Four-character code of the stream header to read.
    ///    lp = Pointer to the buffer to contain the header data.
    ///    lpcb = Size, in bytes, of the buffer specified by <i>lpBuffer</i>. When this method returns control to the
    ///           application, the contents of this parameter specifies the amount of data read.
    ///Returns:
    ///    Returns the HRESULT defined by OLE.
    ///    
    HRESULT ReadData(uint fcc, void* lp, int* lpcb);
    ///The <b>WriteData</b> method writes headers for a stream. Called when an application uses the AVIStreamWriteData
    ///function.
    ///Params:
    ///    fcc = Four-character code of the stream header to write.
    ///    lp = Pointer to the buffer that contains the header data to write.
    ///    cb = Size, in bytes, of the buffer specified by <i>lpBuffer</i>.
    ///Returns:
    ///    Returns the HRESULT defined by OLE.
    ///    
    HRESULT WriteData(uint fcc, void* lp, int cb);
    HRESULT SetInfo(AVISTREAMINFOW* lpInfo, int cbInfo);
}

///The <b>IAVIStreaming</b> interface supports preparing open data streams for playback in streaming operations. Uses
///IUnknown::QueryInterface, IUnknown::AddRef, IUnknown::Release in addition to the following custom methods:
interface IAVIStreaming : IUnknown
{
    ///The <b>Begin</b> method prepares for the streaming operation. Called when an application uses the
    ///AVIStreamBeginStreaming function.
    ///Params:
    ///    lStart = Starting frame for streaming.
    ///    lEnd = Ending frame for streaming.
    ///    lRate = Speed at which the file is read relative to its normal playback rate. Normal speed is 1000. Larger values
    ///            indicate faster speeds; smaller values indicate slower speeds.
    ///Returns:
    ///    Returns the HRESULT defined by OLE.
    ///    
    HRESULT Begin(int lStart, int lEnd, int lRate);
    ///The <b>End</b> method ends the streaming operation. Called when an application uses the AVIStreamEndStreaming
    ///function.
    ///Returns:
    ///    Returns the HRESULT defined by OLE.
    ///    
    HRESULT End();
}

///The <b>IAVIEditStream</b> interface supports manipulating and modifying editable streams. Uses
///IUnknown::QueryInterface, IUnknown::AddRef, IUnknown::Release in addition to the following custom methods:
interface IAVIEditStream : IUnknown
{
    ///The <b>Cut</b> method removes a portion of a stream and places it in a temporary stream. Called when an
    ///application uses the EditStreamCut function.
    ///Params:
    ///    plStart = Pointer to a buffer that receives the starting position of the operation.
    ///    plLength = Pointer to a buffer that receives the length, in frames, of the operation.
    ///    ppResult = Pointer to a buffer that receives a pointer to the interface to the new stream.
    ///Returns:
    ///    Returns the HRESULT defined by OLE.
    ///    
    HRESULT Cut(int* plStart, int* plLength, IAVIStream* ppResult);
    ///The <b>Copy</b> method copies a stream or a portion of it to a temporary stream. Called when an application uses
    ///the EditStreamCopy function.
    ///Params:
    ///    plStart = Pointer to a buffer that receives the starting position of the operation.
    ///    plLength = Pointer to a buffer that receives the length, in frames, of the operation.
    ///    ppResult = Pointer to a buffer that receives a pointer to the interface to the new stream.
    ///Returns:
    ///    Returns the HRESULT defined by OLE.
    ///    
    HRESULT Copy(int* plStart, int* plLength, IAVIStream* ppResult);
    ///The <b>Paste</b> method copies a stream or a portion of it in another stream. Called when an application uses the
    ///EditStreamPaste function.
    ///Params:
    ///    plPos = Pointer to a buffer that receives the starting position of the operation.
    ///    plLength = Pointer to a buffer that receives the length, in bytes, of the data to paste from the source stream.
    ///    pstream = Pointer to the interface to the source stream.
    ///    lStart = Starting position of the copy operation within the source stream.
    ///    lEnd = Ending position of the copy operation within the source stream.
    ///Returns:
    ///    Returns the HRESULT defined by OLE.
    ///    
    HRESULT Paste(int* plPos, int* plLength, IAVIStream pstream, int lStart, int lEnd);
    ///The <b>Clone</b> method duplicates a stream. Called when an application uses the EditStreamClone function.
    ///Params:
    ///    ppResult = Pointer to a buffer that receives a pointer to the interface to the new stream.
    ///Returns:
    ///    The method returns the HRESULT defined by OLE.
    ///    
    HRESULT Clone(IAVIStream* ppResult);
    ///The <b>SetInfo</b> method changes the characteristics of a stream. Called when an application uses the
    ///EditStreamSetInfo function.
    ///Params:
    ///    lpInfo = Pointer to an AVISTREAMINFO structure containing the new stream characteristics.
    ///    cbInfo = Size, in bytes, of the buffer.
    ///Returns:
    ///    Returns the HRESULT defined by OLE.
    ///    
    HRESULT SetInfo(AVISTREAMINFOW* lpInfo, int cbInfo);
}

interface IAVIPersistFile : IPersistFile
{
    HRESULT Reserved1();
}

///The <b>IAVIFile</b> interface supports opening and manipulating files and file headers, and creating and obtaining
///stream interfaces. Uses IUnknown::QueryInterface, IUnknown::AddRef, and IUnknown::Release in addition to the
///following custom methods:
interface IAVIFile : IUnknown
{
    ///The <b>Info</b> method returns with information about an AVI file. Called when an application uses the
    ///AVIFileInfo function.
    ///Params:
    ///    pfi = A pointer to an AVIFILEINFO structure. The method fills the structure with information about the file.
    ///    lSize = The size, in bytes, of the buffer specified by <i>pfi</i>.
    ///Returns:
    ///    Returns the HRESULT defined by OLE.
    ///    
    HRESULT Info(AVIFILEINFOW* pfi, int lSize);
    ///The <b>GetStream</b> method opens a stream by accessing it in a file. Called when an application uses the
    ///AVIFileGetStream function.
    ///Params:
    ///    ppStream = Pointer to a buffer that receives a pointer to the interface to a stream.
    ///    fccType = Four-character code indicating the type of stream to locate.
    ///    lParam = Stream number.
    ///Returns:
    ///    Returns the HRESULT defined by OLE.
    ///    
    HRESULT GetStream(IAVIStream* ppStream, uint fccType, int lParam);
    ///The <b>CreateStream</b> method creates a stream for writing. Called when an application uses the
    ///AVIFileCreateStream function.
    ///Params:
    ///    ppStream = Pointer to a buffer that receives a pointer to the interface to the new stream.
    ///    psi = Pointer to an AVISTREAMINFO structure defining the stream to create.
    ///Returns:
    ///    Returns HRESULT defined by OLE.
    ///    
    HRESULT CreateStream(IAVIStream* ppStream, AVISTREAMINFOW* psi);
    ///The <b>WriteData</b> method writes file headers. Called when an application uses the AVIFileWriteData function.
    ///Params:
    ///    ckid = A chunk ID.
    ///    lpData = A pointer specifying the memory from which the data is written.
    ///    cbData = A LONG specifying the number of bytes to write.
    ///Returns:
    ///    Returns the HRESULT defined by OLE.
    ///    
    HRESULT WriteData(uint ckid, void* lpData, int cbData);
    ///The <b>ReadData</b> method reads file headers. Called when an application uses the AVIFileReadData function.
    ///Params:
    ///    ckid = A chunk identfier.
    ///    lpData = A pointer specifying the memory into which the data is read.
    ///    lpcbData = A pointer to a LONG specifying the number of bytes read.
    ///Returns:
    ///    Returns the HRESULT defined by OLE.
    ///    
    HRESULT ReadData(uint ckid, void* lpData, int* lpcbData);
    ///The <b>EndRecord</b> method writes the "REC" chunk in a tightly interleaved AVI file (having a one-to-one
    ///interleave factor of audio to video). Called when an application uses the AVIFileEndRecord function.
    ///Returns:
    ///    Returns the HRESULT defined by OLE.
    ///    
    HRESULT EndRecord();
    HRESULT DeleteStream(uint fccType, int lParam);
}

///The <b>IGetFrame</b> interface supports extracting, decompressing, and displaying individual frames from an open
///stream. Uses IUnknown::QueryInterface, IUnknown::AddRef, IUnknown::Release in addition to the following custom
///methods:
interface IGetFrame : IUnknown
{
    ///The <b>GetFrame</b> method retrieves a decompressed copy of a frame from a stream. Called when an application
    ///uses the AVIStreamGetFrame function.
    ///Params:
    ///    lPos = Frame to copy and decompress.
    ///Returns:
    ///    Returns the address of the decompressed frame data.
    ///    
    void*   GetFrame(int lPos);
    ///The <b>Begin</b> method prepares to extract and decompress copies of frames from a stream. Called when an
    ///application uses the AVIStreamGetFrameOpen function.
    ///Params:
    ///    lStart = Starting frame for extracting and decompressing.
    ///    lEnd = Ending frame for extracting and decompressing.
    ///    lRate = Speed at which the file is read relative to its normal playback rate. Normal speed is 1000. Larger values
    ///            indicate faster speeds; smaller values indicate slower speeds.
    ///Returns:
    ///    Returns the HRESULT defined by OLE.
    ///    
    HRESULT Begin(int lStart, int lEnd, int lRate);
    ///The <b>End</b> method ends frame extraction and decompression. Called when an application uses the
    ///AVIStreamGetFrameClose function.
    ///Returns:
    ///    Returns the HRESULT defined by OLE.
    ///    
    HRESULT End();
    ///The <b>SetFormat</b> method sets the decompressed image format of the frames being extracted and optionally
    ///provides a buffer for the decompression operation.
    ///Params:
    ///    lpbi = Pointer to a BITMAPINFOHEADER structure defining the decompressed image format. You can also specify
    ///           <b>NULL</b> or the value <code>((LPBITMAPINFOHEADER) 1)</code> for this parameter. <b>NULL</b> causes the
    ///           decompressor to choose a format that is appropriate for editing (normally a 24-bit image depth format). The
    ///           value <code>((LPBITMAPINFOHEADER) 1)</code> causes the decompressor to choose a format appropriate for the
    ///           current display mode.
    ///    lpBits = Pointer to a buffer to contain the decompressed image data. Specify <b>NULL</b> to have this method allocate
    ///             a buffer.
    ///    x = The x-coordinate of the destination rectangle within the DIB specified by <i>lpbi</i>. This parameter is used
    ///        when <i>lpBits</i> is not <b>NULL</b>.
    ///    y = The y-coordinate of the destination rectangle within the DIB specified by <i>lpbi</i>. This parameter is used
    ///        when <i>lpBits</i> is not <b>NULL</b>.
    ///    dx = Width of the destination rectangle. This parameter is used when <i>lpBits</i> is not <b>NULL</b>.
    ///    dy = Height of the destination rectangle. This parameter is used when <i>lpBits</i> is not <b>NULL</b>.
    ///Returns:
    ///    Returns <b>NOERROR</b> if successful, <b>E_OUTOFMEMORY</b> if the decompressed image is larger than the
    ///    buffer size, or <b>E_FAIL</b> otherwise.
    ///    
    HRESULT SetFormat(BITMAPINFOHEADER* lpbi, void* lpBits, int x, int y, int dx, int dy);
}


// GUIDs

const GUID CLSID_KSDATAFORMAT_SUBTYPE_IEEE_FLOAT   = GUIDOF!KSDATAFORMAT_SUBTYPE_IEEE_FLOAT;
const GUID CLSID_KSDATAFORMAT_SUBTYPE_PCM          = GUIDOF!KSDATAFORMAT_SUBTYPE_PCM;
const GUID CLSID_KSDATAFORMAT_SUBTYPE_WAVEFORMATEX = GUIDOF!KSDATAFORMAT_SUBTYPE_WAVEFORMATEX;

