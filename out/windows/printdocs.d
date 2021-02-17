// Written in the D programming language.

module windows.printdocs;

public import windows.core;

extern(Windows):


// Structs


///Describes the placement and location of a glyph.
struct XPS_GLYPH_INDEX
{
    ///The index of a glyph in the physical font.
    int   index;
    ///Indicates the placement of the glyph that follows, relative to the origin of the current glyph. Measured in
    ///hundredths of the font's em-size.
    float advanceWidth;
    ///The horizontal distance, in the effective coordinate space, by which to move the glyph from the glyph's origin.
    ///Measured in hundredths of the font's em-size.
    float horizontalOffset;
    ///The vertical distance, in the effective coordinate space, by which to move the glyph from the glyph's origin.
    ///Measured in hundredths of the font's em-size.
    float verticalOffset;
}

