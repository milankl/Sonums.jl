using Random

function Optim(nbit::Int,x::AbstractVector)

    N = length(x)
    r = 2^nbit
    n = N ÷ r

    # throw away random data for equally sized chunks of data
    x = shuffle(x)[1:n*r]
    sort!(x)

    optim = fill(0.0,r)
    optim[1] = (2*x[1] + x[n] + x[n+1])/4
    optim[r] = (2*x[r*n] + x[(r-1)*n] + x[(r-1)*n-1])/4

    for i in 2:r-1
        optim[i] = (x[(i-1)*n] + x[(i-1)*n + 1] + x[i*n] + x[i*n + 1])/4
    end

    return optim
end

function decimal_precision(x::Real,y::Real)
    return -log10(abs(log10(abs(x/y))))
end

function wc_decimal_precision(x::AbstractVector)
    x == sort(x) || throw("Vector x must be sorted!")
    all(x .> 0) || throw("All entries of x must be > 0")

    # arithmetic mean between representable numbers
    am = (x[1:end-1]+x[2:end])/2.

    # worst case decimal precision against next representable number
    wcdp = decimal_precision.(am,x[2:end])

    # extrapolate first and last, assuming no overflow/underflow
    x0, xinf = x[1]/2,x[end]*2
    wcdp_0 = 0. #decimal_precision(x0,x[1])
    wcdp_inf = 0. #decimal_precision(xinf,x[end])

    # worst-case decimal accuracy of interpolated on minpos/maxpos
    wcdp_minpos = wcdp_0 + log10(x[1]/x0)/log10(wcdp_0/am[1])*(wcdp_0-wcdp[1])
    wcdp_maxpos = wcdp_inf + log10(x[end]/xinf)/log10(xinf/am[end])*(wcdp_inf-wcdp[end])

    # concatenate everything
    wcdp = vcat(wcdp_0,wcdp_minpos,wcdp,wcdp_maxpos,wcdp_inf)
    am = vcat(x0,x[1],am,x[end],xinf)

    return am,wcdp
end
