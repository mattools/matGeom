function varargout = rotation3dToEulerAngles(mat, varargin)
%ROTATION3DTOEULERANGLES Extract Euler angles from a rotation matrix.
%
%   [PHI, THETA, PSI] = rotation3dToEulerAngles(MAT)
%   Computes Euler angles PHI, THETA and PSI (in degrees) from a 3D 4-by-4
%   or 3-by-3 rotation matrix.
%
%   ANGLES = rotation3dToEulerAngles(MAT)
%   Concatenates results in a single 1-by-3 row vector. This format is used
%   for representing some 3D shapes like ellipsoids.
%
%   ... = rotation3dToEulerAngles(MAT, CONVENTION)
%   CONVENTION specifies the axis rotation sequence. 
%   Supported conventions are: 'ZYX', 'YXZ', 'ZYZ'. Default is 'ZYX'
%
%   Example
%   rotation3dToEulerAngles
%
%   References
%   Code from '1994 - Shoemake - Graphics Gems IV: Euler Angle Conversion:
%   http://webdocs.cs.ualberta.ca/~graphics/books/GraphicsGems/gemsiv/euler_angle/EulerAngles.c
%   (see also rotm2eul, that is part of MATLAB's Robotics System Toolbox)
%   Modified using explanations in:
%   http://www.gregslabaugh.net/publications/euler.pdf
%   https://www.geometrictools.com/Documentation/EulerAngles.pdf
%
%   See also
%   transforms3d, rotation3dAxisAndAngle, createRotation3dLineAngle,
%   eulerAnglesToRotation3d
%
%
% ------
% Authors: David Legland, oqilipo
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-08-11,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

p = inputParser;
validStrings = {...
    'ZYX','ZXY','YXZ','YZX','XYZ','XZY',...
    'ZYZ'};
addOptional(p,'convention','ZYX',@(x) any(validatestring(x,validStrings)));
logParValidFunc = @(x) (islogical(x) || isequal(x,1) || isequal(x,0));
addParameter(p,'IsRotation', 1, logParValidFunc);
valTol = @(x) validateattributes(x,{'numeric'},{'scalar', '>=',eps(class(mat)), '<=',1});
addParameter(p,'tolerance', 1e-8, valTol);
parse(p,varargin{:});
convention=p.Results.convention;
isRotation = p.Results.IsRotation;
tolerance = p.Results.tolerance;

if isRotation
    if ~isTransform3d(mat(1:3,1:3), 'rotation', 1, 'tolerance', tolerance)
        warning(['Rotation matrix contains reflection or scaling ' ...
            'tested with a tolerance of ' num2str(tolerance) '.' newline ...
            'Calculation of euler angles might be incorrect.'])
    end
end

switch convention
    case 'ZYX'
        % extract |cos(theta)|
        cy = hypot(mat(1,1), mat(2,1));
        % avoid dividing by 0
        if cy > 16*eps
            % normal case: theta <> 0
            phi   = atan2( mat(2,1), mat(1,1));
            theta = atan2(-mat(3,1), cy);
            psi   = atan2( mat(3,2), mat(3,3));
        else
            phi   = 0;
            theta = atan2(-mat(3,1), cy);
            psi   = atan2(-mat(2,3), mat(2,2));
        end
    case 'ZXY'
        cy = hypot(mat(2,2), mat(1,2));
        if cy > 16*eps
            phi   = -atan2( mat(1,2), mat(2,2));
            theta = -atan2(-mat(3,2), cy);
            psi   = -atan2( mat(3,1), mat(3,3));
        else
            phi   = 0;
            theta = -atan2(-mat(3,2), cy);
            psi   = -atan2(-mat(1,3), mat(1,1));
        end
    case 'YXZ'
        cy = hypot(mat(3,3), mat(1,3));
        if cy > 16*eps
            phi   = atan2( mat(1,3), mat(3,3));
            theta = atan2(-mat(2,3), cy);
            psi   = atan2( mat(2,1), mat(2,2));
        else
            phi   = 0;
            theta = atan2(-mat(2,3), cy);
            psi   = atan2(-mat(1,2), mat(1,1));
        end
    case 'YZX'
        cy = hypot(mat(1,1), mat(3,1));
        if cy > 16*eps
            phi   = -atan2( mat(3,1), mat(1,1));
            theta = -atan2(-mat(2,1), cy);
            psi   = -atan2( mat(2,3), mat(2,2));
        else
            phi   = 0;
            theta = -atan2(-mat(2,1), cy);
            psi   = -atan2(-mat(3,2), mat(3,3));
        end
    case 'XYZ'
        cy = hypot(mat(3,3), mat(2,3));
        if cy > 16*eps
            phi   = -atan2( mat(2,3), mat(3,3));
            theta = -atan2(-mat(1,3), cy);
            psi   = -atan2( mat(1,2), mat(1,1));
        else
            phi   = 0;
            theta = -atan2(-mat(1,3), cy);
            psi   = -atan2(-mat(2,1), mat(2,2));
        end
    case 'XZY'
        cy = hypot(mat(2,2), mat(3,2));
        if cy > 16*eps
            phi   = atan2( mat(3,2), mat(2,2));
            theta = atan2(-mat(1,2), cy);
            psi   = atan2( mat(1,3), mat(1,1));
        else
            phi   = 0;
            theta = atan2(-mat(1,2), cy);
            psi   = atan2(-mat(3,1), mat(3,3));
        end
    case 'ZYZ'
        cy = hypot(mat(3,2), mat(3,1));
        if cy > 16*eps
            phi   = -atan2(mat(2,3), -mat(1,3));
            theta = -atan2(cy, mat(3,3));
            psi   = -atan2(mat(3,2), mat(3,1));
        else
            phi   = 0;
            theta = atan2(cy, mat(3,3));
            psi   = atan2(mat(2,1), mat(2,2));
        end
end

% format output arguments
if nargout <= 1
    % one array
    varargout{1} = rad2deg([phi theta psi]);
else
    % three separate arrays
    varargout = cellfun(@rad2deg, {phi theta psi},'uni',0);
end
