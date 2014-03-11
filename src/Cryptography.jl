module Cryptography

export  factors, fast_exponentiation, odd, 
        next_prime, relative_prime, 
        integer_to_base64_string, base64_string_to_integer,
        integer_to_uint8_array, uint8_array_to_integer

include("factors.jl")
include("fast_exponentiation.jl")
include("next_prime.jl")
include("rsa.jl")

end