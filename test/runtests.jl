using SoftSonum
using Test

data = randn(10_000)
trainSonum8(abs.(data))
fillSonum8Tables()

include("test_conversions.jl")
include("test_arithmetics.jl")
