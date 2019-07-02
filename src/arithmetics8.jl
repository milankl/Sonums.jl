function *(x::Optim8,y::Optim8)
    if signbit(x)
        if signbit(y)
            return TableMul8[UInt8(-x)+one(UInt8),UInt8(-y)+one(UInt8)]
        else
            return -TableMul8[UInt8(-x)+one(UInt8),UInt8(y)+one(UInt8)]
        end
    else
        if signbit(y)
            return -TableMul8[UInt8(x)+one(UInt8),UInt8(-y)+one(UInt8)]
        else
            return TableMul8[UInt8(x)+one(UInt8),UInt8(y)+one(UInt8)]
        end
    end
end

function +(x::Optim8,y::Optim8)
    if signbit(x)
        if signbit(y)   # -a-b = -(a+b)
            return -TableAdd8[UInt8(-x)+one(UInt8),UInt8(-y)+one(UInt8)]
        else            # -a+b = b-a
            return TableSub8[UInt8(y)+one(UInt8),UInt8(-x)+one(UInt8)]
        end
    else
        if signbit(y)   # a-b
            return TableSub8[UInt8(x)+one(UInt8),UInt8(-y)+one(UInt8)]
        else
            return TableAdd8[UInt8(x)+one(UInt8),UInt8(y)+one(UInt8)]
        end
    end
end

function -(x::Optim8,y::Optim8)
    if signbit(x)
        if signbit(y)   # -a--b = b-a
            return TableSub8[UInt8(-y)+one(UInt8),UInt8(-x)+one(UInt8)]
        else            # -a-b = -(a+b)
            return -TableAdd8[UInt8(-x)+one(UInt8),UInt8(y)+one(UInt8)]
        end
    else
        if signbit(y)   # a--b = a+b
            return TableAdd8[UInt8(x)+one(UInt8),UInt8(-y)+one(UInt8)]
        else            # a-b
            return TableSub8[UInt8(x)+one(UInt8),UInt8(y)+one(UInt8)]
        end
    end
end


function /(x::Optim8,y::Optim8)
    return x*inv(y)
end

function sqrt(x::Optim8)
    if signbit(x)
        return notareal(Optim8)
    else
        return ListSqrt8[UInt8(x)+one(UInt8)]
    end
end

function inv(x::Optim8)
    if signbit(x)
        return -ListInv8[UInt8(-x)+one(UInt8)]
    else
        return ListInv8[UInt8(x)+one(UInt8)]
    end
end
