function proj = projPointOnEllipse(point, elli)
%PROJPOINTONELLIPSE Project a point orthogonally onto an ellipse.
%
%   PROJ = projPointOnEllipse(PT, ELLI)
%   Computes the (orthogonal) projection of point PT onto the ellipse given
%   by ELLI.
%
%
%   Example
%     % create an ellipse and a point
%     elli = [50 50 40 20 30];
%     pt = [60 10];
%     % display reference figures
%     figure; hold on; drawEllipse(elli, 'b');
%     axis equal; axis([0 100 0 100]);
%     drawPoint(pt, 'bo');
%     % compute projected point
%     proj = projPointOnEllipse(pt, elli);
%     drawEdge([pt proj], 'b');
%     drawPoint(proj, 'k*');
%
%   See also
%     ellipses2d, distancePointEllipse, projPointOnLine, ellipsePoint
%     drawEllipse
%

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2022-07-17, using Matlab 9.12.0.1884302 (R2022a)
% Copyright 2022 INRAE - BIA Research Unit - BIBS Platform (Nantes)

% defaults
nMaxIters = 4;

% compute transform to centered axis-aligned ellipse
center = elli(1:2);
theta = deg2rad(elli(5));
transfo = createRotation(-theta) * createTranslation(-center);
pointT = transformPoint(point, transfo);

% retrieve ellipse semi axis lengths
a = elli(3);
b = elli(4);

% keep absolute values
px = abs(pointT(:,1));
py = abs(pointT(:,2));

% initial guess of solution
tx = 0.707;
ty = 0.707;

% iterate
for i = 1:nMaxIters
    x = a * tx;
    y = b * ty;

    ex = (a*a - b*b) * power(tx, 3) / a;
    ey = (b*b - a*a) * power(ty, 3) / b;

    rx = x - ex;
    ry = y - ey;

    qx = px - ex;
    qy = py - ey;

    r = hypot(ry, rx);
    q = hypot(qy, qx);

    tx = min(1, max(0, (qx .* r ./ q + ex) / a));
    ty = min(1, max(0, (qy .* r ./ q + ey) / b));
    t = hypot(ty, tx);
    tx = tx ./ t;
    ty = ty ./ t;

end

% computes coordinates of projection
projX = a * tx;
projY = b * ty;

% fix sign
projX(pointT(:,1) < 0) = -projX(pointT(:,1) < 0);
projY(pointT(:,2) < 0) = -projY(pointT(:,2) < 0);

% project pack to basis of original ellipse
proj = transformPoint([projX projY], inv(transfo));
