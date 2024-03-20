function trans = createScaling(varargin)
%CREATESCALING Create the 3*3 matrix of a scaling in 2 dimensions.
%
%   TRANS = createScaling(SX, SY);
%   return the matrix corresponding to scaling by SX and SY in the 2
%   main directions.
%   The returned matrix has the form:
%   [SX  0  0]
%   [0  SY  0]
%   [0   0  1]
%
%   TRANS = createScaling(SX);
%   Assume SX and SY are equals.
%
%   TRANS = createScaling(CENTER, ...);
%   Specifies the center of the scaling transform. The argument CENTER
%   should be a 1-by-2 array representing coordinates of center.
%
%   See also 
%   transforms2d, transformPoint, createTranslation, createRotation
%

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2004-04-07
% Copyright 2004-2023 INRA - TPV URPOI - BIA IMASTE

% defined default arguments
sx = 1;
sy = 1;
cx = 0;
cy = 0;

% process input arguments
if nargin == 1
    % the argument is either the scaling factor in both direction,
    % or a 1x2 array containing scaling factor in each direction
    var = varargin{1};
    sx = var(1);
    sy = var(1);
    if length(var)>1
        sy = var(2);
    end
elseif nargin == 2
    % the 2 arguments are the scaling factors in each dimension
    sx = varargin{1};
    sy = varargin{2};
elseif nargin == 3
    % first argument is center, 2nd and 3d are scaling factors
    center = varargin{1};
    cx = center(1);
    cy = center(2);
    sx = varargin{2};
    sy = varargin{3};
end

% concatenate results in a 3-by-3 matrix
trans = [sx 0 cx*(1-sx); 0 sy cy*(1-sy); 0 0 1];

