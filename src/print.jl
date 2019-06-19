bitstring(x::Optim8) = bitstring(UInt8(x))
bitstring(x::Optim16) = bitstring(UInt16(x))

#TODO something like
#show(io::IO,x::Optim8) = print(io,"Optim8")
#show(io::IO,x::Optim16) = print(io,"Optim16")
