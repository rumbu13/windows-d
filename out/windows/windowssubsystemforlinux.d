// Written in the D programming language.

module windows.windowssubsystemforlinux;

public import windows.core;

extern(Windows) @nogc nothrow:


// Enums


///The <b>WSL_DISTRIBUTION_FLAGS</b> enumeration specifies the behavior of a distribution in the Windows Subsystem for
///Linux (WSL).
alias WSL_DISTRIBUTION_FLAGS = int;
enum : int
{
    ///No flags are being supplied.
    WSL_DISTRIBUTION_FLAGS_NONE                  = 0x00000000,
    ///Allow the distribution to interoperate with Windows processes (for example, the user can invoke "cmd.exe" or
    ///"notepad.exe" from within a WSL session).
    WSL_DISTRIBUTION_FLAGS_ENABLE_INTEROP        = 0x00000001,
    ///Add the Windows %PATH% environment variable values to WSL sessions.
    WSL_DISTRIBUTION_FLAGS_APPEND_NT_PATH        = 0x00000002,
    WSL_DISTRIBUTION_FLAGS_ENABLE_DRIVE_MOUNTING = 0x00000004,
}

