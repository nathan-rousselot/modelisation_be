function b = is_perimeter(s,i,j,p,m,n)
    if (nargin < 4)
        p = 8;
    end
    if (nargin < 6)
        [m,n] = size(s);
    end
    if (p == 8)
        if (i == 1)
            if (j == 1)
                b = s(i,j)==s(i+1,j) && s(i,j)==s(i,j+1) && s(i,j)==s(i+1,j+1);
            elseif (j == n)
                b = s(i,j)==s(i+1,j) && s(i,j)==s(i,j-1) && s(i,j)==s(i+1,j-1);
            else
                b = s(i,j)==s(i+1,j) && s(i,j)==s(i,j-1) && s(i,j)==s(i,j+1) ...
                    && s(i,j)==s(i+1,j-1) && s(i,j)==s(i+1,j+1);
            end
        elseif (i == m)
            if (j == 1)
                b = s(i,j)==s(i-1,j) && s(i,j)==s(i,j+1) && s(i,j)==s(i-1,j+1);
            elseif (j == n)
                b = s(i,j)==s(i-1,j) && s(i,j)==s(i,j-1) && s(i,j)==s(i-1,j-1);
            else
                b = s(i,j)==s(i-1,j) && s(i,j)==s(i,j-1) && s(i,j)==s(i,j+1) ...
                    && s(i,j)==s(i-1,j-1) && s(i,j)==s(i-1,j+1);
            end
        elseif (j == 1)
            b = s(i,j)==s(i,j+1) && s(i,j)==s(i-1,j) && s(i,j)==s(i+1,j) ...
                && s(i,j)==s(i-1,j+1) && s(i,j)==s(i+1,j+1);
        elseif (j == n)
            b = s(i,j)==s(i,j-1) && s(i,j)==s(i-1,j) && s(i,j)==s(i+1,j) ...
                && s(i,j)==s(i-1,j-1) && s(i,j)==s(i+1,j-1);
        else
            b = s(i,j)==s(i-1,j) && s(i,j)==s(i+1,j) && s(i,j)==s(i,j+1) && s(i,j)==s(i,j-1) && s(i,j)==s(i-1,j-1) ...
                && s(i,j)==s(i-1,j+1) && s(i,j)==s(i+1,j-1) && s(i,j)==s(i+1,j+1);
        end
    else
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
    end

    b = int8(not(b));
end