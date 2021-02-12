module windows.printdocs;


extern(Windows):

struct XPS_GLYPH_INDEX
{
    int index;
    float advanceWidth;
    float horizontalOffset;
    float verticalOffset;
}

