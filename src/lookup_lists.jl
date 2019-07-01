function createListSqrt(v::Array{Float64,1})

    n = length(v)
    if n == 2^7+1   # 8bit case
        list = Array{Optim8,1}(undef,n)
        Float2Optim = Optim8
    elseif n == 2^15+1 # 16bit case
        list = Array{Optim16,1}(undef,n)
        Float2Optim = Optim16
    else
        throw(error("Input v is not of correct length to be compatible with 8bit (127) or 16bit (32767)"))
    end

    for i in 1:n
        list[i] = Float2Optim(sqrt(v[i]))
    end

    return list
end

function createListInv(v::Array{Float64,1})

    n = length(v)
    if n == 2^7+1   # 8bit case
        list = Array{Optim8,1}(undef,n)
        Float2Optim = Optim8
    elseif n == 2^15+1 # 16bit case
        list = Array{Optim16,1}(undef,n)
        Float2Optim = Optim16
    else
        throw(error("Input v is not of correct length to be compatible with 8bit (127) or 16bit (32767)"))
    end

    for i in 1:n
        list[i] = Float2Optim(1/v[i])
    end

    return list
end
