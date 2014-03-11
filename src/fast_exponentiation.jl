function odd(n::Integer)
  n & 1 == 1
end

function odd(n::Real)
  int(n) & 1 == 1
end

# Given integers a, n, and m with n ≥ 0 and 0 ≤ a < m, compute mod(a^n, m)
# using the fast exponentiation method.
# Based on 
#   http://homepages.math.uic.edu/~leon/cs-mcs401-s08/handouts/fastexp.pdf
#
function fast_exponentiation(a, n, m)

  x = a
  y = odd(n) ? a : 1
  nprim = floor(n / 2)

  while nprim > 0
    x = mod(x .* x, m)

    if odd(nprim)
      y = (y == 1) ? x : mod(x .* y, m)
    end

    nprim = floor(nprim / 2)
  end

  return y

end