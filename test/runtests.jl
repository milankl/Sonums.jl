using SoftSonum
using SoftPosit
using Test

data = randn(100_000)
trainSonum8(abs.(data))
fillSonum8Tables()

@testset "Arithmetics" begin
    f0,f1,f2,f3,f4 = -1.0,-0.5,0.25,1.0,1.5

    # basic arithmetic operations
    @testset for T in (Sonum8,) # Sonum16)
        @test T(f3) - T(f4) == -(T(f4) - T(f3))         # anti symmetry of subtraction
        @test zero(T) == T(f0) + T(f3)                  #
        @test T(f1) + T(f2) == T(f2) + T(f1)            # symmetry of addition
        @test T(Inf) == one(T)/zero(T)                  # infinity case
        @test zero(T) == T(0.0)*one(T)                  # zero element
        @test one(T) == one(T)*one(T)                   # one element
        @test floatmax(T) == floatmax(T)*floatmax(T)    # no overflow
        @test zero(T) == floatmin(T)*floatmin(T)        # but underflow
        @test T(f0)*T(f1) == -T(f0) * -T(f1)            # symmetry of multiplication

        #TODO some divison testing
        #@test T(f0)/T(f1) == -2T(f0)
    end
end

@testset "Conversions" begin

    @testset for T in (Sonum8,) # Sonum16)
        @test one(T) == T(1.0)
        @test zero(T) == T(0.0)
        @test -one(T) == T(-1.0)

        for x in [-Inf,-1.0,-0.25,0.0,0.25,1.0,Inf]
            @test T(x) == T(Float64(T(x)))
        end

        @test floatmin(T) == T(Float64(floatmin(T)))
        @test floatmax(T) == T(Float64(floatmax(T)))

    end
end

@testset "CompareToPosit8" begin

    p8 = Float64.(Posit8.(UInt8.(collect(1:127))))
    setSonum8(p8)
    setUnderflow8(false)
    fillSonum8Tables()

    n = 256

    @testset "Addition" begin
        for i in 0:n-1
            for j in 0:n-1
                p = UInt8(Posit8(UInt8(i))+Posit8(UInt8(j)))
                s = UInt8(Sonum8(UInt8(i))+Sonum8(UInt8(j)))
                @test p == s
            end
        end
    end

    @testset "Subtraction" begin
        for i in 0:n-1
            for j in 0:n-1
                p = UInt8(Posit8(UInt8(i))-Posit8(UInt8(j)))
                s = UInt8(Sonum8(UInt8(i))-Sonum8(UInt8(j)))
                @test p == s
            end
        end
    end

    @testset "Multiplication" begin
        for i in 0:n-1
            for j in 0:n-1
                p = UInt8(Posit8(UInt8(i))*Posit8(UInt8(j)))
                s = UInt8(Sonum8(UInt8(i))*Sonum8(UInt8(j)))
                @test p == s
            end
        end
    end

    @testset "Division" begin
        for i in 0:n-1
            for j in 0:n-1
                p = UInt8(Posit8(UInt8(i))/Posit8(UInt8(j)))
                s = UInt8(Sonum8(UInt8(i))/Sonum8(UInt8(j)))
                @test p == s
            end
        end
    end

    @testset "Sqrt" begin
        for i in 0:n-1
            p = UInt8(sqrt(Posit8(UInt8(i))))
            s = UInt8(sqrt(Sonum8(UInt8(i))))
            @test p == s
        end
    end

end
