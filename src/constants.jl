zero(::Optim8) = Optim8(0x00)
zero(::Optim16) = Optim16(0x00)

#TODO define Optim one

notareal(::Optim8) = Optim8(0x80)
notareal(::Optim16) = Optim16(0x8000)
notareal(x::AbstractOptim) = notareal(typeof(x))

function signbit(x::Optim8)
    if UInt8(x) >= 0x80
        return true
    else
        return false
    end
end

function signbit(x::Optim16)
    if UInt8(x) >= 0x8000
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
