function *(x::Optim8,y::Optim8)
    if signbit(x)
        if signbit(y)
            return TableMul8[UInt8(-x),UInt8(-y)]
        else
            return -TableMul8[UInt8(-x),UInt8(y)]
        end
    else
        if signbit(y)
            return -TableMul8[UInt8(x),UInt8(-y)]
        else
            return TableMul8[UInt8(x),UInt8(y)]
        end
    end
end

function *(x::Optim16,y::Optim16)
    if signbit(x)
        if signbit(y)
            return TableMul16[UInt16(-x),UInt16(-y)]
        else
            return -TableMul16[UInt16(-x),UInt16(y)]
        end
    else
        if signbit(y)
            return -TableMul16[UInt16(x),UInt16(-y)]
        else
            return TableMul16[UInt16(x),UInt16(y)]
        end
    end
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
