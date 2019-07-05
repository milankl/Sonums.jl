function Optim8(x::Float64)
    if isfinite(x)
        if signbit(x)
            return -Optim8(UInt8(findFirstSmaller(-x,bounds8)-2))
        else
            return Optim8(UInt8(findFirstSmaller(x,bounds8)-2))
        end
    else    # Inf,-Inf, and NaN
        return notareal(Optim8)
    end
end

function Optim16(x::Float64)
    if isfinite(x)
        if signbit(x)
            return -Optim16(UInt16(findFirstSmaller(-x,bounds16)-2))
        else
            return Optim16(UInt16(findFirstSmaller(x,bounds16)-2))
        end
    else    # Inf, -Inf, and NaN
        return notareal(Optim16)
    end
end

#TODO Float64(notareal(Optim8)) is -Inf, problem?
Float64(x::Optim8) = signbit(x) ? -optim8[Int(-x)+1] : optim8[Int(x)+1]
Float64(x::Optim16) = signbit(x) ? -optim16[Int(-x)+1] : optim16[Int(x)+1]

Float32(x::Optim8) = Float32(Float64(x))
Float32(x::Optim16) = Float32(Float64(x))

Optim8(x::Float32) = Optim8(Float64(x))
Optim16(x::Float32) = Optim16(Float64(x))

Optim8(x::Float16) = Optim8(Float64(x))
Optim16(x::Float16) = Optim16(Float64(x))
