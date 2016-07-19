function varargout = polygonSelfIntersections(poly, varargin)
%POLYGONSELFINTERSECTIONS Find self-intersection points of a polygon
%
%   PTS = polygonSelfIntersections(POLY)
%   Return the position of self intersection points
%
%   [PTS, POS1, POS2] = polygonSelfIntersections(POLY)
%   Also return the 2 positions of each intersection point (the position
%   when meeting point for first time, then position when meeting point
%   for the second time).
%
%   [...] = polygonSelfIntersections(POLY, 'tolerance', TOL)
%   Specifies an additional parameter to decide whether two intersection
%   points should be considered the same, based on their euclidean
%   distance.  
%
%
%   Example
%       % use a '8'-shaped polygon
%       poly = [10 0;0 0;0 10;20 10;20 20;10 20];
%       polygonSelfIntersections(poly)
%       ans = 
%           10 10
%
%   See also
%   polygons2d, polylineSelfIntersections
%

% ------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% Created: 2009-06-15,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.

%   HISTORY
%   2011-06-22 fix bug when removing origin vertex (thanks to Federico
%       Bonelli)

tol = 1e-14;

% parse optional arguments
while length(varargin) > 1
    pname = varargin{1};
    if ~ischar(pname)
        error('Expect optional arguments as name-value pairs');
    end
    
    if strcmpi(pname, 'tolerance')
        tol = varargin{2};
    else
        error(['Unknown parameter name: ' pname]);
    end
    varargin(1:2) = [];
end

% ensure the last point equals the first one
if sum(abs(poly(end, :)-poly(1,:)) < tol) ~= 2
    poly = [poly; poly(1,:)];
end

% compute intersections by calling algo for polylines
[points, pos1, pos2] = polylineSelfIntersections(poly, 'closed', 'tolerance', tol);

% It may append that first vertex of polygon is detected as intersection,
% the following tries to detect this.
% (pos1 < pos2 by construction)
n = size(poly, 1) - 1;
inds = abs(pos1) < tol & abs(pos2 - n) < tol;
points(inds, :) = [];
pos1(inds)   = [];
pos2(inds)   = [];


%% Post-processing

% process output arguments
if nargout <= 1
    varargout = {points};
elseif nargout == 3
    varargout = {points, pos1, pos2};
end
