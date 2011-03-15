function trans = createTranslation(varargin)
%CREATETRANSLATION Create the 3*3 matrix of a translation
%
%   TRANS = createTranslation(DX, DY);
%   Returns the translation corresponding to DX and DY.
%   The returned matrix has the form :
%   [1 0 TX]
%   [0 1 TY]
%   [0 0  1]
%
%   TRANS = createTranslation(VECTOR);
%   Returns the matrix corresponding to a translation by the vector [x y].
%
%
%   See also:
%   transforms2d, transformPoint, createRotation, createScaling
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 06/04/2004.
%

%   HISTORY
%   22/04/2009: rename as createTranslation

% process input arguments
if isempty(varargin)
    tx = 0;
    ty = 0;
elseif length(varargin)==1
    var = varargin{1};
    tx = var(1);
    ty = var(2);
else
    tx = varargin{1};
    ty = varargin{2};
end

% create the matrix representing the translation
trans = [1 0 tx ; 0 1 ty ; 0 0 1];