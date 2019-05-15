function varargout = transformVector3d(varargin)
%TRANSFORMVECTOR3D Transform a vector with a 3D affine transform.
%
%   V2 = transformVector3d(V1, TRANS);
%   Computes the vector obtained by transforming vector V1 with affine
%   transform TRANS.
%   V1 has the form [x1 y1 z1], and TRANS is a [3x3], [3x4], or [4x4]
%   matrix, with one of the forms:
%   [a b c]   ,   [a b c j] , or [a b c j]
%   [d e f]       [d e f k]      [d e f k]
%   [g h i]       [g h i l]      [g h i l]
%                                [0 0 0 1]
%
%   V2 = transformVector3d(V1, TRANS) also works when V1 is a [Nx3xMxEtc]
%   array of double. In this case, V2 has the same size as V1.
%
%   V2 = transformVector3d(X1, Y1, Z1, TRANS);
%   Specifies vectors coordinates in three arrays with same size.
%
%   [X2 Y2 Z2] = transformVector3d(...);
%   Returns the coordinates of the transformed vector separately.
%
%
%   See also:
%   vectors3d, transforms3d, transformPoint3d
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 25/11/2008 from transformPoint3d
%

if length(varargin)==2      % func(PTS_XYZ, PLANE) syntax
    vIds = 1:2; 
elseif length(varargin)==4  % func(X, Y, Z, PLANE) syntax
    vIds = 1:3;
end

% Extract only the linear part of the affine transform
trans = varargin{vIds(end)};
trans(1:4, 4) = [0; 0; 0; 1];

% Call transformPoint3d using equivalent output arguments
varargout = cell(1, max(1,nargout));
[varargout{:}] = transformPoint3d(varargin{vIds(1:end-1)}, trans);
