function Sonum8(x::Float64)
    if isfinite(x)
        if signbit(x)
            return -Sonum8(UInt8(findFirstSmaller(-x,bounds8)-2))
        else
            return Sonum8(UInt8(findFirstSmaller(x,bounds8)-2))
        end
    else    # Inf,-Inf, and NaN
        return notareal(Sonum8)
    end
end

function Sonum16(x::Float64)
    if isfinite(x)
        if signbit(x)
            return -Sonum16(UInt16(findFirstSmaller(-x,bounds16)-2))
        else
            return Sonum16(UInt16(findFirstSmaller(x,bounds16)-2))
        end
    else    # Inf, -Inf, and NaN
        return notareal(Sonum16)
    end
end

#TODO Float64(notareal(Sonum8)) is -Inf, problem?
Float64(x::Sonum8) = signbit(x) ? -sonum8[Int(-x)+1] : sonum8[Int(x)+1]
Float64(x::Sonum16) = signbit(x) ? -sonum16[Int(-x)+1] : sonum16[Int(x)+1]

Float32(x::Sonum8) = Float32(Float64(x))
Float32(x::Sonum16) = Float32(Float64(x))

Sonum8(x::Float32) = Sonum8(Float64(x))
Sonum16(x::Float32) = Sonum16(Float64(x))

Sonum8(x::Float16) = Sonum8(Float64(x))
Sonum16(x::Float16) = Sonum16(Float64(x))

Sonum8(x::Int64) = Sonum8(Float64(x))
Sonum16(x::Int64) = Sonum16(Float64(x))

promote_rule(::Type{Int64},::Type{Sonum16}) = Sonum16
promote_rule(::Type{Int64},::Type{Sonum8}) = Sonum8

promote_rule(::Type{Int32},::Type{Sonum16}) = Sonum16
promote_rule(::Type{Int32},::Type{Sonum8}) = Sonum8
