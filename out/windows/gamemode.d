// Written in the D programming language.

module windows.gamemode;

public import windows.core;
public import windows.com : HRESULT;
public import windows.systemservices : BOOL;

extern(Windows) @nogc nothrow:


// Functions

///Gets the current resource state (that is, whether the app is running in Game Mode or shared mode).
///Params:
///    hasExpandedResources = True if the app is running in Game Mode; otherwise, false.
///Returns:
///    The result of the operation.
///    
@DllImport("api-ms-win-gaming-expandedresources-l1-1-0")
HRESULT HasExpandedResources(BOOL* hasExpandedResources);

///Gets the expected number of exclusive CPU sets that are available to the app when in Game Mode.
///Params:
///    exclusiveCpuCount = The expected number of exclusive CPU sets that are available to the app when in Game Mode.
///Returns:
///    The result of the operation.
///    
@DllImport("api-ms-win-gaming-expandedresources-l1-1-0")
HRESULT GetExpandedResourceExclusiveCpuCount(uint* exclusiveCpuCount);

///Opts out of CPU exclusivity, giving the app access to all cores, but at the cost of having to share them with other
///processes.
///Returns:
///    The result of the operation.
///    
@DllImport("api-ms-win-gaming-expandedresources-l1-1-0")
HRESULT ReleaseExclusiveCpuSets();


