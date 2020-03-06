function ell = equivalentEllipse(points)
% Equivalent ellipse of a set of points.
%
%   ELL = equivalentEllipse(PTS);
%   Computes the ellips with the same moments up to the second order as the
%   set of points specified by the N-by-2 array PTS.
%
%   The result has the following form:
%   ELL = [XC YC A B THETA],
%   with XC and YC being the center of mass of the point set, A and B being
%   the lengths of the equivalent ellipse (see below), and THETA being the
%   angle of the first principal axis with the horizontal (counted in
%   degrees between 0 and 180 in counter-clockwise direction). 
%   A and B are the standard deviations of the point coordinates when
%   ellipse is aligned with the principal axes.
%
%   Example
%     pts = randn(100, 2);
%     pts = transformPoint(pts, createScaling(5, 2));
%     pts = transformPoint(pts, createRotation(pi/6));
%     pts = transformPoint(pts, createTranslation(3, 4));
%     ell = equivalentEllipse(pts);
%     figure(1); clf; hold on;
%     drawPoint(pts);
%     drawEllipse(ell, 'linewidth', 2, 'color', 'r');
%
%   See also
%     ellipses2d, drawEllipse, equivalentEllipsoid, principalAxes,
%     principalAxesTransform 
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2008-02-21,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2008 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

% HISTORY
% 2009-07-29 take into account ellipse orientation
% 2011-03-12 rewrite using equivalent moments

% ellipse center
xc = mean(points(:,1));
yc = mean(points(:,2));

% recenter points
x = points(:,1) - xc;
y = points(:,2) - yc;

% number of points
n = size(points, 1);

% equivalent parameters
Ixx = sum(x.^2) / n;
Iyy = sum(y.^2) / n;
Ixy = sum(x.*y) / n;

% compute ellipse semi-axis lengths
common = sqrt( (Ixx - Iyy)^2 + 4 * Ixy^2);
ra = sqrt(2) * sqrt(Ixx + Iyy + common);
rb = sqrt(2) * sqrt(Ixx + Iyy - common);

% compute ellipse angle in degrees
theta = atan2(2 * Ixy, Ixx - Iyy) / 2;
theta = rad2deg(theta);

% create the resulting equivalent ellipse
ell = [xc yc ra rb theta];
