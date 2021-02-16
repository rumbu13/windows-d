module windows.core;


struct GUID {
    align(1):
    uint     Data1;
    ushort   Data2;
    ushort   Data3;
    ubyte[8] Data4;

    private static T hex(T)(string s)
    {
        T result;
        for(size_t i; i < s.length; ++i)    
        {
            if (s[i] >= '0' && s[i] <= '9')
                result = cast(T)((result << 4) | (s[i] - '0'));
            else if (s[i] >= 'A' && s[i] <= 'F')
                result = cast(T)((result << 4) | (s[i] - 'A' + 10));
            else 
            {
                assert(s[i] >= 'a' && s[i] <= 'f', "Invalid hex digit '" ~ s[i] ~ "'");            
                result = cast(T)((result << 4) | (s[i] - 'a' + 10));
            }
        }
        return result;
    }

    this(string s)
    {

        assert(s.length == 36, "Invalid GUID length");  
        assert(s[8] == '-' && s[13] == '-' && s[18] == '-' && s[23] == '-', "Invalid GUID format");
        Data1 = hex!uint(s[0 .. 8]);
        Data2 = hex!ushort(s[9 .. 13]);
        Data3 = hex!ushort(s[14 .. 18]);
        Data4[0] = hex!ubyte(s[19 .. 21]);
        Data4[1] = hex!ubyte(s[21 .. 23]);
        for (size_t i; i < 6; ++i)
            Data4[i + 2] = hex!ubyte(s[i * 2 + 24 .. i * 2 + 26]);        
    }

    this()(auto const ref GUID other)
    {
        this.Data1 = other.Data1;
        this.Data2 = other.Data2;
        this.Data3 = other.Data3;
        this.Data4 = other.Data4;
    }
    
}

template GUIDOF(T, A...)
{
    static if (A.length == 0)
        alias GUIDOF = GUIDOF!(T, __traits(getAttributes, T));
    else static if (A.length == 1)
    {
        static assert(is(typeof(A[0]) == GUID), T.stringof ~ "doesn't have a @GUID attribute attached to it");
        enum GUIDOF = A;
    }
    else static if (is(typeof(A[0]) == GUID))
        enum GUIDOF = A[0];
    else
        alias GUIDOF = GUIDOF!(T, A[1 .. $]);
}

struct DllImport
{
    string libName;
}



