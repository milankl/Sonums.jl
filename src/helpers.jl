function findfirsttrue(b::BitArray{1})
    for i in 1:length(b)
        if b[i]
            return i
        end
    end
    return Inf
end

# function findfirstsmaller(x::Float64,v::Array{Float64,1})
#     n = length(v)
#     for i in 1:n
#         if x < v[i]
#             return i
#         end
#     end
#     return n
# end

function findfirstsmaller(x::Float64,v::Array{Float64,1})

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

    if !isfinite(x)
        return l
    end

    # split
    for i in 1:n
        if x < v[idx]
            idx -= 2^(n-i)
        else
            idx += 2^(n-i)
        end
    end

    # split off the i = 7 case
    if x >= v[idx]
        idx += 1
    end

    return idx
end


# function findfirstlarger(x::Float64,v::Array{Float64,1})
#     for i in 1:length(v)
#         if x > v[i]
#             return i
#         end
#     end
#     return v[end]
# end
