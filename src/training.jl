function trainSonum8(data::Union{AbstractArray{Float32},AbstractArray{Float64}})
    trainSonum(8,data)
end

function trainSonum16(data::Union{AbstractArray{Float32},AbstractArray{Float64}})
    trainSonum(16,data)
end

function trainSonum(nbit::Int,data::Union{AbstractArray{Float32},AbstractArray{Float64}})

    if nbit == 8
        sonum = sonum8
    elseif nbit == 16
        sonum = sonum16
    else
        throw(error("Only 8/16bit supported."))
    end

    N = length(data)
    r = 2^(nbit-1)-1    # amount of representable numbers excluding 0 and NaR, assuming +/- symmetry
    n = N ÷ r

    # throw away random data for equally sized chunks of data
    data = shuffle(abs.(data[:]))[1:n*r]
    sort!(data)

    # sonum entries are always Floa64
    sonum[1] = 0.0
    sonum[2] = (2*data[1] + data[n] + data[n+1])/4
    sonum[end-1] = (2*data[r*n] + data[(r-1)*n] + data[(r-1)*n-1])/4
    sonum[end] = Inf

    for i in 2:r-1
        sonum[i+1] = (data[(i-1)*n] + data[(i-1)*n + 1] + data[i*n] + data[i*n + 1])/4
    end

    calcBounds(nbit,sonum)
end

function setSonum8(nums::Union{AbstractArray{Float32,1},AbstractArray{Float64,1}})
    setSonum(8,nums)
end

function setSonum16(nums::Union{AbstractArray{Float32,1},AbstractArray{Float64,1}})
    setSonum(16,nums)
end

function setSonum(nbit::Int,nums::Union{AbstractArray{Float32,1},AbstractArray{Float64,1}})

    # for 8bit, vector nums has to be 127 elements long, excluding 0 and Inf
    # for 16bit, vector nums has to be 127 elements long, excluding 0 and Inf

    if nbit == 8 && length(nums) == 2^7-1
        sonum = sonum8
    elseif nbit == 16 && length(nums) == 2^15-1
        sonum = sonum16
    else
        throw(error("Only 8/16bit supported."))
    end

    sonum[1] = 0.0
    sonum[end] = Inf
    sonum[2:end-1] = nums

    calcBounds(nbit,sonum)
end

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
