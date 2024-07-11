function point = linePoint(line, pos)
%LINEPOINT Coordinates of a point on a line from its position.
%
%   POINT = linePoint(LINE, POS)
%   Retrieves the coordinates of the point located on the line LINE, at the
%   position given by POS. 
%   LINE should be a 1-by-4 row vector, and POS a scalar corresponding to
%   parametric position on the line. The result POINT is a N-by-2 array
%   corresponding to point coordinates.
%   Also supports array processing: either LINE or POS can be an array with
%   N rows and the other argument is a scalar, or both LINE and POS have N
%   rows. In all cases, the result is a N-by-2 array of point coordinates.
%
%   Example
%     line = createLine([10 30], [30 90]);
%     point = linePoint(line, 0.7);
%     linePosition(point, line)
%     ans =
%         0.7000
%
%   See also
%     lines2d, linePosition, edgePoint
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2024-07-11,    using Matlab 24.1.0.2628055 (R2024a) Update 4
% Copyright 2024 INRAE.

x = line(:,1) + pos(:) .* line(:,3);
y = line(:,2) + pos(:) .* line(:,4);
point = [x(:) y(:)];
