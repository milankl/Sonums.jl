function calcBounds(nbit::Int,numlist::Array{Float64,1};overflow::Bool=false,underflow::Bool=true)

    numlist[1] == 0 || throw(error("The first element of x should be 0."))
    numlist[end] == Inf || throw(error("The last element of x should be Inf."))
    numlist == sort(numlist) || throw(error("Elements of x are expected to be in an ascending order."))

    if nbit == 8
        bounds = bounds8
    elseif nbit == 16
        bounds = bounds16
    else
        throw(error("Only 8/16bit supported."))
    end

    bounds[1] = 0.0
    bounds[end] = floatmax(Float64)     # no overflow rounding mode

    # use the arithmetic mean
    for i in 2:length(bounds)-1
        bounds[i] = 0.5*(numlist[i-1] + numlist[i])
    end

    # tie to even / round half to even by shifting every second bound a tiny bit
    for i in 2:2:length(bounds)-1
        bounds[i] = nextfloat(bounds[i])
    end


    # UNDERFLOW ROUNDING MODE
    if ~underflow
        bounds[2] = floatmin(Float64)
    end

    #TODO this has no effect, always no overflow somehow
    # OVERFLOW ROUNDING MODE
    if overflow
        # overflow for everything > 2 times the largest representable number
        bounds[end] = 2*numlist[end-1]
    else
        bounds[end] = floatmax(Float64)
    end

    return nothing
end

function setOverflow8(overflow::Bool)
    calcBounds(8,sonum8,overflow=overflow)
end

function setOverflow16(overflow::Bool)
    calcBounds(16,sonum16,overflow=overflow)
end

function setUnderflow8(underflow::Bool)
    calcBounds(8,sonum8,underflow=underflow)
end

function setUnderflow16(underflow::Bool)
    calcBounds(16,sonum16,underflow=underflow)
end
