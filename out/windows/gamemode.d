module windows.gamemode;

public import windows.core;
public import windows.com : HRESULT;

extern(Windows):


// Functions

@DllImport("api-ms-win-gaming-expandedresources-l1-1-0")
HRESULT HasExpandedResources(int* hasExpandedResources);

@DllImport("api-ms-win-gaming-expandedresources-l1-1-0")
HRESULT GetExpandedResourceExclusiveCpuCount(uint* exclusiveCpuCount);

@DllImport("api-ms-win-gaming-expandedresources-l1-1-0")
HRESULT ReleaseExclusiveCpuSets();


