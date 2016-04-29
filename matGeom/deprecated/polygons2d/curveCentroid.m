function center = curveCentroid(varargin)
%CURVECENTROID compute centroid of a curve defined by a series of points
%
%   PT = curveCentroid(POINTS);
%   Computes center of mass of a curve defined by POINTS. POINTS is a [NxD]
%   array of double, N D-dimensional points.
%
%   PT = curveCentroid(PTX, PTY);
%   PT = curveCentroid(PTX, PTY, PTZ);
%   Specifies points as separate column vectors
%
%   PT = curveCentroid(..., TYPE);
%   Specifies if the last point is connected to the first one. TYPE can be
%   either 'closed' or 'open'.
%
%
%   See also :
%   polygons2d, centroid, polygonCentroid, curveLength
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 22/05/2006.
%

%   HISTORY
%   23/07/2009 deprecate and replace by 'reverseLine'.

% deprecation warning
warning('geom2d:deprecated', ...
    '''curveCentroid'' is deprecated, use ''polylineCentroid'' instead');


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

