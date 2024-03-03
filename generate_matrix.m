function A = generate_matrix(n)
  A = zeros(n);
  for i = 1:n
    for j = 1:n
      if j ~= i
        A(i, j) = 4 * (i - j) + 2;
      else
        A(i, j) = 1 / 3; 
      end
    end
  end
end