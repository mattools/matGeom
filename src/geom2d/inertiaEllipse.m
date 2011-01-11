function ell = inertiaEllipse(pts)
%INERTIAELLIPSE  inertia ellipse of a set of points
%
%   ELL = inertiaEllipse(PTS);
%   where PTS is a N*2 array containing coordinates of N points, computes
%   the inertia ellispe of the set of points.
%
%   The result has the form:
%   ELL2 = [XC YC A B THETA],
%   with XC and YC being the center of mass of the point set, A and B are
%   the lengths of the inertia ellipse (see below), and THETA is the angle
%   of the main inertia axis with the horizontal (between 0 and PI).
%   A and B are the standard deviations of the point coordinates when
%   ellipse is aligned with the inertia axes.
%
%   Example
%   pts = randn(100, 2);
%   pts = transformPoint(pts, createScaling(5, 2));
%   pts = transformPoint(pts, createRotation(pi/6));
%   pts = transformPoint(pts, createTranslation(3, 4));
%   ell = inertiaEllipse(pts);
%   figure(1); clf; hold on;
%   drawPoint(pts);
%   drawEllipse(ell, 'linewidth', 2, 'color', 'r');
%
%   See also
%   circles2d
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2008-02-21,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2008 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

%   HISTORY
%   29/07/2009 take into account ellipse orientation

% number of points
n = size(pts, 1);

% center of mass of points
center = mean(pts);

% compute the covariance matrix
covPts = cov(pts)/(n-1);

% perform a principal component analysis with 2 variables, 
% to extract inertia axes
[U S] = svd(covPts);

% extract length of each semi axis
radii = sqrt(diag(S)*n);

% index of first axis
[dummy ind] = max(radii);

% sort axes from greater to lower
radii   = sort(radii, 'descend')';

% compute angle of ellipse, from the greater principal vector
U0 = U(:, ind(1))';
theta   = mod(vectorAngle(U0), pi);

% create the resulting inertia ellipse
ell = [center radii theta];
