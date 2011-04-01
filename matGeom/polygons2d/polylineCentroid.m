function center = polylineCentroid(varargin)
%POLYLINECENTROID Compute centroid of a curve defined by a series of points
%
%   PT = polylineCentroid(POINTS);
%   Computes center of mass of a polyline defined by POINTS. POINTS is a
%   [NxD] array of double, representing a set of N points in a
%   D-dimensional space.
%
%   PT = polylineCentroid(PTX, PTY);
%   PT = polylineCentroid(PTX, PTY, PTZ);
%   Specifies points as separate column vectors
%
%   PT = polylineCentroid(..., TYPE);
%   Specifies if the last point is connected to the first one. TYPE can be
%   either 'closed' or 'open'.
%
%   Example
%   poly = [0 0;10 0;10 10;20 10];
%   polylineCentroid(poly)
%   ans = 
%       [10 5]
%
%   See also:
%   polygons2d, centroid, polygonCentroid, polylineLength
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 22/05/2006.
%



%% process input arguments

% check whether the curve is closed
closed = false;
var = varargin{end};
if ischar(var)
    if strcmpi(var, 'closed')
        closed = true;
    end
    varargin = varargin(1:end-1);
end

% extract point coordinates
if length(varargin)==1
    points = varargin{1};
elseif length(varargin)==2
    points = [varargin{1} varargin{2}];
end

% compute centers and lengths composing the curve
if closed
    centers = (points + points([2:end 1],:))/2;
    lengths = sqrt(sum(diff(points([1:end 1],:)).^2, 2));
else
    centers = (points(1:end-1,:) + points(2:end,:))/2;
    lengths = sqrt(sum(diff(points).^2, 2));
end

% centroid of edge centers weighted by edge length
%weigths = repmat(lengths/sum(lengths), [1 size(points, 2)]); 
center = sum(centers.*repmat(lengths, [1 size(points, 2)]), 1)/sum(lengths);

