function findFirstSmaller(x::Float64,v::Array{Float64,1})

    l = length(v)
    if l == 129         # 8bit case
        idx = 64        # starting index (l-1)/2
        n = 6           #
    elseif l == 32769   # 16bit case
        idx = 16384     # starting index (l-1)/2
        n = 14
    else
        throw(BoundsError())
    end

    if x > v[end-1]     # floatmax and infinity case
        return l
    end

    # binary tree search
    for i in 1:n
        if x < v[idx]
            idx -= 2^(n-i)
        else
            idx += 2^(n-i)
        end
    end

    # split off the i = n+1 case
    if x >= v[idx]
        idx += 1
    end

    return idx
end
