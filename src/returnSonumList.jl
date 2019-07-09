function returnSonumList(nbit::Int)
    if nbit == 8
        return sonum8
    elseif nbit == 16
        return sonum16
    else
        throw(error("Only 8/16bits supported."))
    end
end

function returnSonumBounds(nbit::Int)
    if nbit == 8
        return bounds8
    elseif nbit == 16
        return bounds16
    else
        throw(error("Only 8/16bits supported."))
    end
end
