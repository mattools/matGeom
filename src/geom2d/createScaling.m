function trans = createScaling(varargin)
%CREATESCALING Create the 3*3 matrix of a scaling in 2 dimensions
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
%   See also:
%   transforms2d, transformPoint, createTranslation, createRotation
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 07/04/2004.


%   HISTORY
%   04/01/2007: rename as scaling
%   22/04/2009: rename as createScaling

% defined default arguments
sx = 1;
sy = 1;
cx = 0;
cy = 0;

% process input arguments
if length(varargin)==1
    % the argument is either the scaling factor in both direction,
    % or a 1x2 array containing scaling factor in each direction
    var = varargin{1};
    sx = var(1);
    sy = var(1);
    if length(var)>1
        sy = var(2);
    end
elseif length(varargin)==2
    % the 2 arguments are the scaling factors in each dimension
    sx = varargin{1};
    sy = varargin{2};
elseif length(varargin)==3
    % first argument is center, 2nd and 3d are scaling factors
    center = varargin{1};
    cx = center(1);
    cy = center(2);
    sx = varargin{2};
    sy = varargin{3};
end

% create result matrix
trans = [sx 0 cx*(1-sx); 0 sy cy*(1-sy); 0 0 1];

