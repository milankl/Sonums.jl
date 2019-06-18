include("optim.jl")


x = randn(10_000_000)
optim8 = Optim(7,abs.(x))

optim8 = vcat(0.,optim8,Inf)

function table_mul(v::Array{Float64,1})

    n = length(v)
    table = Array{UInt8,2}(undef,n,n)

    for i in 1:n
        for j in 1:n
            table[i,j] = roundopt(v[i]*v[j],v)
        end
    end

    return table
end

function roundopt(x::Float64,v::AbstractArray)
    #TODO change rounding mode
    UInt8(argmin(x .> v))
end



const tablem = table_mul(optim8)

*(x::Optim8,y::Optim8) = tablem[UInt8(x),UInt8(y)]
