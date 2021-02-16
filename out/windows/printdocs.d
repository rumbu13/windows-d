module windows.printdocs;

public import windows.core;

extern(Windows):


// Structs


struct XPS_GLYPH_INDEX
{
    int   index;
    float advanceWidth;
    float horizontalOffset;
    float verticalOffset;
}

