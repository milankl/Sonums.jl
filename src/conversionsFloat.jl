function Optim8(x::Float64)
    if signbit(x)
        return -Optim8(UInt8(argmin(-x .>= bounds8)))
    else
        return Optim8(UInt8(argmin(x .>= bounds8)) - UInt8(0x02))
    end
end

function Optim16(x::Float64)
    if signbit(x)
        return -Optim16(UInt16(argmin(-x .>= bounds16)))
    else
        return Optim16(UInt16(argmin(x .>= bounds16)))
    end
end

Float64(x::Optim8) = signbit(x) ? -optim8[UInt8(-x)] : optim8[UInt8(x)+one(UInt8)]
Float64(x::Optim16) = signbit(x) ? -optim16[UInt16(x)] : optim16[UInt16(x)+one(UInt16)]

Float32(x::Optim8) = Float32(Float64(x))
Float32(x::Optim16) = Float32(Float64(x))

Optim8(x::Float32) = Optim8(Float64(x))
Optim16(x::Float32) = Optim16(Float64(x))

Optim8(x::Float16) = Optim8(Float64(x))
Optim16(x::Float16) = Optim16(Float64(x))
