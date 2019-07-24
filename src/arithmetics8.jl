function *(x::Sonum8,y::Sonum8)
    if signbit(x)
        if signbit(y)
            @inbounds return TableMul8S[Int(-x)+1,Int(-y)+1]
        else
            @inbounds return -TableMul8S[Int(-x)+1,Int(y)+1]
        end
    else
        if signbit(y)
            @inbounds return -TableMul8S[Int(x)+1,Int(-y)+1]
        else
            @inbounds return TableMul8S[Int(x)+1,Int(y)+1]
        end
    end
end

function +(x::Sonum8,y::Sonum8)
    if signbit(x)
        if signbit(y)   # -a-b = -(a+b)
            @inbounds return -TableAdd8S[Int(-x)+1,Int(-y)+1]
        else            # -a+b = b-a

            # anti-symmetric: check for size
            a = Int(y)+1
            b = Int(-x)+1

            if a > b
                @inbounds return -TableSub8S[b,a]
            else
                @inbounds return TableSub8S[a,b]
            end

        end
    else
        if signbit(y)   # a-b
            #return TableSub8[Int(x)+1,Int(-y)+1]

            # anti-symmetric: check for size
            a = Int(x)+1
            b = Int(-y)+1

            if a > b
                @inbounds return -TableSub8S[b,a]
            else
                @inbounds return TableSub8S[a,b]
            end
        else
            @inbounds return TableAdd8S[Int(x)+1,Int(y)+1]
        end
    end
end

function -(x::Sonum8,y::Sonum8)
    if signbit(x)
        if signbit(y)   # -a--b = b-a
            # return TableSub8[Int(-y)+1,Int(-x)+1]

            # anti-symmetric: check for size
            a = Int(-y)+1
            b = Int(-x)+1

            if a > b
                @inbounds return -TableSub8S[b,a]
            else
                @inbounds return TableSub8S[a,b]
            end

        else            # -a-b = -(a+b)
            @inbounds return -TableAdd8S[Int(-x)+1,Int(y)+1]
        end
    else
        if signbit(y)   # a--b = a+b
            @inbounds return TableAdd8S[Int(x)+1,Int(-y)+1]
        else            # a-b
            # return TableSub8[Int(x)+1,Int(y)+1]

            # anti-symmetric: check for size
            a = Int(x)+1
            b = Int(y)+1

            if a > b
                @inbounds return -TableSub8S[b,a]
            else
                @inbounds return TableSub8S[a,b]
            end
        end
    end
end

function /(x::Sonum8,y::Sonum8)
    if signbit(x)
        if signbit(y)
            @inbounds return TableDiv8[Int(-x)+1,Int(-y)+1]
        else
            @inbounds return -TableDiv8[Int(-x)+1,Int(y)+1]
        end
    else
        if signbit(y)
            @inbounds return -TableDiv8[Int(x)+1,Int(-y)+1]
        else
            @inbounds return TableDiv8[Int(x)+1,Int(y)+1]
        end
    end
end

# This increases the error as two roundings are applied
# function /(x::Sonum8,y::Sonum8)
#     return x*inv(y)
# end

function sqrt(x::Sonum8)
    if signbit(x)
        return notareal(Sonum8)
    else
        @inbounds return ListSqrt8[Int(x)+1]
    end
end

function inv(x::Sonum8)
    if signbit(x)
        @inbounds return -ListInv8[Int(-x)+1]
    else
        @inbounds return ListInv8[Int(x)+1]
    end
end
