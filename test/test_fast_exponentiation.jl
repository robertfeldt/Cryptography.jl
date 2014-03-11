facts("fast exponentiation methods") do

  context("odd") do

    @fact odd(0) => false
    @fact odd(1) => true
    @fact odd(2) => false
    @fact odd(3) => true

    @fact odd(2^100) => false

    @fact odd(BigInt(2)^2011) => false

  end

  @fact fast_exponentiation(10, 0, 2) => 1

  @fact fast_exponentiation(1, 2, 3) => 1

  @fact fast_exponentiation(2, 2011, 15) => int(mod(BigFloat(2)^2011, 15))

end