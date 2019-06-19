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
