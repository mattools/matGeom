function [res, thetaList] = polygonSignature(poly, varargin)
%POLYGONSIGNATURE Polar signature of a polygon (polar distance to origin).
%
%   DISTS = polygonSignature(POLY, THETALIST)
%   Computes the polar signature of a polygon, for a set of angles in
%   degrees. If a ray at a given angle does not intersect the polygon, the
%   corresponding distance value is set to NaN.
%
%   DISTS = polygonSignature(POLY, N)
%   When N is a scalar, uses N angles equally distributed between 0 and 360
%   degrees.
%   
%   [DISTS, THETA] = polygonSignature(...)
%   Also returns the angle set for which the signature was computed.
%
%   Example
%   polygonSignature
%
%   See also 
%     polygons2d, signatureToPolygon, intersectRayPolygon
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2013-03-14, using Matlab 7.9.0.529 (R2009b)
% Copyright 2013-2023 INRA - Cepia Software Platform

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
res = NaN * ones(nTheta, 1);

% iterate on angles
for i = 1:length(thetaList)
    theta = deg2rad(thetaList(i));
    ray = [center cos(theta) sin(theta)];

    ptInt = intersectRayPolygon(ray, poly);
    if ~isempty(ptInt)
        res(i) = distancePoints(center, ptInt(1,:));
    end
end
