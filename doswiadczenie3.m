% Definicja danych pomiarowych
xi = [-10, -8, -6, -4, -2, 0, 2, 4, 6, 8, 10];
yi = [-32.959, -20.701, -12.698, -5.150, -1.689, 0.126, 0.074, -0.870, -1.737, -3.995, -4.898];

% Stopnie badanych wielomianów
degrees = [3, 5, 7, 9, 10];

% Wywołanie funkcji aproksymującej dla różnych stopni i metod
solvers = {'normalne', 'qr'};
errors_l2 = zeros(length(degrees), length(solvers));
errors_inf = zeros(length(degrees), length(solvers));
for i = 1:length(degrees)
  for j = 1:length(solvers)
    [a, errors] = aproximation(xi, yi, degrees(i), solvers{j});
    errors_l2(i, j) = errors.l2;
    errors_inf(i, j) = errors.inf;
  end
end

% Wyświetlanie wyników
disp('Wyniki aproksymacji:')
disp('-----------------------')
disp('Stopień | Solver | Norma L2 | Norma Inf')
disp('-----------------------')
for i = 1:length(degrees)
  for j = 1:length(solvers)
    fprintf('%d\t%s\t%.4f\t%.4f\n', degrees(i), solvers{j}, errors_l2(i, j), errors_inf(i, j));
  end
end

% Rysowanie wykresu
figure;
plot(xi, yi, 'ro', 'MarkerSize', 8);
hold on;
for i = 1:length(degrees)
  for j = 1:length(solvers)
    [a, ~] = aproximation(xi, yi, degrees(i), solvers{j});
    y_fit = polyval(a, linspace(min(xi), max(xi), 100));
    plot(linspace(min(xi), max(xi), 100), y_fit, 'LineWidth', 2);
  end
end
xlabel('x');
ylabel('y');
title('Aproksymacja wielomianem');
legend('Dane pomiarowe', strcat('Stopień ', num2str(degrees(1))), ...
       strcat('Stopień ', num2str(degrees(2))), strcat('Stopień ', num2str(degrees(3))), ...
       strcat('Stopień ', num2str(degrees(4))), strcat('Stopień ', num2str(degrees(5))), ...
       'Location', 'Best');
data_labels = {'Rozkład QR', 'Metoda normalnych równań'};

figure;

% Rozkład QR
subplot(1, 2, 1);
plot(xi, yi, 'ro', 'MarkerSize', 8, 'DisplayName', data_labels{1});
hold on;
for i = 1:length(degrees)
  [a, ~] = aproximation(xi, yi, degrees(i), 'qr');
  y_fit = polyval(a, linspace(min(xi), max(xi), 100));
  plot(linspace(min(xi), max(xi), 100), y_fit, 'LineWidth', 2);
end
xlabel('x');
ylabel('y');
title('Aproksymacja wielomianem - Rozkład QR');
legend('Location', 'Best');

% Metoda normalnych równań
subplot(1, 2, 2);
plot(xi, yi, 'ro', 'MarkerSize', 8, 'DisplayName', data_labels{2});
hold on;
for i = 1:length(degrees)
  [a, ~] = aproximation(xi, yi, degrees(i), 'normalne');
  y_fit = polyval(a, linspace(min(xi), max(xi), 100));
  plot(linspace(min(xi), max(xi), 100), y_fit, 'LineWidth', 2);
end
xlabel('x');
ylabel('y');
title('Aproksymacja wielomianem - Metoda normalnych równań');
legend('Location', 'Best');



% Obliczanie błędów
errors_qr = zeros(length(degrees), 1);
errors_normalne = zeros(length(degrees), 1);
for i = 1:length(degrees)
  [a_qr, ~] = aproximation(xi, yi, degrees(i), 'qr');
  y_fit_qr = polyval(a_qr, linspace(min(xi), max(xi), 100));
  errors_qr(i) = norm(yi - y_fit_qr, 2);

  [a_normalne, ~] = aproximation(xi, yi, degrees(i), 'normalne');
  y_fit_normalne = polyval(a_normalne, linspace(min(xi), max(xi), 100));
  errors_normalne(i) = norm(yi - y_fit_normalne, 2);
end


% Wykresy błędów
subplot(1, 2, 3);
plot(degrees, errors_qr, 'b-', 'LineWidth', 2, 'DisplayName', data_labels{1});
hold on;
plot(degrees, errors_normalne, 'r-', 'LineWidth', 2, 'DisplayName', data_labels{2});
xlabel('Stopień wielomianu');
ylabel('Błąd L2');
title('Porównanie błędów aproksymacji');
legend('Location', 'Best');

