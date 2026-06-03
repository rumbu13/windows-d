// Written in the D programming language.

module windows.win32.devices.beep;

public import windows.core;

extern(Windows) @nogc nothrow:


// Constants


enum : const(wchar)*
{
    // Native encoding: ansi
    DD_BEEP_DEVICE_NAME   = "\\Device\\Beep",
    DD_BEEP_DEVICE_NAME_U = "\\Device\\Beep",
}

enum uint IOCTL_BEEP_SET = 0x00010000U;

enum : uint
{
    BEEP_FREQUENCY_MINIMUM = 0x00000025U,
    BEEP_FREQUENCY_MAXIMUM = 0x00007fffU,
}

// Structs


struct BEEP_SET_PARAMETERS
{
    uint Frequency;
    uint Duration;
}

