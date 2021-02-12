module windows.opengl;

public import windows.gdi;
public import windows.systemservices;

extern(Windows):

struct PIXELFORMATDESCRIPTOR
{
    ushort nSize;
    ushort nVersion;
    uint dwFlags;
    ubyte iPixelType;
    ubyte cColorBits;
    ubyte cRedBits;
    ubyte cRedShift;
    ubyte cGreenBits;
    ubyte cGreenShift;
    ubyte cBlueBits;
    ubyte cBlueShift;
    ubyte cAlphaBits;
    ubyte cAlphaShift;
    ubyte cAccumBits;
    ubyte cAccumRedBits;
    ubyte cAccumGreenBits;
    ubyte cAccumBlueBits;
    ubyte cAccumAlphaBits;
    ubyte cDepthBits;
    ubyte cStencilBits;
    ubyte cAuxBuffers;
    ubyte iLayerType;
    ubyte bReserved;
    uint dwLayerMask;
    uint dwVisibleMask;
    uint dwDamageMask;
}

struct POINTFLOAT
{
    float x;
    float y;
}

struct GLYPHMETRICSFLOAT
{
    float gmfBlackBoxX;
    float gmfBlackBoxY;
    POINTFLOAT gmfptGlyphOrigin;
    float gmfCellIncX;
    float gmfCellIncY;
}

struct LAYERPLANEDESCRIPTOR
{
    ushort nSize;
    ushort nVersion;
    uint dwFlags;
    ubyte iPixelType;
    ubyte cColorBits;
    ubyte cRedBits;
    ubyte cRedShift;
    ubyte cGreenBits;
    ubyte cGreenShift;
    ubyte cBlueBits;
    ubyte cBlueShift;
    ubyte cAlphaBits;
    ubyte cAlphaShift;
    ubyte cAccumBits;
    ubyte cAccumRedBits;
    ubyte cAccumGreenBits;
    ubyte cAccumBlueBits;
    ubyte cAccumAlphaBits;
    ubyte cDepthBits;
    ubyte cStencilBits;
    ubyte cAuxBuffers;
    ubyte iLayerPlane;
    ubyte bReserved;
    uint crTransparent;
}

@DllImport("GDI32.dll")
int ChoosePixelFormat(HDC hdc, const(PIXELFORMATDESCRIPTOR)* ppfd);

@DllImport("GDI32.dll")
int DescribePixelFormat(HDC hdc, int iPixelFormat, uint nBytes, char* ppfd);

@DllImport("GDI32.dll")
int GetPixelFormat(HDC hdc);

@DllImport("GDI32.dll")
BOOL SetPixelFormat(HDC hdc, int format, const(PIXELFORMATDESCRIPTOR)* ppfd);

@DllImport("GDI32.dll")
uint GetEnhMetaFilePixelFormat(int hemf, uint cbBuffer, char* ppfd);

@DllImport("OPENGL32.dll")
BOOL wglCopyContext(int param0, int param1, uint param2);

@DllImport("OPENGL32.dll")
int wglCreateContext(HDC param0);

@DllImport("OPENGL32.dll")
int wglCreateLayerContext(HDC param0, int param1);

@DllImport("OPENGL32.dll")
BOOL wglDeleteContext(int param0);

@DllImport("OPENGL32.dll")
int wglGetCurrentContext();

@DllImport("OPENGL32.dll")
HDC wglGetCurrentDC();

@DllImport("OPENGL32.dll")
PROC wglGetProcAddress(const(char)* param0);

@DllImport("OPENGL32.dll")
BOOL wglMakeCurrent(HDC param0, int param1);

@DllImport("OPENGL32.dll")
BOOL wglShareLists(int param0, int param1);

@DllImport("OPENGL32.dll")
BOOL wglUseFontBitmapsA(HDC param0, uint param1, uint param2, uint param3);

@DllImport("OPENGL32.dll")
BOOL wglUseFontBitmapsW(HDC param0, uint param1, uint param2, uint param3);

@DllImport("GDI32.dll")
BOOL SwapBuffers(HDC param0);

@DllImport("OPENGL32.dll")
BOOL wglUseFontOutlinesA(HDC param0, uint param1, uint param2, uint param3, float param4, float param5, int param6, GLYPHMETRICSFLOAT* param7);

@DllImport("OPENGL32.dll")
BOOL wglUseFontOutlinesW(HDC param0, uint param1, uint param2, uint param3, float param4, float param5, int param6, GLYPHMETRICSFLOAT* param7);

@DllImport("OPENGL32.dll")
BOOL wglDescribeLayerPlane(HDC param0, int param1, int param2, uint param3, LAYERPLANEDESCRIPTOR* param4);

@DllImport("OPENGL32.dll")
int wglSetLayerPaletteEntries(HDC param0, int param1, int param2, int param3, const(uint)* param4);

@DllImport("OPENGL32.dll")
int wglGetLayerPaletteEntries(HDC param0, int param1, int param2, int param3, uint* param4);

@DllImport("OPENGL32.dll")
BOOL wglRealizeLayerPalette(HDC param0, int param1, BOOL param2);

@DllImport("OPENGL32.dll")
BOOL wglSwapLayerBuffers(HDC param0, uint param1);

