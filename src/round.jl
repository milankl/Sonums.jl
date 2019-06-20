function OptimBounds(x::Array{Float64,1})

    x[1] == 0 || throw(error("The first element of x should be 0."))
    x[end] == Inf || throw(error("The last element of x should be Inf."))

    x == sort(x) || throw(error("Elements of x are expected to be in an ascending order."))

    bounds = zero(x)                # first element is zero
    #bounds[2] = floatmin(Float64)   # no underflow rounding mode
    bounds[end] = floatmax(Float64)   # no overflow rounding mode

    # use the arithmetic mean (#TODO maybe geometric mean?)
    for i in 2:length(bounds)-1
        bounds[i] = 0.5*(x[i-1] + x[i])
    end

    return bounds
end

# function round2optim(x::Float64,opt::Array{Float64,1},bounds::Array{Float64,1})
#     return opt[argmin(x .>= bounds)]
# end

function round2optim(x::Float64,bounds::Array{Float64,1})
    return UInt8(argmin(x .>= bounds))
end
