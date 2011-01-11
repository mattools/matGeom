function transfo = createBasisTransform3d(source, target)
%CREATEBASISTRANSFORM3D Compute matrix for transforming a basis into another basis
%
%   TRANSFO = createBasisTransform3d(SOURCE, TARGET)
%   Both SOURCE and TARGET represent basis, in the following form:
%   [x0 y0 z0   ex1 ey1 ez1  ex2 ey2 ez2  ex3 ey3 ez3]
%   [y0 y0 z0] is the origin of the basis, [ex1 ey1 ez1] is the first
%   direction vector, [ex2 ey2 ez2] is the second direction vector, and
%   [ex3 ey3 ez3] is the third direction vector.
%
%   The result TRANSFO is a 4-by-4 matrix such that a point expressed with
%   coordinates of the first basis will be represented by new coordinates
%   P2 = transformPoint3d(P1, TRANSFO) in the target basis.
%   
%   TRANSFO = createBasisTransform3d(TARGET)
%   Assumes the source is the standard (Oijk) basis, with origin at
%   (0,0,0), first direction vector equal to (1,0,0), second direction
%   vector equal to (0,1,0) and third direction vector equal to (0,0,1).
%
%
%   Example
%
%   See also
%   transforms3d
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-12-03,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

% init basis transform to identity
t1 = eye(4);
t2 = eye(4);

if nargin==2
    % from source to reference basis
    t1(1:3, 1) = source(4:6);
    t1(1:3, 2) = source(7:9);
    t1(1:3, 3) = source(1:3);
else
    % if only one input, use first input as target basis, and leave the
    % first matrix to identity
    target = source;
end

% from reference to target basis
t2(1:3, 1) = target(4:6);
t2(1:3, 2) = target(7:9);
t2(1:3, 3) = target(1:3);

% compute transfo
% same as: transfo = inv(t2)*t1;
transfo = t2\t1;

