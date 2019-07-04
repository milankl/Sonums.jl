function createTableMul(v::Array{Float64,1})
    return createTable(v,*)
end

function createTableAdd(v::Array{Float64,1})
    return createTable(v,+)
end

function createTableSub(v::Array{Float64,1})
    return createTable(v,-)
end

function createTable(v::Array{Float64,1},operator)

    n = length(v)
    if n == 2^7+1   # 8bit case
        table = Array{Optim8,2}(undef,n,n)
        #table = Array{Optim8,1}(undef,(n*(n+1))÷2)  # Triangular numbers to determine size
        Float2Optim = Optim8
    elseif n == 2^15+1 # 16bit case
        table = Array{Optim16,2}(undef,n,n)
        #table = Array{Optim16,1}(undef,(n*(n+1))÷2)  # Triangular numbers to determine size
        Float2Optim = Optim16
    else
        throw(error("Input v has to be of length 129 (8bit) or 32769 (16bit)"))
    end

    for i in 1:n
        for j in 1:n
            if j >= i      # only upper triangle elements (symmetric or antisymmetric)
                #table[ij2k(i-1,j-1,n)] = Float2Optim(operator(v[i],v[j]))
                table[i,j] = Float2Optim(operator(v[i],v[j]))
            end
        end
    end

    return Symmetric(table)
end
