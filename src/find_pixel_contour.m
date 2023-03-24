function [i,j] = find_pixel_contour(I,m,n)
%%% Trouve un pixel sur le contour d'une forme BINARISEE, en partant du
%%% Nord. Nécessaire pour le calcul du contour.
    if (nargin < 3)
        [m,n] = size(I);
    end
    j = floor(n/2);
    i = 1;
    while (i <= m && I(i,j) == 0)
        i = i + 1;
    end
end