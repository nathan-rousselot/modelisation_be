function P = permietre_superpixels(superpixels,K,m,n)
    if (nargin < 2)
        K = max(superpixels);
    end
    if (nargin < 4)
        [m,n] = size(superpixels);
    end
    [i,j] = deal(1);
    P = zeros(K,1);
    while (i <= m)
        while (j <= n)
            P(superpixels(i,j)) = P(superpixels(i,j))+is_perimeter(superpixels,i,j,m,n);
            j = j + 1;
        end
        j = 1;
        i = i + 1;
    end
end