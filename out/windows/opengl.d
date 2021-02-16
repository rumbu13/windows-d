module windows.opengl;

public import windows.core;
public import windows.gdi : HDC;
public import windows.systemservices : BOOL, PROC;

extern(Windows):


// Structs


struct PIXELFORMATDESCRIPTOR
{
    ushort nSize;
    ushort nVersion;
    uint   dwFlags;
    ubyte  iPixelType;
    ubyte  cColorBits;
    ubyte  cRedBits;
    ubyte  cRedShift;
    ubyte  cGreenBits;
    ubyte  cGreenShift;
    ubyte  cBlueBits;
    ubyte  cBlueShift;
    ubyte  cAlphaBits;
    ubyte  cAlphaShift;
    ubyte  cAccumBits;
    ubyte  cAccumRedBits;
    ubyte  cAccumGreenBits;
    ubyte  cAccumBlueBits;
    ubyte  cAccumAlphaBits;
    ubyte  cDepthBits;
    ubyte  cStencilBits;
    ubyte  cAuxBuffers;
    ubyte  iLayerType;
    ubyte  bReserved;
    uint   dwLayerMask;
    uint   dwVisibleMask;
    uint   dwDamageMask;
}

struct POINTFLOAT
{
    float x;
    float y;
}

struct GLYPHMETRICSFLOAT
{
    float      gmfBlackBoxX;
    float      gmfBlackBoxY;
    POINTFLOAT gmfptGlyphOrigin;
    float      gmfCellIncX;
    float      gmfCellIncY;
}

struct LAYERPLANEDESCRIPTOR
{
    ushort nSize;
    ushort nVersion;
    uint   dwFlags;
    ubyte  iPixelType;
    ubyte  cColorBits;
    ubyte  cRedBits;
    ubyte  cRedShift;
    ubyte  cGreenBits;
    ubyte  cGreenShift;
    ubyte  cBlueBits;
    ubyte  cBlueShift;
    ubyte  cAlphaBits;
    ubyte  cAlphaShift;
    ubyte  cAccumBits;
    ubyte  cAccumRedBits;
    ubyte  cAccumGreenBits;
    ubyte  cAccumBlueBits;
    ubyte  cAccumAlphaBits;
    ubyte  cDepthBits;
    ubyte  cStencilBits;
    ubyte  cAuxBuffers;
    ubyte  iLayerPlane;
    ubyte  bReserved;
    uint   crTransparent;
}

// Functions

@DllImport("GDI32")
int ChoosePixelFormat(HDC hdc, const(PIXELFORMATDESCRIPTOR)* ppfd);

@DllImport("GDI32")
int DescribePixelFormat(HDC hdc, int iPixelFormat, uint nBytes, char* ppfd);

@DllImport("GDI32")
int GetPixelFormat(HDC hdc);

@DllImport("GDI32")
BOOL SetPixelFormat(HDC hdc, int format, const(PIXELFORMATDESCRIPTOR)* ppfd);

@DllImport("GDI32")
uint GetEnhMetaFilePixelFormat(ptrdiff_t hemf, uint cbBuffer, char* ppfd);

@DllImport("OPENGL32")
BOOL wglCopyContext(ptrdiff_t param0, ptrdiff_t param1, uint param2);

@DllImport("OPENGL32")
ptrdiff_t wglCreateContext(HDC param0);

@DllImport("OPENGL32")
ptrdiff_t wglCreateLayerContext(HDC param0, int param1);

@DllImport("OPENGL32")
BOOL wglDeleteContext(ptrdiff_t param0);

@DllImport("OPENGL32")
ptrdiff_t wglGetCurrentContext();

@DllImport("OPENGL32")
HDC wglGetCurrentDC();

@DllImport("OPENGL32")
PROC wglGetProcAddress(const(char)* param0);

@DllImport("OPENGL32")
BOOL wglMakeCurrent(HDC param0, ptrdiff_t param1);

@DllImport("OPENGL32")
BOOL wglShareLists(ptrdiff_t param0, ptrdiff_t param1);

@DllImport("OPENGL32")
BOOL wglUseFontBitmapsA(HDC param0, uint param1, uint param2, uint param3);

@DllImport("OPENGL32")
BOOL wglUseFontBitmapsW(HDC param0, uint param1, uint param2, uint param3);

@DllImport("GDI32")
BOOL SwapBuffers(HDC param0);

@DllImport("OPENGL32")
BOOL wglUseFontOutlinesA(HDC param0, uint param1, uint param2, uint param3, float param4, float param5, int param6, 
                         GLYPHMETRICSFLOAT* param7);

@DllImport("OPENGL32")
BOOL wglUseFontOutlinesW(HDC param0, uint param1, uint param2, uint param3, float param4, float param5, int param6, 
                         GLYPHMETRICSFLOAT* param7);

@DllImport("OPENGL32")
BOOL wglDescribeLayerPlane(HDC param0, int param1, int param2, uint param3, LAYERPLANEDESCRIPTOR* param4);

@DllImport("OPENGL32")
int wglSetLayerPaletteEntries(HDC param0, int param1, int param2, int param3, const(uint)* param4);

@DllImport("OPENGL32")
int wglGetLayerPaletteEntries(HDC param0, int param1, int param2, int param3, uint* param4);

@DllImport("OPENGL32")
BOOL wglRealizeLayerPalette(HDC param0, int param1, BOOL param2);

@DllImport("OPENGL32")
BOOL wglSwapLayerBuffers(HDC param0, uint param1);


