function round2optim8(x::Float64)
    return signbit(x) ? -optim8[argmin(-x >= bounds8)] : optim8[argmin(x >= bounds8)]
end

function round2optim16(x::Float64)
    return signbit(x) ? -optim16[argmin(-x >= bounds16)] : optim16[argmin(x >= bounds16)]
end
