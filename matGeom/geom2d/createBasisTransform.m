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
%     % define source and target bases
%     src = [ 0 0   1  0    0  1];
%     tgt = [20 0  .5 .5  -.5 .5];
%     trans = createBasisTransform(src, tgt);
%     % create a polygon in source basis
%     poly = [10 10;30 10; 30 20; 20 20;20 40; 10 40];
%     figure;
%     subplot(121); drawPolygon(poly, 'b'); axis equal; axis([-10 50 -10 50]);
%     hold on; drawLine([0 0 1 0], 'k'); drawLine([0 0 0 1], 'k');
%     drawLine([20 0 1 1], 'r'); drawLine([20 0 -1 1], 'r');
%     t = -1:5; plot(t*5+20, t*5, 'r.'); plot(-t*5+20, t*5, 'r.');
%     % transform the polygon in target basis
%     poly2 = transformPoint(poly, trans);
%     subplot(122); drawPolygon(poly2, 'b'); axis equal; axis([-10 50 -10 50]);
%     hold on; drawLine([0 0 1 0], 'r'); drawLine([0 0 0 1], 'r');
%     t = -1:5; plot(t*10, zeros(size(t)), 'r.'); plot(zeros(size(t)), t*10, 'r.');
%
%   See also
%   transforms2d
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2010-12-03,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

% init basis transform to identity
t1 = eye(3);
t2 = eye(3);

if nargin == 2
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

% compute transform matrix
transfo = zeros(3, 3);
maxSz = 1;
for i = 1:maxSz
    % coordinate of three reference points in source basis
    po = t1(1:2, 3, i)';
    px = po + t1(1:2, 1, i)';
    py = po + t1(1:2, 2, i)';
    
    % express coordinates of reference points in the new basis
    t2i = inv(t2(:,:,i));
    pot = transformPoint(po, t2i);
    pxt = transformPoint(px, t2i);
    pyt = transformPoint(py, t2i);
    
    % compute direction vectors in new basis
    vx = pxt - pot;
    vy = pyt - pot;

    % concatenate result in a 3-by-3 affine transform matrix 
    transfo(:,:,i) = [vx' vy' pot' ; 0 0 1];
end

