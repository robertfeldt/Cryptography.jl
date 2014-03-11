facts("next prime") do

  @fact next_prime(1) => 2
  @fact next_prime(2) => 3
  @fact next_prime(3) => 5
  @fact next_prime(4) => 5
  @fact next_prime(5) => 7
  @fact next_prime(6) => 7
  @fact next_prime(7) => 11
  @fact next_prime(8) => 11
  @fact next_prime(9) => 11
  @fact next_prime(10) => 11
  @fact next_prime(11) => 13
  @fact next_prime(13) => 17
  @fact next_prime(16) => 17
  @fact next_prime(17) => 19
  @fact next_prime(19) => 23
  @fact next_prime(49) => 53

  @fact next_prime(BigInt(49)) => 53

end