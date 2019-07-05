zero(::Sonum8) = Sonum8(0x00)
zero(::Sonum16) = Sonum16(0x00)

one(::Sonum8) = Sonum8(1.0)
one(::Sonum16) = Sonum16(1.0)

minusone(::Type{Sonum8}) = Sonum8(-1.0)
minusone(::Type{Sonum16}) = Sonum16(-1.0)

notareal(::Type{Sonum8}) = Sonum8(0x80)
notareal(::Type{Sonum16}) = Sonum16(0x8000)
notareal(x::AbstractSonum) = notareal(typeof(x))

floatmin(::Type{Sonum8}) = Sonum8(0x01)
floatmax(::Type{Sonum8}) = Sonum8(0x7F)

floatmin(::Type{Sonum16}) = Sonum16(0x0001)
floatmax(::Type{Sonum16}) = Sonum16(0x7FFF)
floatmin(x::AbstractSonum) = floatmin(typeof(x))
floatmax(x::AbstractSonum) = floatmax(typeof(x))

isfinite(x::T) where {T<:AbstractSonum} = x != notareal(T)
