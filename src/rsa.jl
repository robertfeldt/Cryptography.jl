function relative_prime(a, b)
  gcd(a, b) == 1
end

function find_an_e_that_is_relative_prime(p, q)
  p1q1 = (p-1) * (q-1)

  candidate = -1
  found = false

  while !found
    # Select a random candidate and then loop until relative_prime or reached p1q1
    candidate = round( 1 + rand() * p1q1 )

    while candidate < p1q1 && !relative_prime(candidate, p1q1)
      candidate += 1
    end

    if relative_prime(candidate, p1q1)
      found = true
    end
  end

  return candidate
end

function find_a_d(p, q, e)
  p1q1 = (p-1) * (q-1)
  sgd = gcd(e, p1q1)
  d = e + p1q1 / sgd
  return d
end

function rand_big_int(keylength = 4096)
  bigint = BigInt(0)
  bits_left = keylength
  max_bits = 30
  while bits_left > 0
    numbits = min(bits_left, max_bits)
    bigint = (bigint << numbits) + (rand(1:2^numbits) - 1)
    bits_left -= numbits
  end
  bigint
end

type RSAKey
  # Public key = (n, e) and Private key = (n, d)
  n::Integer
  e::Integer
  d::Integer

  RSAKey(p = rand_big_int(4096)) = begin

    q = next_prime(p)
    n = p * q
    e = find_an_e_that_is_relative_prime(p, q)
    d = find_a_d(p, q, e)

    new(n, e, d)
  end
end

type RSAPublicKey
  n::Integer
  e::Integer
  RSAPublicKey(n::Integer, e::Integer) = new(n, e)
end

function public_key(rsa::RSAKey)
  RSAPublicKey(rsa.n, rsa.e)
end

function encrypt(rsa::Union(RSAKey, RSAPublicKey), P::Integer)
  fast_exponentiation(P, rsa.e, rsa.n)
end

function uint8_array_to_integer(arr::Array{Uint8,1})
  integer = BigInt(0)
  for i = 1:length(arr)
    integer = (integer << 8) + arr[i]
  end
  integer
end

function integer_to_uint8_array(x::Integer)
  bytes = Uint8[]

  while x > 0
    b = uint8(x & 0xff)
    push!(bytes, b)
    x = x >>> 8
  end

  return reverse(bytes)
end

# Convert a string to an integer for RSA encryption.
function string_to_integer(s::String)
  bytes = convert(Vector{Uint8}, utf8(s))
  uint8_array_to_integer(bytes)
end

using Codecs

# Convert a non-negative integer i into an octet string and then base64
# encode it so we can pass it around.
function integer_to_base64_string(x::Integer, len = nothing)
  if typeof(len) <: Integer && (x >= 256^len)
    throw("integer is too large")
  end

  if x < 0
    throw("integer is negative")
  end

  bytes = Uint8[]

  while x > 0
    b = uint8(x & 0xff)
    push!(bytes, b)
    x = x >>> 8
  end

  bytes = reverse(bytes)

  if typeof(len) <: Integer && (length(bytes) < len)
    bytes = [zeros(Uint8, len - str), bytes]
  end

  encoded = encode(Base64, bytes)

  return bytestring(encoded)
end

function base64_string_to_integer(s::String)
  decoded = decode(Base64, s)
  uint8_array_to_integer(decoded)
end

function encrypt(rsa::Union(RSAKey, RSAPublicKey), P::String)
  C = fast_exponentiation(string_to_integer(P), rsa.e, rsa.n)
end

function decrypt(rsa::RSAKey, C::String)
  P = fast_exponentiation(string_to_integer(C), rsa.d, rsa.n)
  integer_to_string(P)
end
