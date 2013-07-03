function transfo = createBasisTransform3d(source, target)
%CREATEBASISTRANSFORM3D Compute matrix for transforming a basis into another basis
%
%   TRANSFO = createBasisTransform3d(SOURCE, TARGET) will create a 4-by-4
%   transformation matrix representing the transformation from SOURCE basis
%   to TARGET basis. 
%    SOURCE and TARGET are either standard 1-by-9 geom3d PLANE
%    representations of the form: [x0 y0 z0  ex1 ey1 ez1  ex2 ey2 ez2]
%     OR
%    SOURCE and TARGET may be any string such as 'global' or 'g' in which
%    case they represent the global plane [0 0 0 1 0 0 0 1 0].
%
%   The resulting TRANSFO matrix is such that a point expressed with
%   coordinates of the first basis will be represented by new coordinates
%   P2 = transformPoint3d(P1, TRANSFO) in the target basis.
%
%   Either (or both) SOURCE or TARGET may be an N-by-9 set of N planes. In
%   that case, TRANSFO will be a 4-by-4-by-N array of N transformation
%   matrices.
%
%   Example:
%     % Calculate local plane coords. of a point given in global coords
%     Plane = [5 50 500 1 0 0 0 1 0];
%     Tform = createBasisTransform3d('global', Plane);
%     PT_WRT_PLANE = transformPoint3d([3 8 2], Tform);
%
%   See also
%   transforms3d, transformPoint3d, createPlane

% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-12-03,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

% HISTORY
% 2013-07-03 added support for multiple inputs (Sven Holcombe)

% init basis transform to identity
srcSz = size(source,1);
tgtSz = size(target,1);
maxSz = max(srcSz,tgtSz);

if maxSz>1
    [t1, t2] = deal( bsxfun(@times, eye(4), ones(1,1,maxSz)) );
    if srcSz>1
        source = permute(source,[3 2 1]);
    end
    if tgtSz>1
        target = permute(target,[3 2 1]);
    end
else
    [t1, t2] = deal(eye(4));
end

% Place source and target planes into t1 and t2 t-form matrices. If either
% input is non-numeric it is assumed to mean 'global', or identity t-form.
if isnumeric(source)
    if maxSz>1 && srcSz==1
        source = bsxfun(@times, source, ones(1,1,maxSz));
    end
    t1(1:3, 1, :) = source(1, 4:6, :);
    t1(1:3, 2, :) = source(1, 7:9, :);
    t1(1:3, 3, :) = vectorCross3d(source(1,4:6,:), source(1,7:9,:));
    t1(1:3, 4, :) = source(1, 1:3, :);
end
if isnumeric(target)
    if maxSz>1 && tgtSz==1
        target = bsxfun(@times, target, ones(1,1,maxSz));
    end
    t2(1:3, 1, :) = target(1, 4:6, :);
    t2(1:3, 2, :) = target(1, 7:9, :);
    t2(1:3, 3, :) = vectorCross3d(target(1,4:6,:), target(1,7:9,:));
    t2(1:3, 4, :) = target(1, 1:3, :);
end

% compute transfo
% same as: transfo = inv(t2)*t1;
transfo = zeros(4,4,maxSz);
for i = 1:maxSz
    transfo(:,:,i) = t2(:,:,i) \ t1(:,:,i);
end
