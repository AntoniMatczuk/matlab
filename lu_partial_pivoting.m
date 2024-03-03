function [x, L, U, t, err] = lu_partial_pivoting(A, b)
  % Rozmiar macierzy
  n = size(A, 1);

  % Macierze L i U
  L = eye(n);
  U = A;

  % Czas rozpoczęcia
  t_start = tic;

  % Rozkład LU
  for k = 1:n-1
    % Wybór elementu głównego
    [~, i_max] = max(abs(U(k:n, k)));
    i_max = i_max + k - 1;

    % Zamiana wierszy
    if i_max ~= k
      U([k, i_max], :) = U([i_max, k], :);
      L([k, i_max], :) = L([i_max, k], :);
    end

    % Eliminacja Gaussa
    for i = k+1:n
      L(i, k) = U(i, k) / U(k, k);
      U(i, k:n) = U(i, k:n) - L(i, k) * U(k, k:n);
    end
  end

  % Czas zakończenia
  t_end = toc(t_start);

  % Rozwiązanie układu L * y = b
  y = L \ b;

  % Rozwiązanie układu U * x = y
  x = U \ y;

  % Błąd rozwiązania
  err = norm(A * x - b);

  % Czas obliczeń
  t = t_end - t_start;
end


