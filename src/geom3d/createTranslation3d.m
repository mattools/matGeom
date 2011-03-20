function trans = createTranslation3d(varargin)
%CREATETRANSLATION3D Create the 4x4 matrix of a 3D translation
%
%   usage:
%   TRANS = createTranslation3d(DX, DY, DZ);
%   return the translation corresponding to DX and DY.
%   The returned matrix has the form :
%   [1 0 0 DX]
%   [0 1 0 DY]
%   [0 0 1 DZ]
%   [0 0 0  1]
%
%   TRANS = createTranslation3d(VECT);
%   return the translation corresponding to the given vector [x y z].
%
%
%   See also:
%   transforms3d, transformPoint3d, transformVector3d, 
%   createRotationOx, createRotationOy, createRotationOz, createScaling3d
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 06/04/2004.
%

%   HISTORY
%   22/04/2009 rename as createTranslation3d


if isempty(varargin)
    % assert translation with null vector
    dx = 0;
    dy = 0;
    dz = 0;
elseif length(varargin)==1
    % translation vector given in a single argument
    var = varargin{1};
    dx = var(1);
    dy = var(2);
    dz = var(3);
else
    % translation vector given in 3 arguments
    dx = varargin{1};
    dy = varargin{2};
    dz = varargin{3};
end

% create the translation matrix
trans = [1 0 0 dx ; 0 1 0 dy ; 0 0 1 dz; 0 0 0 1];
