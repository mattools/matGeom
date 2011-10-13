function varargout = transformPoint3d(varargin)
%TRANSFORMPOINT3D Transform a point with a 3D affine transform
%
%   PT2 = transformPoint3d(PT1, TRANS);
%   PT2 = transformPoint3d(X1, Y1, Z1, TRANS);
%   where PT1 has the form [xp yp zp], and TRANS is a [3x3], [3x4], [4x4]
%   matrix, return the point transformed according to the affine transform
%   specified by TRANS.
%
%   Format of TRANS is a 4-by-4 matrix.
%
%   The function accepts transforms given using the following formats:
%   [a b c]   ,   [a b c j] , or [a b c j]
%   [d e f]       [d e f k]      [d e f k]
%   [g h i]       [g h i l]      [g h i l]
%                                [0 0 0 1]
%
%   PT2 = transformPoint3d(PT1, TRANS) 
%   also work when PT1 is a [Nx3xMxPxETC] array of double. In this case, 
%   PT2 has the same size as PT1.
%
%   PT2 = transformPoint3d(X1, Y1, Z1, TRANS);
%   also work when X1, Y1 and Z1 are 3 arrays with the same size. In this
%   case, PT2 will be a 1-by-3 cell containing {X Y Z} outputs of size(X1).
%
%   [X2 Y2 Z2] = transformPoint3d(...);
%   returns the result in 3 different arrays the same size as the input.
%   This form can be useful when used with functions like meshgrid or warp.
%
%
%   See also:
%   points3d, transforms3d, translation3d
%   meshgrid
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 10/02/2005.
%

%   23/03/2006 add support for non vector point data
%   26/10/2006 better support for large data handling: iterate on points
%       in the case of a memory lack.
%   20/04/2007 add link to rotationXX functions
%   29/09/2010 fix bug in catch case
%   12/03/2011 slightly reduce memory usage

% process input arguments
if length(varargin) == 2
    % Point coordinates are given in a single N-by-3-by-M-by-etc argument.
    % Preallocate x, y, and z to size N-by-1-by-M-by-etc, then fill them in
    dim = size(varargin{1});
    dim(2) = 1;
    [x,y,z] = deal(zeros(dim,class(varargin{1})));
    x(:) = varargin{1}(:,1,:);
    y(:) = varargin{1}(:,2,:);
    z(:) = varargin{1}(:,3,:);
    trans  = varargin{2};
    
elseif length(varargin) == 4
    % Point coordinates are given in 3 different arrays
    x = varargin{1};
    y = varargin{2};
    z = varargin{3};
    dim = size(x);
    trans = varargin{4};
end

% eventually add null translation
if size(trans, 2) == 3
    trans = [trans zeros(size(trans, 1), 1)];
end

% eventually add normalization
if size(trans, 1) == 3
    trans = [trans;0 0 0 1];
end

% convert coordinates
NP  = numel(x);
try
    % vectorial processing, if there is enough memory
    %res = (trans*[x(:) y(:) z(:) ones(NP, 1)]')';
    %res = [x(:) y(:) z(:) ones(NP, 1)]*trans';    
    res = [x(:) y(:) z(:) ones(NP,1,class(x))] * trans';
    
    % Back-fill x,y,z with new result (saves calling costly reshape())
    x(:) = res(:,1);
    y(:) = res(:,2);
    z(:) = res(:,3);
catch ME
    disp(ME.message)
    % process each point one by one, writing in existing array
    for i = 1:NP
        res = [x(i) y(i) z(i) 1] * trans';
        x(i) = res(1);
        y(i) = res(2);
        z(i) = res(3);
    end
end

% process output arguments
if nargout <= 1
    % results are stored in a unique array
    if length(dim) > 2 && dim(2) > 1
        warning('geom3d:shapeMismatch',...
            'Shape mismatch: Non-vector xyz input should have multiple x,y,z output arguments. Cell {x,y,z} returned instead.')
        varargout{1} = {x,y,z};
    else
        varargout{1} = [x y z];
    end
    
elseif nargout == 3
    varargout{1} = x;
    varargout{2} = y;
    varargout{3} = z;
end
