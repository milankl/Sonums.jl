abstract type AbstractOptim <: AbstractFloat end

primitive type Optim8 <: AbstractOptim 8 end
primitive type Optim16 <: AbstractOptim 16 end

Optim8(x::UInt8) = reinterpret(Optim8,x)
Optim16(x::UInt16) = reinterpret(Optim16,x)

Optim8(x::Int) = Optim8(UInt8(x))
Optim16(x::Int) = Optim16(UInt16(x))

UInt8(x::Optim8) = reinterpret(UInt8,x)
UInt16(x::Optim16) = reinterpret(UInt16,x)
