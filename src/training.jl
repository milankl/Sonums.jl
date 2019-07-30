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

    sonum[1] = 0.0
    sonum[end] = Inf

    if method == "maxentropy"
        sonum[2:end-1] = maxentropy(2^(nbit-1)-1,abs.(data))
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
