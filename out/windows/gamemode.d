module windows.gamemode;

public import windows.com;

extern(Windows):

@DllImport("api-ms-win-gaming-expandedresources-l1-1-0.dll")
HRESULT HasExpandedResources(int* hasExpandedResources);

@DllImport("api-ms-win-gaming-expandedresources-l1-1-0.dll")
HRESULT GetExpandedResourceExclusiveCpuCount(uint* exclusiveCpuCount);

@DllImport("api-ms-win-gaming-expandedresources-l1-1-0.dll")
HRESULT ReleaseExclusiveCpuSets();

