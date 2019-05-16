function trans = createScaling3d(varargin)
%CREATESCALING3D Create the 4x4 matrix of a 3D scaling.
%
%   TRANS = createScaling3d(S);
%   returns the scaling transform corresponding to a scaling factor S in
%   each direction. S can be a scalar, or a 1-by-3 vector containing the
%   scaling factor in each direction.
%
%   TRANS = createScaling3d(SX, SY, SZ);
%   returns the scaling transform corresponding to a different scaling
%   factor in each direction.
%
%   The returned matrix has the form :
%   [SX  0  0  0]
%   [ 0 SY  0  0]
%   [ 0  0 SZ  0]
%   [ 0  0  0  0]
%
%   See also:
%   transforms3d, transformPoint3d, transformVector3d, createTranslation3d,
%   createRotationOx, createRotationOy, createRotationOz

%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 20/04/2006.
%

%   HISTORY
%   25/11/2008 rename from scale3d to scaling3d
%   30/04/2009 rename to createScaling3d


%% default arguments
sx = 1;
sy = 1;
sz = 1;
center = [0 0 0];

%% process input parameters
if nargin == 1
    % only one argument -> scaling factor
    [sx, sy, sz]= parseScalingFactors(varargin{1});
    
elseif nargin == 2
    % 2 arguments, giving center and uniform scaling
    center = varargin{1};
    [sx, sy, sz]= parseScalingFactors(varargin{2});

elseif nargin == 3
    % 3 arguments, giving scaling in each direction
    sx = varargin{1};
    sy = varargin{2};
    sz = varargin{3};
    
elseif nargin == 4
    % 4 arguments, giving center and scaling in each direction
    center = varargin{1};
    sx = varargin{2};
    sy = varargin{3};
    sz = varargin{4};
end

%% create the scaling matrix
trans = [...
    sx 0 0 center(1)*(1-sx);...
    0 sy 0 center(2)*(1-sy);...
    0 0 sz center(3)*(1-sz);...
    0 0 0 1];

%% Helper function
function [sx, sy, sz] = parseScalingFactors(var)

if length(var)==1
    % same scaling factor in each direction
    sx = var;
    sy = var;
    sz = var;
elseif length(var)==3
    % scaling is a vector, giving different scaling in each direction
    sx = var(1);
    sy = var(2);
    sz = var(3);
else
    error('wrong size for first parameter of "createScaling3d"');
end