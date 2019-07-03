Optim8(x::UInt8) = reinterpret(Optim8,x)
Optim16(x::UInt16) = reinterpret(Optim16,x)

UInt8(x::Optim8) = reinterpret(UInt8,x)
UInt16(x::Optim16) = reinterpret(UInt16,x)

Int(x::Optim8) = Int(UInt8(x))
Int(x::Optim16) = Int(UInt16(x))

Optim8(x::Int) = Optim8(Float64(x))
Optim16(x::Int) = Optim16(Float64(x))

promote_rule(::Type{Int64},::Type{Optim16}) = Optim16
promote_rule(::Type{Int64},::Type{Optim8}) = Optim8

promote_rule(::Type{Int32},::Type{Optim16}) = Optim16
promote_rule(::Type{Int32},::Type{Optim8}) = Optim8
