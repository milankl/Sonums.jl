Sonum8(x::UInt8) = reinterpret(Sonum8,x)
Sonum16(x::UInt16) = reinterpret(Sonum16,x)

UInt8(x::Sonum8) = reinterpret(UInt8,x)
UInt16(x::Sonum16) = reinterpret(UInt16,x)

Int(x::Sonum8) = Int(UInt8(x))
Int(x::Sonum16) = Int(UInt16(x))

Sonum8(x::Int) = Sonum8(Float64(x))
Sonum16(x::Int) = Sonum16(Float64(x))

promote_rule(::Type{Int64},::Type{Sonum16}) = Sonum16
promote_rule(::Type{Int64},::Type{Sonum8}) = Sonum8

promote_rule(::Type{Int32},::Type{Sonum16}) = Sonum16
promote_rule(::Type{Int32},::Type{Sonum8}) = Sonum8
