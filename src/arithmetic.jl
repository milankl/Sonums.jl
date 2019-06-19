# One argument operations
nextfloat(p::Optim8) = reinterpret(Optim8,reinterpret(UInt8,p)+one(UInt8))
nextfloat(p::Optim16) = reinterpret(Optim16,reinterpret(UInt16,p)+one(UInt16))

prevfloat(p::Optim8) = reinterpret(Optim8,reinterpret(UInt8,p)-one(UInt8))
prevfloat(p::Optim16) = reinterpret(Optim16,reinterpret(UInt16,p)-one(UInt16))

function -(x::Optim8)
    if x == 0x00 || x == 0x80 # don't change sign for 0 and NaR
        return x
    else    # flip sign bit by adding 2^7
        return Optim8(UInt8(x) + 0x80)
    end
end

function -(x::Optim16)
    if x == 0x0000 || x == 0x8000 # don't change sign for 0 and NaR
        return x
    else
        return Optim16(UInt16(x) + 0x8000)
    end
end


function *(x::Optim8,y::Optim8)

    #TODO some if clauses based on sign
    TableMul[UInt8(x),UInt8(y)]
end

function +(x::Optim8,y::Optim8)

    #TODO some if clauses based on sign
    TableAdd[UInt8(x),UInt8(y)]
end

function -(x::Optim8,y::Optim8)

    #TODO some if clauses based on sign
    TableSub[UInt8(x),UInt8(y)]
end

function /(x::Optim8,y::Optim8)

    #TODO some if clauses based on sign
    TableDiv[UInt8(x),UInt8(y)]
end
