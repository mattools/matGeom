function varargout = transformVector3d(varargin)
%TRANSFORMVECTOR3D transform a vector with a 3D affine transform
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
%   V2 = transformVector3d(V1, TRANS);
%   Also works when V1 is a [Nx3] array of double. In this case, V2 has the
%   same size as V1. 
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


% process input arguments
if length(varargin)==2
    vectors = varargin{1};
    x = vectors(:,1);
    y = vectors(:,2);
    z = vectors(:,3);
    trans  = varargin{2};
    clear vectors;
elseif length(varargin)==4
    x = varargin{1};
    y = varargin{2};
    z = varargin{3};
    trans = varargin{4};
else 
    error('Syntax: transformVector3d(VECTOR, TRANSFORM)');
end

% keep initial dimension of input vector
dim = size(x); 
NP = length(x(:));
%points = [x(:) y(:) z(:) ones(NP, 1)];

% eventually add null translation
if size(trans, 2)==3
    trans = [trans zeros(size(trans, 1), 1)];
end

% eventually add normalization
if size(trans, 1)==3
    trans = [trans;0 0 0 1];
end

% Extract only the linear part of the affine transform
trans(1:4, 4) = [0; 0; 0; 1];

% convert coordinates
try
    % vectorial processing, if there is enough memory
    %res = (trans*[x(:) y(:) z(:) ones(NP, 1)]')';
    res = [x(:) y(:) z(:) ones(NP, 1)]*trans';
    
    % reshape data to original size
    x = reshape(res(:,1), dim);
    y = reshape(res(:,2), dim);
    z = reshape(res(:,3), dim);
catch
    % process each point one by one
    for i=1:length(x(:))
        res = [x(i) y(i) z(i) 1]*trans';
        x(i) = res(1);
        y(i) = res(2);
        z(i) = res(3);
    end
end


% process output arguments
if nargout==1 || nargout==0
    if length(dim)>2 || dim(2)>1
        varargout{1} = {x, y, z};
    else
        varargout{1} = [x y z];
    end
elseif nargout==3
    varargout{1} = x;
    varargout{2} = y;
    varargout{3} = z;
end   
