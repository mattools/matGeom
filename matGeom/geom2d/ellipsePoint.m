function point = ellipsePoint(elli, pos)
%ELLIPSEPOINT Coordinates of a point on an ellipse from parametric equation.
%
%   POINT = ellipsePoint(ELLI, POS)
%   Computes the coordinates of the point with parameter value POS on the
%   ellipse. POS is contained within [0, 2*PI].
%
%   Example
%     elli = [50 50  40 20  30];
%     pts = ellipsePoint(elli, linspace(0, pi, 12));
%     figure; drawEllipse(elli, 'b'); hold on;
%     axis equal; axis([0 100 0 100]);
%     drawPoint(pts, 'bo');
%
%   See also 
%     ellipses2d, drawEllipse, projPointOnEllipse, ellipseToPolygon
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2022-09-09, using Matlab 9.12.0.1884302 (R2022a)
% Copyright 2022-2024 INRAE - BIA Research Unit - BIBS Platform (Nantes)

% make sure pos is column vector
pos = pos(:);

% pre-compute rotation angles (given in degrees)
theta = elli(:,5);
cot = cosd(theta);
sit = sind(theta);

% compute position of points used to draw current ellipse
a = elli(:,3);
b = elli(:,4);
xt = elli(:,1) + a * cos(pos) * cot - b * sin(pos) * sit;
yt = elli(:,2) + a * cos(pos) * sit + b * sin(pos) * cot;

% concatenate
point = [xt yt];
