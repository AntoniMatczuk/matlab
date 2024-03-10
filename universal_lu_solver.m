function [x, t, error] = universal_lu_solver(A, b)
    % Rozmiar macierzy
    [m, n] = size(A);

    % Macierze L i U
    L = eye(m);
    P = eye(m);  % Permutation matrix
    U = A;
    
    tic

    % Rozkład LU with Partial Pivoting
    for k = 1:min(m, n)
        % Wybór elementu głównego (Partial Pivoting)
        [~, i_max] = max(abs(U(k:m, k)));
        i_max = i_max + k - 1;

        % Zamiana wierszy w U, L, P 
        U([k, i_max], :) = U([i_max, k], :);
        L([k, i_max], 1:k-1) = L([i_max, k], 1:k-1);
        P([k, i_max], :) = P([i_max, k], :);

        % Eliminacja Gaussa
        for i = k+1:m
            L(i, k) = U(i, k) / U(k, k);
            U(i, k:n) = U(i, k:n) - L(i, k) * U(k, k:n);
        end
    end

    % Rozwiązywanie układu równań z wykorzystaniem L, U, P
    y = L \ (P*b);  % Solve Ly = Pb for y 
    x = U \ y;        % Solve Ux = y for x

    error = norm(A*x - b, 2);

    t = toc;
end
