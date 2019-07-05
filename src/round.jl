function round2optim8(x::Float64)
    return signbit(x) ? -optim8[findFirstSmaller(-x,bounds8)-2)] : optim8[findFirstSmaller(x,bounds8)-2)]
end

function round2optim16(x::Float64)
    return signbit(x) ? -optim16[findFirstSmaller(-x,bounds16)-2)] : optim16[findFirstSmaller(-x,bounds16)-2)]
end
