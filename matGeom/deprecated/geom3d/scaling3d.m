function trans = scaling3d(varargin)
%SCALING3D return 4x4 matrix of a 3D scaling.
%
%   TRANS = scaling3d(S);
%   returns the scaling transform corresponding to a scaling factor S in
%   each direction. S can be a scalar, or a 1x3 vector containing the
%   scaling factor in each direction.
%
%   TRANS = scaling3d(SX, SY, SZ);
%   returns the scaling transform corresponding to a different scaling
%   factor in each direction.
%
%   The returned matrix has the form :
%   [SX  0  0  0]
%   [ 0 SY  0  0]
%   [ 0  0 SZ  0]
%   [ 0  0  0  0]
%
%
%   See also:
%   transforms3d, transformPoint3d

% ------
% Author: David Legland 
% e-mail: david.legland@inrae.fr
% Created: 2006-04-20
% Copyright 2006 INRA - TPV URPOI - BIA IMASTE

% deprecation warning
warning('geom3d:deprecated', ...
    [mfilename ' is deprecated, use ''createScaling3d'' instead']);

% call current implementation
trans = createScaling3d(varargin{:});
