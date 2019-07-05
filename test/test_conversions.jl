@testset "Conversions" begin

    @testset for T in (Sonum8, Sonum16)
        @test one(T) == T(1.0)
        @test zero(T) == T(0.0)
        @test minusone(T) == T(-1.0)
        @test notareal(T) == T(Inf)

        for x in [-Inf,-1.0,-0.25,0.0,0.25,1.0,Inf]
            @test T(x) == T(Float64(T(x)))
        end

        @test floatmin(T) == T(Float64(floatmin(T)))
        @test floatmax(T) == T(Float64(floatmax(T)))

    end
end
