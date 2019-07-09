function feedback(c::Int,ntot::Int,nbit::Int,operator)
    c += 1
    if c % 5369200 == 0
        if nbit == 16
            percent = Int(round(100c / ntot))
            print("\r\u1b[K")
            if percent == 100
                println("Sonum16: Table for ($operator) 100%.")
            else
                print("Sonum16: Table for ($operator) $percent%")
            end
        end
    end
    return c
end
