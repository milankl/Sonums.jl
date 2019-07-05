nextfloat(p::Sonum8) = reinterpret(Sonum8,reinterpret(UInt8,p)+one(UInt8))
nextfloat(p::Sonum16) = reinterpret(Sonum16,reinterpret(UInt16,p)+one(UInt16))

prevfloat(p::Sonum8) = reinterpret(Sonum8,reinterpret(UInt8,p)-one(UInt8))
prevfloat(p::Sonum16) = reinterpret(Sonum16,reinterpret(UInt16,p)-one(UInt16))

function -(x::Sonum8)
    if UInt8(x) == 0x00 || UInt8(x) == 0x80 # don't change sign for 0 and NaR
        return x
    else    # subtracting from 0x00 (two's complement def for neg)
        return Sonum8(0x00 - UInt8(x))
    end
end

function -(x::Sonum16)
    if UInt16(x) == 0x0000 || UInt16(x) == 0x8000 # don't change sign for 0 and NaR
        return x
    else    # subtracting from 0x0000 (two's complement def for neg)
        return Sonum16(0x0000 - UInt16(x))
    end
end

abs(x::Sonum8) = UInt8(x) > 0x80 ? Sonum8(0x00 - UInt8(x)) : x
abs(x::Sonum16) = UInt16(x) > 0x8000 ? Sonum8(0x0000 - UInt16(x)) : x

signbit(x::Sonum8) = UInt8(x) >= 0x80 ? true : false
signbit(x::Sonum16) = UInt16(x) >= 0x8000 ? true : false

function sign(p::T) where {T <: AbstractSonum}
    if signbit(p)       # negative and infinity case
        if isfinite(p)  # negative
            return minusone(T)
        else            # infinity
            return zero(T)
        end
    else                # positive and zero case
        if iszero(p)    # zero
            return zero(T)
        else            # positive
            return one(T)
        end
    end
end
