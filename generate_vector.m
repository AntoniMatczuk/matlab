function b = generate_vector(n)
  b = zeros(n, 1); 
  for i = 1:n
    b(i) = 2.5 - 0.4 * i;
  end
end