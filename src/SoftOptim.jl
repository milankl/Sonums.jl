module SoftOptim

export AbstractOptim, Optim8, Optim16,
    notareal, trainOptim

import Base: Float64, Float32, Float16, Int32, Int64,
    (+), (-), (*), (/), (<), (<=), (==), sqrt,
    bitstring, round, one, zero, promote_rule, eps,
    floatmin, floatmax, signbit, sign, isfinite,
    nextfloat, prevfloat, abs, inv

using Random

include("typedef.jl")
include("trainOptim.jl")
include("conversionsInt.jl")
include("sign.jl")
include("print.jl")
include("constants.jl")

data = randn(10_000_000)

const optim8 = trainOptim(8,data)
const bounds8 = OptimBounds(optim8)

include("conversionsFloat.jl")
include("lookup_lists.jl")
include("lookup_tables.jl")

const TableMul8 = createTableMul(optim8)
const TableAdd8 = createTableAdd(optim8)
const TableSub8 = createTableSub(optim8)
const TableDiv8 = createTableDiv(optim8)

const ListSqrt8 = createListSqrt(optim8)
const ListInv8 = createListInv(optim8)

include("arithmetics.jl")

end
