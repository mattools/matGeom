function transfo = createBasisTransform(source, target)
%CREATEBASISTRANSFORM Compute matrix for transforming a basis into another basis
%
%   TRANSFO = createBasisTransform(SOURCE, TARGET)
%   Both SOURCE and TARGET represent basis, in the following form:
%   [x0 y0  ex1 ey1  ex2 ey2]
%   [y0 y0] is the origin of the basis, [ex1 ey1] is the first direction
%   vector, and [ex2 ey2] is the second direction vector.
%
%   The result TRANSFO is a 3-by-3 matrix such that a point expressed with
%   coordinates of the first basis will be represented by new coordinates
%   P2 = transformPoint(P1, TRANSFO) in the target basis.
%   
%   TRANSFO = createBasisTransform(TARGET)
%   Assumes the source is the standard (Oij) basis, with origin at (0,0),
%   first direction vector equal to (1,0) and second direction  vector
%   equal to (0,1).
%
%
%   Example
%     % standard basis transform
%     src = [0 0   1 0   0 1];
%     % target transform, just a rotation by atan(2/3) followed by a scaling
%     tgt = [0 0   .75 .5   -.5 .75];
%     % compute transform
%     trans = createBasisTransform(src, tgt);
%     % transform the point (.25,1.25) into the point (1,1)
%     p1 = [.25 1.25];
%     p2 = transformPoint(p1, trans)
%     ans =
%         1   1
%
%   See also
%   transforms2d
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-12-03,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

% init basis transform to identity
t1 = eye(3);
t2 = eye(3);

if nargin==2
    % from source to reference basis
    t1(1:2, 1) = source(3:4);
    t1(1:2, 2) = source(5:6);
    t1(1:2, 3) = source(1:2);
else
    % if only one input, use first input as target basis, and leave the
    % first matrix to identity
    target = source;
end

% from reference to target basis
t2(1:2, 1) = target(3:4);
t2(1:2, 2) = target(5:6);
t2(1:2, 3) = target(1:2);

% compute transfo
% same as: transfo = inv(t2)*t1;
transfo = t2\t1;

