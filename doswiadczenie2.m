% Definicja macierzy A i wektora b
n_values = [5, 10, 25, 50, 100, 250, 500];
times_lu = zeros(size(n_values));
times_gs = zeros(size(n_values));
errors_lu = zeros(size(n_values));
errors_gs = zeros(size(n_values));
iterations_gs = zeros(size(n_values));

for i = 1:length(n_values)
  n = n_values(i);
  A = generate_matrix2(n);
  b = generate_vector2(n);
  
  % Rozkład LU z częściowym wyborem elementu głównego
  [x_lu, ~, ~, t_lu, err_lu] = lu_partial_pivoting(A, b);
  
  % Metoda Gaussa-Seidela
  [x_gs, iexe, texe] = GS(A, b, 1e-9, 1000 * n);
  
  times_lu(i) = t_lu;
  times_gs(i) = texe;
  errors_lu(i) = norm(A * x_lu - b, 2);
  errors_gs(i) = norm(A * x_gs - b, 2);
  iterations_gs(i) = iexe;
end

% Wyświetlenie wyników
disp('Wyniki dla macierzy trójdiagonalnej:')
disp('-------------------------------------')
disp('Rozmiar układu | Czas LU (s) | Czas GS (s) | Dokładność LU | Dokładność GS | Liczba iteracji GS')
disp('-------------------------------------')
for i = 1:length(n_values)
  fprintf('%d\t\t%.4f\t\t%.4f\t\t%.4e\t\t%.4e\t\t%d\n', ...
    n_values(i), times_lu(i), times_gs(i), errors_lu(i), errors_gs(i), iterations_gs(i));
end

% Wykresy
figure;
plot(n_values, times_lu, 'b-o');
hold on;
plot(n_values, times_gs, 'r-x');
xlabel('Liczba równań (n)');
ylabel('Czas obliczeń (s)');
legend('Rozkład LU', 'Metoda Gaussa-Seidela');

figure;
loglog(n_values, errors_lu, 'b-o');
hold on;
loglog(n_values, errors_gs, 'r-x');
xlabel('Liczba równań (n)');
ylabel('Błąd rozwiązania (ε)');
legend('Rozkład LU', 'Metoda Gaussa-Seidela');

figure;
plot(n_values, iterations_gs, 'r-x');
xlabel('Liczba równań (n)');
ylabel('Liczba iteracji');
legend('Metoda Gaussa-Seidela');

