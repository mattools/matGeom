function trans = scaling3d(varargin)
%SCALING3D return 4x4 matrix of a 3D scaling
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
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 20/04/2006.
%

%   HISTORY
%   25/11/2008 rename from scale3d to scaling3d
%   HISTORY
%   30/04/2009 deprecate: use createScaling3d instead

% deprecation warning
warning('geom3d:deprecated', ...
    [mfilename ' is deprecated, use ''createScaling3d'' instead']);

% call current implementation
trans = createScaling3d(varargin{:});
