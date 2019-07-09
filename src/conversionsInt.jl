Sonum8(x::UInt8) = reinterpret(Sonum8,x)
Sonum16(x::UInt16) = reinterpret(Sonum16,x)

UInt8(x::Sonum8) = reinterpret(UInt8,x)
UInt16(x::Sonum16) = reinterpret(UInt16,x)

Int(x::Sonum8) = Int(UInt8(x))
Int(x::Sonum16) = Int(UInt16(x))
