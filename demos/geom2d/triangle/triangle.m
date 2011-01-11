%TRIANGLE - compare forme des cellules avec celle d'un triangle.
%
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 16/01/2004
%

name = 'qu61';
img = imread(sprintf('~/images/ref2003/img/%s10.bmp', name));
lbl = imread(sprintf('~/matlab/res/seg2d/%slbl.tif', name));
lbl = cleanLabels(lbl);

stats = regionprops(lbl, 'Centroid', 'BoundingBox', 'Area', 'Image');
ori = zeros(double(max(lbl(:))), 24);

for cell = 1:double(max(lbl(:)))

    disp(sprintf('cell : %d', cell));
    % caracteristiques geometriques de la cellule.
    box = stats(cell).BoundingBox;
    center = stats(cell).Centroid;

    % teste 24 directions possibles.
    for angle=0:15:359
    %angle = 0;
    
        x0 = floor(center(1));
        y0 = floor(center(2));
        dx = cos(angle*pi/180);
        dy = sin(angle*pi/180);

        len = 1;
        % distingue les lignes horizontales et verticales
        if abs(dx)>abs(dy)
            % part de (x0,y0) en incrementant x0
            trueY = y0;
            dx = sign(dx);
            while lbl(y0, x0)==cell
                x0 = x0 + dx;
                if x0>size(lbl, 2) | x0<1
                    break;
                end
                trueY = trueY + dy;
                if abs(trueY - y0) > .5
                    y0 = y0+sign(dy);
                    if y0>size(lbl, 1) | y0<1
                        break;
                    end
                end
                len = len + 1;
            end
        else
            % part de (x0,y0) en incrementant y0
            trueX = x0;
            dy = sign(dy);
            while lbl(y0, x0)==cell
                y0 = y0 + dy;
                if y0>size(lbl, 1) | y0<1
                    break;
                end
                trueX = trueX + dx;
                if abs(trueX - x0) > .5
                    x0 = x0+sign(dx);
                    if x0>size(lbl, 2) | x0<1
                        break;
                    end
                end
                len = len + 1;
            end
        end

        ori(cell, angle/15 + 1) = len;
    end
end
