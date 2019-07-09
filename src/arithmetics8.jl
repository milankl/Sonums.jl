function *(x::Sonum8,y::Sonum8)
    if signbit(x)
        if signbit(y)
            return TableMul8S[Int(-x)+1,Int(-y)+1]
        else
            return -TableMul8S[Int(-x)+1,Int(y)+1]
        end
    else
        if signbit(y)
            return -TableMul8S[Int(x)+1,Int(-y)+1]
        else
            return TableMul8S[Int(x)+1,Int(y)+1]
        end
    end
end

function +(x::Sonum8,y::Sonum8)
    if signbit(x)
        if signbit(y)   # -a-b = -(a+b)
            return -TableAdd8S[Int(-x)+1,Int(-y)+1]
        else            # -a+b = b-a

            # anti-symmetric: check for size
            a = Int(y)+1
            b = Int(-x)+1

            if a > b
                return -TableSub8S[b,a]
            else
                return TableSub8S[a,b]
            end

        end
    else
        if signbit(y)   # a-b
            #return TableSub8[Int(x)+1,Int(-y)+1]

            # anti-symmetric: check for size
            a = Int(x)+1
            b = Int(-y)+1

            if a > b
                return -TableSub8S[b,a]
            else
                return TableSub8S[a,b]
            end
        else
            return TableAdd8S[Int(x)+1,Int(y)+1]
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
                return -TableSub8S[b,a]
            else
                return TableSub8S[a,b]
            end

        else            # -a-b = -(a+b)
            return -TableAdd8S[Int(-x)+1,Int(y)+1]
        end
    else
        if signbit(y)   # a--b = a+b
            return TableAdd8S[Int(x)+1,Int(-y)+1]
        else            # a-b
            # return TableSub8[Int(x)+1,Int(y)+1]

            # anti-symmetric: check for size
            a = Int(x)+1
            b = Int(y)+1

            if a > b
                return -TableSub8S[b,a]
            else
                return TableSub8S[a,b]
            end
        end
    end
end


function /(x::Sonum8,y::Sonum8)
    return x*inv(y)
end

function sqrt(x::Sonum8)
    if signbit(x)
        return notareal(Sonum8)
    else
        return ListSqrt8[Int(x)+1]
    end
end

function inv(x::Sonum8)
    if signbit(x)
        return -ListInv8[Int(-x)+1]
    else
        return ListInv8[Int(x)+1]
    end
end
