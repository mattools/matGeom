function trans = scale3d(varargin)
%SCALE3D return 4x4 matrix of a 3D scaling
%
%   TRANS = scale3d(S);
%   return the scaling transform corresponding to a scaling factor S in
%   each direction. S can be a scalar, or a 1x3 vector containing the
%   scaling factor in each direction.
%
%   TRANS = scale3d(SX, SY, SZ);
%   return the scaling transform corresponding to a different scaling
%   factor in each direction.
%
%   The returned matrix has the form :
%   [SX  0  0  0]
%   [ 0 SY  0  0]
%   [ 0  0 SZ  0]
%   [ 0  0  0  0]
%
%   Note:
%   deprecated, use 'scaling3d' instead.
%
%   See also :
%   scaling3d, transforms3d, transformPoint3d
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 20/04/2006.
%

%   HISTORY
%   25/11/2008 deprecate

warning('geom3d:deprecated', ...
    'deprecated: call ''scaling3d'' instead');

if isempty(varargin)
    sx = 1;
    sy = 1;
    sz = 1;
elseif length(varargin)==1
    var = varargin{1};
    if length(var)==1
        sx = var;
        sy = var;
        sz = var;
    elseif length(var)==3        
        sx = var(1);
        sy = var(2);
        sz = var(3);
    else
        error('wrong size for first parameter of "scale3d"');
    end
else
    sx = varargin{1};
    sy = varargin{2};
    sz = varargin{3};
end

trans = [sx 0 0 0;0 sy 0 0;0 0 sz 0;0 0 0 1];