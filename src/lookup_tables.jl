function createTableMul(v::Array{Float64,1})

    n = length(v)
    if n == 2^7+1   # 8bit case
        table = Array{Optim8,2}(undef,n,n)
        Float2Optim = Optim8
    elseif n == 2^15+1 # 16bit case
        table = Array{Optim16,2}(undef,n,n)
        Float2Optim = Optim16
    else
        throw(error("Input v is not of correct length to be compatible with 8bit (127) or 16bit (32767)"))
    end

    for i in 1:n
        for j in 1:n
            table[i,j] = Float2Optim(v[i]*v[j])
        end
    end

    return table
end

function createTableAdd(v::Array{Float64,1})

    n = length(v)
    if n == 2^7-1   # 8bit case
        table = Array{Optim8,2}(undef,n,n)
        Float2Optim = Optim8
    elseif n == 2^15-1 # 16bit case
        table = Array{Optim16,2}(undef,n,n)
        Float2Optim = Optim16
    else
        throw(error("Input v is not of correct length to be compatible with 8bit (127) or 16bit (32767)"))
    end

    for i in 1:n
        for j in 1:n
            table[i,j] = Float2Optim(v[i]+v[j])
        end
    end

    return table
end
