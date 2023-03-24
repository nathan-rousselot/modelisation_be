function A = aires_superpixels(superpixels,K,m,n)
%%% Calcul l'aire de tous les superpixels d'une image. Nécessaire pour le
%%% calcul de la compacité.
    if (nargin < 2)
        K = max(superpixels);
    end
    if (nargin < 4)
        [m,n] = size(superpixels);
    end
    A = zeros(K,1);
    [i,j] = deal(1);
    while (i <= m)
        while (j <= n)
            A(superpixels(i,j)) = A(superpixels(i,j)) + 1;
            j = j+1;
        end
        j = 1;
        i = i + 1;
    end
end