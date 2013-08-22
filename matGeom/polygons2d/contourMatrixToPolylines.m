function polys = contourMatrixToPolylines(C)
%CONTOURMATRIXTOPOLYLINES Converts a contour matrix array into a polyline set
%
%   POLYS = contourMatrixToPolylines(C)
%   Converts the contour matrix array, as given as the result of the
%   contourc function, into a set of polylines.
%
%   Example
%     img = imread('circles.png');
%     C = contourc(img, 1);
%     polys = contourMatrixToPolylines(C);
%     imshow(img); hold on;
%     drawPolyline(polys, 'Color', 'r', 'LineWidth', 2);
%
%   See also
%     polygons2d, contour, contourc

% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2013-08-22,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2013 INRA - Cepia Software Platform.

% size of the contour matrix array
nCoords = size(C, 2);

% first, compute the number of contours
nContours = 0;
offset = 1;
while offset < nCoords
    nContours = nContours + 1;
    offset = offset + C(2, offset) + 1;
end

% extract each contour as a polygon or polyline
polys = cell(nContours, 1);
offset = 1;
for iContour = 1:nContours
    nv = C(2, offset);
    polys{iContour} = C(:, offset + (1:nv))';
    offset = offset + nv + 1;
end
