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

isfinite(x::T) where {T<:AbstractOptim} = x != notareal(T)
