function [res thetaList] = polygonSignature(poly, varargin)
%POLYGONSIGNATURE Polar signature of a polygon (polar distance to origin)
%
%   DISTS = polygonSignature(POLY, THETALIST)
%   Computes the polar signature of a polygon, for a set of angles in
%   degrees.
%   
%   [DISTS THETA] = polygonSignature(...)
%   Also returns the angle set for which the signature was computed.
%
%   Example
%   polygonSignature
%
%   See also
%   polygons2d
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2013-03-14,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2013 INRA - Cepia Software Platform.

% default angle list
thetaList = 0:359;

% get user-defined angle list
if ~isempty(varargin)
    var = varargin{1};
    if isscalar(var)
        thetaList = linspace(0, 360, var+1);
        thetaList(end) = [];
    else
        thetaList = var;
    end
end

% also extract reference point if needed
center = [0 0];
if nargin > 2
    center = varargin{2};
end

% allocate memory
nTheta = length(thetaList);
res = zeros(nTheta, 1);

% iterate on angles
for i = 1:length(thetaList)
    theta = deg2rad(thetaList(i));
    ray = [center cos(theta) sin(theta)];

    ptInt = intersectRayPolygon(ray, poly);
    res(i) = distancePoints(center, ptInt(1,:));
end
