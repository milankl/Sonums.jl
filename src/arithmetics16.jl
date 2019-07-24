function *(x::Sonum16,y::Sonum16)
    if signbit(x)
        if signbit(y)
            @inbounds return TableMul16S[Int(-x)+1,Int(-y)+1]
        else
            @inbounds return -TableMul16S[Int(-x)+1,Int(y)+1]
        end
    else
        if signbit(y)
            @inbounds return -TableMul16S[Int(x)+1,Int(-y)+1]
        else
            @inbounds return TableMul16S[Int(x)+1,Int(y)+1]
        end
    end
end

function +(x::Sonum16,y::Sonum16)
    if signbit(x)
        if signbit(y)   # -a-b = -(a+b)
            @inbounds return -TableAdd16S[Int(-x)+1,Int(-y)+1]
        else            # -a+b = b-a

            # anti-symmetric: check for size
            a = Int(y)+1
            b = Int(-x)+1

            if a > b
                @inbounds return -TableSub16S[b,a]
            else
                @inbounds return TableSub16S[a,b]
            end

        end
    else
        if signbit(y)   # a-b
            #return TableSub16[Int(x)+1,Int(-y)+1]

            # anti-symmetric: check for size
            a = Int(x)+1
            b = Int(-y)+1

            if a > b
                @inbounds return -TableSub16S[b,a]
            else
                @inbounds return TableSub16S[a,b]
            end
        else
            @inbounds return TableAdd16S[Int(x)+1,Int(y)+1]
        end
    end
end

function -(x::Sonum16,y::Sonum16)
    if signbit(x)
        if signbit(y)   # -a--b = b-a
            # return TableSub16[Int(-y)+1,Int(-x)+1]

            # anti-symmetric: check for size
            a = Int(-y)+1
            b = Int(-x)+1

            if a > b
                @inbounds return -TableSub16S[b,a]
            else
                @inbounds return TableSub16S[a,b]
            end

        else            # -a-b = -(a+b)
            @inbounds return -TableAdd16S[Int(-x)+1,Int(y)+1]
        end
    else
        if signbit(y)   # a--b = a+b
            @inbounds return TableAdd16S[Int(x)+1,Int(-y)+1]
        else            # a-b
            # return TableSub16[Int(x)+1,Int(y)+1]

            # anti-symmetric: check for size
            a = Int(x)+1
            b = Int(y)+1

            if a > b
                @inbounds return -TableSub16S[b,a]
            else
                @inbounds return TableSub16S[a,b]
            end
        end
    end
end

function /(x::Sonum16,y::Sonum16)
    if signbit(x)
        if signbit(y)
            @inbounds return TableDiv16[Int(-x)+1,Int(-y)+1]
        else
            @inbounds return -TableDiv16[Int(-x)+1,Int(y)+1]
        end
    else
        if signbit(y)
            @inbounds return -TableDiv16[Int(x)+1,Int(-y)+1]
        else
            @inbounds return TableDiv16[Int(x)+1,Int(y)+1]
        end
    end
end

# This increases the error as two roundings are applied
# function /(x::Sonum16,y::Sonum16)
#     return x*inv(y)
# end

function sqrt(x::Sonum16)
    if signbit(x)
        return notareal(Sonum16)
    else
        @inbounds return ListSqrt16[Int(x)+1]
    end
end

function inv(x::Sonum16)
    if signbit(x)
        @inbounds return -ListInv16[Int(-x)+1]
    else
        @inbounds return ListInv16[Int(x)+1]
    end
end


# Table-less functions via Float64 conversion - slow but memory efficient
# function *(x::Sonum16,y::Sonum16)
#     return Sonum16(Float64(x)*Float64(y))
# end
#
# function +(x::Sonum16,y::Sonum16)
#     return Sonum16(Float64(x)+Float64(y))
# end
#
# function -(x::Sonum16,y::Sonum16)
#     return Sonum16(Float64(x)-Float64(y))
# end
#
# function /(x::Sonum16,y::Sonum16)
#     return Sonum16(Float64(x)/Float64(y))
# end
