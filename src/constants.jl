zero(::Optim8) = Optim8(0x00)
zero(::Optim16) = Optim16(0x00)

one(::Optim8) = Optim8(1.0)
one(::Optim16) = Optim16(1.0)

minusone(::Type{Optim8}) = Optim8(-1.0)
minusone(::Type{Optim16}) = Optim16(-1.0)

notareal(::Type{Optim8}) = Optim8(0x80)
notareal(::Type{Optim16}) = Optim16(0x8000)
notareal(x::AbstractOptim) = notareal(typeof(x))

floatmin(::Type{Optim8}) = Optim8(0x01)
floatmax(::Type{Optim8}) = Optim8(0x7F)

floatmin(::Type{Optim16}) = Optim16(0x0001)
floatmax(::Type{Optim16}) = Optim16(0x7FFF)
floatmin(x::AbstractOptim) = floatmin(typeof(x))
floatmax(x::AbstractOptim) = floatmax(typeof(x))

function signbit(x::Optim8)
    if UInt8(x) >= 0x80
        return true
    else
        return false
    end
end

function signbit(x::Optim16)
    if UInt16(x) >= 0x8000
        return true
    else
        return false
    end
end

isfinite(x::T) where {T<:AbstractOptim} = x != notareal(T)

function sign(p::T) where {T <: AbstractOptim}
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
