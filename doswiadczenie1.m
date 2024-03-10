n_values = [5, 25, 50, 100, 250, 500, 1000];
times = zeros(size(n_values));
errors = zeros(size(n_values));

for i = 1:length(n_values)
  n = n_values(i);

  A = generate_matrix(n);
  b = generate_vector(n);

  [x, t, err] = universal_lu_solver(A, b);

  times(i) = t;
  errors(i) = err;
end

% Wykresy
figure;
plot(n_values, times, '-o');
xlabel('Liczba równań (n)');
ylabel('Czas obliczeń (s)');

figure;
loglog(n_values, errors, '-o');
xlabel('Liczba równań (n)');
ylabel('Błąd rozwiązania (ε)');