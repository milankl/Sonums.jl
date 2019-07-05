function round2sonum8(x::Float64)
    return signbit(x) ? -sonum8[findFirstSmaller(-x,bounds8)-2)] : sonum8[findFirstSmaller(x,bounds8)-2)]
end

function round2sonum16(x::Float64)
    return signbit(x) ? -sonum16[findFirstSmaller(-x,bounds16)-2)] : sonum16[findFirstSmaller(-x,bounds16)-2)]
end
