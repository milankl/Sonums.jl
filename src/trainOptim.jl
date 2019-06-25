function trainOptim(nbit::Int,x::AbstractVector)

    N = length(x)
    r = 2^(nbit-1)-1    # amount of representable numbers excluding 0 and NaR, assuming =/- symmetry
    n = N ÷ r

    # throw away random data for equally sized chunks of data
    x = shuffle(abs.(x))[1:n*r]
    sort!(x)

    optim = fill(0.0,r+2)   # always use Float64 here, first element is 0
    optim[2] = (2*x[1] + x[n] + x[n+1])/4
    optim[end-1] = (2*x[r*n] + x[(r-1)*n] + x[(r-1)*n-1])/4
    optim[end] = Inf

    for i in 2:r-1
        optim[i+1] = (x[(i-1)*n] + x[(i-1)*n + 1] + x[i*n] + x[i*n + 1])/4
    end

    return optim
end

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
