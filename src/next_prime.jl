function next_prime(n)

  p = n + 1

  if p == 2
    return 2
  end

  if mod(p, 2) == 0
    p = p + 1
  end

  while length(factors(p)) > 2
    p = p + 2
  end

  return p
  
end
