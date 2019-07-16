# SoftSonum.jl
An emulator for Sonums - the Self-Organizing NUMber system. A number system that learns from data. Sonum8 is the 8bit version, Sonum16 for 16bit computations.

# Usage
Load the emulator with `using SoftSonum`, then train the 8 or 16bit Sonums with your data (sofar only a simple maxentropy approach is used for training, but this will be extended soon)
```julia
data = randn(10_000_000)
trainSonum8(data)
trainSonum16(data)
```
Alternatively, you can also use a 127-element vector (8bit) or 32767-element vector (16bit) to set the representable Sonums directly. To imitate Posit8 for example you may do

```julia
using SoftPosit
posit8 = Float64.(Posit8.(UInt8.(collect(1:127))))  # creates a list of Posit8 number in (0,Inf) 
setSonum8(posit8)
setUnderflow8(false)  # Posits don't underflow but Sonums do by default
```
Once either Sonum8 or Sonum16 is set up, you have to fill the lookup tables for all arithmetic operations
```julia
fillSonumTables8()    #  8bit: this is quick
fillSonumTables16()   # 16bit: this may take a few minutes
```
And now we can do things like
```julia
julia> a = Sonum16(1.2);
julia> b = Sonum16(0.5);
julia> a-b
Sonum16(0x420a)
julia> Float64(a-b)
0.7000189572298372
julia> Float64(sqrt(a))
1.0954481925887807
```
# Benchmarking

Unfortunately the table lookup matrices require 4GB of RAM for 16bit (<1Mb for 8bit). However, arithmetic operations are reasonably fast

```julia
julia> using BenchmarkTools

julia> a,b = Sonum16(1.5),Sonum16(0.5)
(Sonum16(0x6ee8), Sonum16(0x3111))

julia> @btime +($a,$b);
  3.599 ns (0 allocations: 0 bytes)

julia> @btime -($a,$b);
  3.361 ns (0 allocations: 0 bytes)

julia> @btime *($a,$b);
  3.121 ns (0 allocations: 0 bytes)

julia> @btime /($a,$b);
  4.320 ns (0 allocations: 0 bytes)

julia> @btime sqrt($a);
  2.401 ns (0 allocations: 0 bytes)
```
# Testing
Sonums are tested against the SoftPosit library: Once set up with Posits, Sonums yield bitwise-reproducible results for +,-,*,/. 

# Installation
In the package manager do
```julia
(v1.1) pkg> add https://www.github.com/milankl/SoftSonum.jl
```



