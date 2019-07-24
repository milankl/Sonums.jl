function trainSonum8(data::Union{AbstractArray{Float32},AbstractArray{Float64}},method::String="maxentropy")
    trainSonum(8,data,method)
end

function trainSonum16(data::Union{AbstractArray{Float32},AbstractArray{Float64}},method::String="maxentropy")
    trainSonum(16,data,method)
end

function trainSonum(nbit::Int,data::Union{AbstractArray{Float32},AbstractArray{Float64}},method::String)

    if nbit == 8
        sonum = sonum8
    elseif nbit == 16
        sonum = sonum16
    else
        throw(error("Only 8/16bit supported."))
    end

    if method == "maxentropy"

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
    #elseif method == "nextmethod"
    else
        throw(error("Training method $method not implemented yet."))
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
