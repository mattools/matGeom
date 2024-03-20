function alpha = anglePoints3d(varargin)
%ANGLEPOINTS3D Compute angle between three 3D points.
%
%   ALPHA = anglePoints3d(P1, P2)
%   Computes angle (P1, O, P2), in radians, between 0 and PI.
%
%   ALPHA = anglePoints3d(P1, P2, P3)
%   Computes angle (P1, P2, P3), in radians, between 0 and PI.
%
%   ALPHA = anglePoints3d(PTS)
%   PTS is a 3x3 or 2x3 array containing coordinate of points.
%
%   Example
%       rad2deg(anglePoints3d([0 0 1],[1 1 0]))
%
%   See also 
%   points3d, angles3d

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2005-02-21
% Copyright 2005-2023 INRA - TPV URPOI - BIA IMASTE

p2 = [0 0 0];
if length(varargin) == 1
    pts = varargin{1};
    if size(pts, 1)==2
        p1 = pts(1,:);
        p0 = [0 0 0];
        p2 = pts(2,:);
    else
        p1 = pts(1,:);
        p0 = pts(2,:);
        p2 = pts(3,:);
    end
    
elseif length(varargin) == 2
    p1 = varargin{1};
    p0 = [0 0 0];
    p2 = varargin{2};
    
elseif length(varargin) == 3
    p1 = varargin{1};
    p0 = varargin{2};
    p2 = varargin{3};
end

% ensure all data have same size
n1 = size(p1, 1);
n2 = size(p2, 1);
n0 = size(p0, 1);

if n1 ~= n0
    if n1 == 1
        p1 = repmat(p1, [n0 1]);
        n1 = n0;
    elseif n0==1
        p0 = repmat(p0, [n1 1]);
    else
        error('Arguments P1 and P0 must have the same size');
    end
end

if n1 ~= n2
    if n1 == 1
        p1 = repmat(p1, [n2 1]);
    elseif n2 == 1
        p2 = repmat(p2, [n1 1]);
    else
        error('Arguments P1 and P2 must have the same size');
    end
end

% normalized vectors
p1 = normalizeVector3d(p1 - p0);
p2 = normalizeVector3d(p2 - p0);

% compute angle
alpha = acos(dot(p1, p2, 2));
