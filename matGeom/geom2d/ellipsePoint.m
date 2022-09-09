function point = ellipsePoint(elli, pos)
% Coordinates of a point on an ellipse from parametric equation.
%
%   POINT = ellipsePoint(ELLI, POS)
%   Computes the coordinates of the point with parameter value POS on the
%   ellipse. POS is contained within [0, 2*PI].
%
%   Example
%     ellipsePoint
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2022-09-09,    using Matlab 9.12.0.1884302 (R2022a)
% Copyright 2022 INRAE.

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
