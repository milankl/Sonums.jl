function createSonumList(::Type{T},nbit::Int) where {T<:AbstractFloat}
    return zeros(T,2^(nbit-1)+1)
end

function createSonumTable(::Type{T},nbit::Int) where {T<:AbstractFloat}
    n = 2^(nbit-1)+1
    A = Array{T,2}(undef,n,n)
    return Symmetric(A),A
end
