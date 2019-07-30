""" Quantization: Interval clustering based on maximum entropy method.  """
function maxentropy(r::Int,data::Array{Float64,1})

    N = length(data)
    n = N ÷ r       # number of data points per chunk

    # throw away random data for equally sized chunks of data
    data = shuffle(data[:])[1:n*r]
    sort!(data)

    # reshape data into a matrix, each chunk one column
    dataview = reshape(view(data,:),(n,:))

    nodes = Array{Float64,1}(undef,r)

    for i in 1:r
        # arithmetic mean of min and max within chunk
        nodes[i] = (dataview[1,i] + dataview[end,i])/2
    end

    return nodes
end
