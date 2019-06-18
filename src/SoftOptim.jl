module SoftOptim

export AbstractOptim, Optim8, Optim16

import Base: Float64, Float32, Float16, Int32, Int64,
    (+), (-), (*), (/), (<), (<=), (==), sqrt,
    bitstring, round, one, zero, promote_rule, eps,
    floatmin, floatmax, signbit, sign, isfinite,
    nextfloat, prevfloat, fma,
    exp, exp2, exp10, log, log2, log10, cos, sin, tan,
    expm1,log1p

include("typedef.jl")
include("conversions.jl")

end
