include("helper.jl")

my_tests = [

  "test_factors.jl",
  "test_fast_exponentiation.jl",
  "test_next_prime.jl",
  "test_rsa.jl",

]

for t in my_tests
  include(t)
end
