function A = generate_matrix2(n)
  A = diag(-10 * ones(n, 1));
  for i = 1:n-1
    A(i, i+1) = 3;
    A(i+1, i) = 3;
  end
end