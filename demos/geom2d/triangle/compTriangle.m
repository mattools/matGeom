

% petit test rapide pour verifier que la detection d'une harmonique
% sur un contour (ici contour d'une cellule carree, on veut l'harmonique
% 4 , donc le 5 eme point du tableau) ne depend pas de la taille de la
% transformee de fourier.

img = logical(zeros(100, 100));
img(26:75, 26:75) = 1;

N = 96;

% teste N directions possibles.
for i = 1:N
    angle = (i-1)*2*pi/N;
    x0 = 50;
    y0 = 50;
    dx = cos(angle);
    dy = sin(angle);

    len = 1;
    % distingue les lignes horizontales et verticales
    if abs(dx)>abs(dy)
        % part de (x0,y0) en incrementant x0
        trueY = y0;
        dx = sign(dx);
        while img(y0, x0)
            x0 = x0 + dx;
            trueY = trueY + dy;
            if abs(trueY - y0) > .5
                y0 = y0+sign(dy);
                len = len+sqrt(2);
            else
                len = len + 1;
            end
        end
    else
        % part de (x0,y0) en incrementant y0
        trueX = x0;
        dy = sign(dy);
        while img(y0, x0)
            y0 = y0 + dy;
            trueX = trueX + dx;
            if abs(trueX - x0) > .5
                x0 = x0+sign(dx);
                len = len+sqrt(2);
            else
                len = len + 1;
            end
        end
    end

    ori(i) = len;
end
