% Funkcja aproksymująca (uniwersalna procedura)
function [a, errors] = aproximation(xi, yi, degree, solver)
% Macierz pomocnicza do tworzenia monomów
  X = ones(length(xi), degree);
  for i = 2:(degree+1)
    X(:, i) = xi.^(i-1);
  end


  % Współczynniki wielomianu - metoda najmniejszych kwadratów
  if strcmp(solver, 'normalne')
    [a_l2,~, ~] = universal_lu_solver(X, yi');
    a_l2 = a_l2';
    %a_l2 = polyfit(xi, yi, degree);
  elseif strcmp(solver, 'qr')
    [Q, R] = qr(X);
    a_l2 = (R \ (Q' * yi'));
  else
    error('Nieznany solver!');
  end

  % Aproksymowane wartości
  y_fit = polyval(a_l2, xi);
  a = y_fit;

  % Błędy aproksymacji
  errors.l2 = norm(yi - y_fit, 2);
  errors.inf = norm(yi - y_fit, inf);
end