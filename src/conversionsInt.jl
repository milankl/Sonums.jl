Optim8(x::UInt8) = reinterpret(Optim8,x)
Optim16(x::UInt16) = reinterpret(Optim16,x)

UInt8(x::Optim8) = reinterpret(UInt8,x)
UInt16(x::Optim16) = reinterpret(UInt16,x)
