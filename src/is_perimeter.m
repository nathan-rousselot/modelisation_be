function b = is_perimeter(s,i,j,m,n)
    if (nargin < 5)
        [m,n] = size(s);
    end
    if (i == 1)
        if (j == 1)
            b = s(i,j)==s(i+1,j) && s(i,j)==s(i,j+1);
        elseif (j == n)
            b = s(i,j)==s(i+1,j) && s(i,j)==s(i,j-1);
        else
            b = s(i,j)==s(i+1,j) && s(i,j)==s(i,j-1) && s(i,j+1);
        end
    elseif (i == m)
        if (j == 1)
            b = s(i,j)==s(i-1,j) && s(i,j)==s(i,j+1);
        elseif (j == n)
            b = s(i,j)==s(i-1,j) && s(i,j)==s(i,j-1);
        else
            b = s(i,j)==s(i-1,j) && s(i,j)==s(i,j-1) && s(i,j)==s(i,j+1);
        end
    elseif (j == 1)
        b = s(i,j)==s(i,j+1) && s(i,j)==s(i-1,j) && s(i,j)==s(i+1,j);
    elseif (j == n)
        b = s(i,j)==s(i,j-1) && s(i,j)==s(i-1,j) && s(i,j)==s(i+1,j);
    else
        b = s(i,j)==s(i-1,j) && s(i,j)==s(i+1,j) && s(i,j)==s(i,j+1) && s(i,j)==s(i,j-1);
    end

    b = int8(not(b));
end