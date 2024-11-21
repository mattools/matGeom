function point = line3dPoint(line, pos)
%LINE3DPOINT Coordinates of a 3D point on a 3D line from its position.
%
%   POINT = line3dPoint(LINE, POS)
%   Retrieves the coordinates of the point located on the line LINE, at the
%   position given by POS. 
%   LINE should be a 1-by-6 row vector, and POS a scalar corresponding to
%   parametric position on the line. The result POINT is a N-by-3 array
%   corresponding to point coordinates.
%   Also supports array processing: either LINE or POS can be an array with
%   N rows and the other argument is a scalar, or both LINE and POS have N
%   rows. In all cases, the result is a N-by-3 array of point coordinates.
%
%   Example
%     line = createLine3d([10 20 30], [30 90 60]);
%     point = line3dPoint(line, 0.7);
%     line3dPosition(point, line)
%     ans =
%         0.7000
%
%   See also 
%     lines3d, line3dPosition

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2024-07-11, using Matlab 24.1.0.2628055 (R2024a) Update 4
% Copyright 2024 INRAE - BIA Research Unit - BIBS Platform (Nantes)

x = line(:,1) + pos(:) .* line(:,4);
y = line(:,2) + pos(:) .* line(:,5);
z = line(:,3) + pos(:) .* line(:,6);
point = [x(:) y(:) z(:)];
