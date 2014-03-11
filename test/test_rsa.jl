facts("RSA") do

  context("relative_prime") do

    @fact relative_prime(2, 3) => true
    @fact relative_prime(2, 4) => false
    @fact relative_prime(2, 5) => true
    @fact relative_prime(3, 5) => true
    @fact relative_prime(3, 21) => false

  end

  context("string_to_integer and integer_to_string") do

    for i = 1:100
      i = rand(0:(2^31))
      @fact base64_string_to_integer(integer_to_base64_string(i)) => i
    end

    function rand_string(len)
      bytes = Uint8[]
      for k = 1:len
        push!(bytes, uint8(rand(0:127)))
      end
      ASCIIString(bytes)
    end

    for i = 1:100
      str = rand_string(rand(1:20))
      a = convert(Vector{Uint8}, utf8(str))
      @fact integer_to_uint8_array(uint8_array_to_integer(a)) => a
    end

  end

end