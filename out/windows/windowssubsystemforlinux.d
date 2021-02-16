module windows.windowssubsystemforlinux;

public import windows.core;

extern(Windows):


// Enums


enum : int
{
    WSL_DISTRIBUTION_FLAGS_NONE                  = 0x00000000,
    WSL_DISTRIBUTION_FLAGS_ENABLE_INTEROP        = 0x00000001,
    WSL_DISTRIBUTION_FLAGS_APPEND_NT_PATH        = 0x00000002,
    WSL_DISTRIBUTION_FLAGS_ENABLE_DRIVE_MOUNTING = 0x00000004,
}
alias WSL_DISTRIBUTION_FLAGS = int;

