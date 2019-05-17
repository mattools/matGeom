function a = isTransform3d(trans, varargin)
%ISTRANSFORM3D Check if input is a affine transformation matrix.
%
%   A = isTransform3d(TRANS) where TRANS should be a transformation matrix.
%   The function accepts transformations given using the following formats:
%   [a b c]   ,   [a b c j] , or  [a b c j]
%   [d e f]       [d e f k]       [d e f k]
%   [g h i]       [g h i l]       [g h i l]
%                                 [0 0 0 1]
%   
%   If the transformation matrix should only contain rotation and
%   translation without reflection, scaling, shearing, ... set 'rotation'
%   to true. Default is false.
%
%   Example
%     rot = ...
%         createRotationOx(rand*2*pi)*...
%         createRotationOy(rand*2*pi)*...
%         createRotationOx(rand*2*pi);
%     trans = rot*createTranslation3d(rand(1,3));
%     isTransform3d(trans, 'rot', true)
%
%   See also
%   composeTransforms3d, createBasisTransform3d, recenterTransform3d,
%   transformPoint3d
%
% ------
% Author: oqilipo
% Created: 2018-07-08
% Copyright 2018

narginchk(1,3)

p = inputParser;
addParameter(p,'rotation',false,@islogical);
parse(p,varargin{:});
rotation = p.Results.rotation;

% eventually add null translation
if size(trans, 2) == 3
    trans = [trans zeros(size(trans, 1), 1)];
elseif size(trans, 2) < 3 || size(trans, 2) > 4
    a=false;
    return
end

% eventually add normalization
if size(trans, 1) == 3
    trans = [trans;0 0 0 1];
elseif size(trans, 1) < 3 || size(trans, 1) > 4
    a=false;
    return
end

a=true;

% NaN is invalid
if any(isnan(trans(:)))
    a=false;
    return
end

% Infinity is invalid
if any(isinf(trans(:)))
    a=false;
    return
end

% trans(4,4) has to be a one
if ~isequal(1, trans(4,4))
    a = false;
    return
end

% trans(4,1:3) have to be zeros
if ~isequal(zeros(1,3), trans(4,1:3))
    a = false;
    return
end

if rotation
    % transpose(trans(1:3,1:3)) * trans(1:3,1:3) has to be eye(3)
    if any(abs(eye(3) - (trans(1:3,1:3)'*trans(1:3,1:3))) > eps*1e8)
        a = false;
        return;
    end
    
    % determinant of trans(1:3) has to be one
    if abs(1-det(trans)) > eps*1e8
        a = false;
        return
    end
end

end

