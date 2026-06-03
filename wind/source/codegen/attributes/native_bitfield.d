module codegen.attributes.native_bitfield;

import std.exception : enforce;
import std.format : format;
import std.typecons : Tuple;

import climetadata.mdcollection.entitytypes : CustomAttributeEntity;
import climetadata.mdcollection.sigtnature : ElementSig;

public alias NativeBitRecord = Tuple!(string, "name", int, "offset",  int, "length",);

public struct NativeBitfieldAttribute
{
    @disable this();

    public this(Range)(Range r)
    {
        foreach(ca; r)
        {
            if (ca.name() == "NativeBitfieldAttribute")
            {
                bitRecords ~= readNativeBitfield(ca);
            }
            else
            {
                unhandledAttributes ~= ca;
            }
        }
    }

    public const(NativeBitRecord[]) getBitRecords() const
    {
        return bitRecords;
    }

    public const(CustomAttributeEntity)[] getUnhandledAttributes() const
    {
        return unhandledAttributes;
    }

    private NativeBitRecord[] bitRecords;
    private const(CustomAttributeEntity)[] unhandledAttributes;
}

private NativeBitRecord readNativeBitfield(scope ref const CustomAttributeEntity ca)
{
    assert(ca.name() == "NativeBitfieldAttribute");
    auto sig = ca.value();
    
    enforce(sig.fixed.length == 3, format("NativeBitfieldAttribute contains %s FixedArgSig elements, expected 3", sig.fixed.length));

    auto element = sig.fixed[0].value.peek!ElementSig;
    assert(element != null);
    enforce(element.value.peek!string != null, "NativeBitfieldAttribute fixed[0] FixedArgSig element's value is not string");
    auto name = element.value.get!string;

    element = sig.fixed[1].value.peek!ElementSig;
    assert(element != null);
    enforce(element.value.peek!long != null, "NativeBitfieldAttribute fixed[1] FixedArgSig element's value is not long");
    auto offset = element.value.get!long;


    element = sig.fixed[2].value.peek!ElementSig;
    assert(element != null);
    enforce(element.value.peek!long != null, "NativeBitfieldAttribute fixed[2] FixedArgSig element's value is not long");
    auto length = element.value.get!long;

    return NativeBitRecord(name, cast(int)offset, cast(int)length);
}
