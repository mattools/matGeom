function fitCurvesCircleSkeleton(varargin)
%FITCURVESCIRCLESKELETON Demo of the polynomialCurveSetFit function
%
%   Simply apply the polynomialCurveSetFit function on a simple image of
%   skeletonized discs.
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2014-02-26,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2014 INRA - Cepia Software Platform.

%% Open input image

% Fit a set of curves to a binary skeleton
img = imread('circles.png');

% compute skeleton, and ensure one-pixel thickness
skel = bwmorph(img, 'skel', 'Inf');
skel = bwmorph(skel, 'shrink');
figure; imshow(skel==0)


%% Compute curve coeffs

% compute coeff of each individual branch
coeffs = polynomialCurveSetFit(skel, 2);

% Display segmented image 
figure; imshow(~img); hold on;

% overlay curves
for i = 1:length(coeffs)
    hc = drawPolynomialCurve([0 1], coeffs{i});
    set(hc, 'linewidth', 2, 'color', 'g');
end


%% Display only curves

% empty image
figure; imshow(ones(size(img))); hold on;

% overlay curves
for i = 1:length(coeffs)
    hc = drawPolynomialCurve([0 1], coeffs{i});
    set(hc, 'linewidth', 2, 'color', 'b');
end

