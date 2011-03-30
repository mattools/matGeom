function line = medianLine(varargin)
%MEDIANLINE Create a median line between two points
%
%   L = medianLine(P1, P2);
%   Create the median line of points P1 and P2, that is the line containing
%   all points located at equal distance of P1 and P2.
%
%   L = medianLine(PTS);
%   Creates the median line of 2 points, given as a 2*2 array. Array has
%   the form:
%   [ [ x1 y1 ] ; [ x2 y2 ] ]
%
%   L = medianLine(EDGE);
%   Creates the median of the edge. Edge is a 1*4 array, containing [X1 Y1]
%   coordinates of first point, and [X2 Y2], the coordinates of the second
%   point.
%  
%   Example
%   % Draw the median line of two points
%     P1 = [10 20];
%     P2 = [30 50];
%     med = medianLine(P1, P2);
%     figure; axis square; axis([0 100 0 100]);
%     drawEdge([P1 P2], 'linewidth', 2, 'color', 'k');
%     drawLine(med)
%
%   % Draw the median line of an edge
%     P1 = [50 60];
%     P2 = [80 30];
%     edge = createEdge(P1, P2);
%     figure; axis square; axis([0 100 0 100]);
%     drawEdge(edge, 'linewidth', 2)
%     med = medianLine(edge);
%     drawLine(med)
%
%
%   See also:
%   lines2d, createLine, orthogonalLine
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 31/10/2003.
%

% history
% 2010-08-06 vectorize and change behaviour for N-by-4 inputs

nargs = length(varargin);
x0 = 0;
y0 = 0;
dx = 0;
dy = 0;

if nargs == 1
    tab = varargin{1};
    if size(tab, 2)==2
        % input is an array of two points
        x0 = tab(1,1); 
        y0 = tab(1,2);
        dx = tab(2,1)-x0; 
        dy = tab(2,2)-y0;
    else
        % input is an edge
        x0 = tab(:, 1); 
        y0 = tab(:, 2);
        dx = tab(:, 3) - tab(:, 1); 
        dy = tab(:, 4) - tab(:, 2);
    end
    
elseif nargs==2
    % input is given as two points, or two point arrays
    p1 = varargin{1};
    p2 = varargin{2};
    x0 = p1(:, 1); 
    y0 = p1(:, 2);
    dx = bsxfun(@minus, p2(:, 1), x0); 
    dy = bsxfun(@minus, p2(:, 2), y0);
    
else
    error('Too many input arguments');
end

% compute median using middle point of the edge, and the direction vector
% rotated by 90 degrees counter-clockwise
line = [bsxfun(@plus, x0, dx/2), bsxfun(@plus, y0, dy/2), -dy, dx];
