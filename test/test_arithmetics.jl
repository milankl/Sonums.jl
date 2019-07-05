@testset "Arithmetics" begin
    f0,f1,f2,f3,f4 = -1.0,-0.5,0.25,1.0,1.5

    # basic arithmetic operations
    @testset for T in (Optim8, Optim16)
        @test T(f3) - T(f4) == -(T(f4) - T(f3))         # anti symmetry of subtraction
        @test zero(T) == T(f0) + T(f3)                  #
        @test T(f1) + T(f2) == T(f2) + T(f1)            # symmetry of addition
        @test notareal(T) == one(T)/zero(T)             # infinity case
        @test zero(T) == T(0.0)*one(T)                  # zero element
        @test one(T) == one(T)*one(T)                   # one element
        @test floatmax(T) == floatmax(T)*floatmax(T)    # no overflow
        @test zero(T) == floatmin(T)*floatmin(T)        # but underflow
        @test T(f0)*T(f1) == -T(f0) * -T(f1)            # symmetry of multiplication
        @test T(f0)/T(f1) == -2T(f0)
    end
end
