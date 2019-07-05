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
        table = Array{Sonum8,2}(undef,n,n)
        #table = Array{Sonum8,1}(undef,(n*(n+1))÷2)  # Triangular numbers to determine size
        Float2Sonum = Sonum8
    elseif n == 2^15+1 # 16bit case
        table = Array{Sonum16,2}(undef,n,n)
        #table = Array{Sonum16,1}(undef,(n*(n+1))÷2)  # Triangular numbers to determine size
        Float2Sonum = Sonum16
    else
        throw(error("Input v has to be of length 129 (8bit) or 32769 (16bit)"))
    end

    for i in 1:n
        for j in 1:n
            if j >= i      # only upper triangle elements (symmetric or antisymmetric)
                #table[ij2k(i-1,j-1,n)] = Float2Sonum(operator(v[i],v[j]))
                table[i,j] = Float2Sonum(operator(v[i],v[j]))
            end
        end
    end

    return Symmetric(table)
end
