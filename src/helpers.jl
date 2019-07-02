function findfirsttrue(b::BitArray{1})
    for i in 1:length(b)
        if b[i]
            return i
        end
    end
    length(b)
end

function findfirstsmaller(x::Float64,v::Array{Float64,1})
    for i in 1:length(v)
        if x < v[i]
            return i
        end
    end
    return Inf
end

# function findfirstlarger(x::Float64,v::Array{Float64,1})
#     for i in 1:length(v)
#         if x > v[i]
#             return i
#         end
#     end
#     return v[end]
# end
