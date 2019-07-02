function *(x::Optim16,y::Optim16)
    return Optim16(Float64(x)*Float64(y))
end

function +(x::Optim16,y::Optim16)
    return Optim16(Float64(x)+Float64(y))
end

function -(x::Optim16,y::Optim16)
    return Optim16(Float64(x)-Float64(y))
end

function /(x::Optim16,y::Optim16)
    return Optim16(Float64(x)/Float64(y))
end


function sqrt(x::Optim16)
    if signbit(x)
        return notareal(Optim16)
    else
        return ListSqrt16[UInt16(x)+one(UInt16)]
    end
end

function inv(x::Optim16)
    if signbit(x)
        return -ListInv16[UInt16(-x)+one(UInt16)]
    else
        return ListInv16[UInt16(x)+one(UInt16)]
    end
end

# via table lookups - SOLVE MEMORY ISSUE, SYMMETRIC MATRICES ETC?

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
#
# function +(x::Optim16,y::Optim16)
#     if signbit(x)
#         if signbit(y)   # -a-b = -(a+b)
#             return -TableAdd16[UInt16(-x)+one(UInt16),UInt16(-y)+one(UInt16)]
#         else            # -a+b = b-a
#             return TableSub16[UInt16(y)+one(UInt16),UInt16(-x)+one(UInt16)]
#         end
#     else
#         if signbit(y)   # a-b
#             return TableSub16[UInt16(x)+one(UInt16),UInt16(-y)+one(UInt16)]
#         else
#             return TableAdd16[UInt16(x)+one(UInt16),UInt16(y)+one(UInt16)]
#         end
#     end
# end
#
# function -(x::Optim16,y::Optim16)
#     if signbit(x)
#         if signbit(y)   # -a--b = b-a
#             return TableSub16[UInt16(-y)+one(UInt16),UInt16(-x)+one(UInt16)]
#         else            # -a-b = -(a+b)
#             return -TableAdd16[UInt16(-x)+one(UInt16),UInt16(y)+one(UInt16)]
#         end
#     else
#         if signbit(y)   # a--b = a+b
#             return TableAdd16[UInt16(x)+one(UInt16),UInt16(-y)+one(UInt16)]
#         else            # a-b
#             return TableSub16[UInt16(x)+one(UInt16),UInt16(y)+one(UInt16)]
#         end
#     end
# end
