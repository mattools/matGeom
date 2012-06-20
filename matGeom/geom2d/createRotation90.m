function mat = createRotation90(varargin)
%CREATEROTATION90  Matrix of a rotation for 90 degrees multiples
%
%   MAT = createRotation90
%   Returns the 3-by-3 matrix corresponding to a rotation by 90 degrees.
%   As trigonometric functions are explicitley converted to +1 or -1, the
%   resulting matrix obtained with this function is more precise than 
%   the one obtained with createRotation.
%
%   MAT = createRotation90(NUM)
%   Specifies the number of rotations to performs. NUM should be an integer
%   (possibly negative).
%
%   Example
%     poly = [10 0;20 0;10 10];
%     rot = createRotation90;
%     poly2 = transformPoint(poly, rot);
%     figure; hold on; axis equal;
%     drawPolygon(poly);
%     drawPolygon(poly2, 'm');
%     legend('original', 'rotated');
%
%     % specify number of rotations, and center
%     rot = createRotation90(2, [10 10]);
%     poly3 = transformPoint(poly, rot);
%     drawPolygon(poly3, 'g');
%
%   See also
%   transforms2d, createRotation
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-06-20,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

% default values
num = 1;
center = [0 0];

% process input arguments
while ~isempty(varargin)
    var = varargin{1};
    if isnumeric(var) && isscalar(var)
        % extract number of rotations
        num = mod(mod(var, 4) + 4, 4);
        
    elseif isnumeric(var) && length(var) == 2
        % extract rotation center
        center = var;
        
    else
        % unknown argument
        error('MatGeom:createRotation90', ...
            'Unable to parse input arguments');
    end
    varargin(1) = [];
end

% determine rotation parameters
switch num
    case 0
        ct = 1;
        st = 0;
    case 1
        ct = 0;
        st = 1;
    case 2
        ct = -1;
        st = 0;
    case 3
        ct = 0;
        st = -1;
end

% compute transform matrix
mat = [ ...
    ct -st 0; ...
    st ct 0; ...
    0 0 1];

% change center if needed
if sum(center ~= [0 0]) > 0
    tra = createTranslation(center);
    mat = tra * mat / tra; 
end
