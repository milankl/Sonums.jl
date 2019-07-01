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

# Table-less multiplication (slower)
# function *(x::Optim8,y::Optim8)
#     return Optim8(Float64(x)*Float64(y))
# end

function *(x::Optim16,y::Optim16)
    if signbit(x)
        if signbit(y)
            return TableMul16[UInt16(-x)+one(UInt16),UInt16(-y)+one(UInt16)]
        else
            return -TableMul16[UInt16(-x)+one(UInt16),UInt16(y)+one(UInt16)]
        end
    else
        if signbit(y)
            return -TableMul16[UInt16(x)+one(UInt16),UInt16(-y)+one(UInt16)]
        else
            return TableMul16[UInt16(x)+one(UInt16),UInt16(y)+one(UInt16)]
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

function +(x::Optim16,y::Optim16)
    if signbit(x)
        if signbit(y)   # -a-b = -(a+b)
            return -TableAdd16[UInt16(-x)+one(UInt16),UInt16(-y)+one(UInt16)]
        else            # -a+b = b-a
            return TableSub16[UInt16(y)+one(UInt16),UInt16(-x)+one(UInt16)]
        end
    else
        if signbit(y)   # a-b
            return TableSub16[UInt16(x)+one(UInt16),UInt16(-y)+one(UInt16)]
        else
            return TableAdd16[UInt16(x)+one(UInt16),UInt16(y)+one(UInt16)]
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

function -(x::Optim16,y::Optim16)
    if signbit(x)
        if signbit(y)   # -a--b = b-a
            return TableSub16[UInt16(-y)+one(UInt16),UInt16(-x)+one(UInt16)]
        else            # -a-b = -(a+b)
            return -TableAdd16[UInt16(-x)+one(UInt16),UInt16(y)+one(UInt16)]
        end
    else
        if signbit(y)   # a--b = a+b
            return TableAdd16[UInt16(x)+one(UInt16),UInt16(-y)+one(UInt16)]
        else            # a-b
            return TableSub16[UInt16(x)+one(UInt16),UInt16(y)+one(UInt16)]
        end
    end
end

function /(x::Optim8,y::Optim8)

    #TODO some if clauses based on sign
    TableDiv[UInt8(x),UInt8(y)]
end
