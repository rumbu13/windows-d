module codegen.attributes.native_encoding;

import std.exception : enforce;
import std.format : format;

import climetadata.mdcollection.entitytypes : CustomAttributeEntity;
import climetadata.mdcollection.sigtnature : ElementSig;

public struct NativeEncodingAttribute
{
    @disable this();

    public this(Range)(Range r)
    {
        foreach(ca; r)
        {
            if (ca.name() == "NativeEncodingAttribute")
            {
                nativeEncoding = readNativeEncoding(ca);
            }
            else
            {
                unhandledAttributes ~= ca;
            }
        }
    }

    public string getNativeEncoding() const
    {
        return nativeEncoding;
    }

    public const(CustomAttributeEntity)[] getUnhandledAttributes() const
    {
        return unhandledAttributes;
    }

    private string nativeEncoding;
    private const(CustomAttributeEntity)[] unhandledAttributes;
}

private string readNativeEncoding(scope ref const CustomAttributeEntity ca)
{
    assert(ca.name() == "NativeEncodingAttribute");
    auto sig = ca.value();
    
    enforce(sig.fixed.length == 1, format("NativeEncodingAttribute contains %s FixedArgSig elements, expected 1", sig.fixed.length));

    auto element = sig.fixed[0].value.peek!ElementSig;
    assert(element != null);
    enforce(element.value.peek!string != null, "NativeEncodingAttribute fixed[0] FixedArgSig element's value is not string");
    return element.value.get!string;
}
