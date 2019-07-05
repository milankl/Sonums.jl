module SoftSonum

export AbstractSonum, Sonum8, Sonum16,
    notareal, trainSonum

import Base: Float64, Float32, Float16, Int32, Int64,
    (+), (-), (*), (/), (<), (<=), (==), sqrt,
    bitstring, round, one, zero, promote_rule, eps,
    floatmin, floatmax, signbit, sign, isfinite,
    nextfloat, prevfloat, abs, inv

using Random, LinearAlgebra

include("typedef.jl")
include("helpers.jl")
include("training.jl")
include("conversionsInt.jl")
include("sign.jl")
include("print.jl")
include("constants.jl")

data = randn(10_000_000)

const sonum8 = trainSonum(8,data)
const sonum16 = trainSonum(16,data)
const bounds8 = SonumBounds(sonum8)
const bounds16 = SonumBounds(sonum16)

include("conversionsFloat.jl")
include("lookup_lists.jl")
include("lookup_tables.jl")

const TableMul8 = createTableMul(sonum8)
const TableAdd8 = createTableAdd(sonum8)
const TableSub8 = createTableSub(sonum8)

const TableMul16 = createTableMul(sonum16)
const TableAdd16 = createTableAdd(sonum16)
const TableSub16 = createTableSub(sonum16)

const ListSqrt8 = createListSqrt(sonum8)
const ListInv8 = createListInv(sonum8)

const ListSqrt16 = createListSqrt(sonum16)
const ListInv16 = createListInv(sonum16)

include("arithmetics8.jl")
include("arithmetics16.jl")

end
