function len = polylineLength(poly, varargin)
%POLYLINELENGTH Return length of a polyline given as a list of points
%
%   L = polylineLength(POLY);
%   POLY should be a N-by-D array, where N is the number of points and D is
%   the dimension of the points.
%
%   L = polylineLength(..., TYPE);
%   Specifies if the last point is connected to the first one. TYPE can be
%   either 'closed' or 'open'.
%
%   L = polylineLength(POLY, POS);
%   Compute the length of the polyline between its origin and the position
%   given by POS. POS should be between 0 and N-1, where N is the number of
%   points of the polyline.
%
%
%   Example:
%   % Compute the perimeter of a circle with radius 1
%   polylineLength(circleAsPolygon([0 0 1], 500), 'closed')
%   ans = 
%       6.2831
%
%   See also:
%   polygons2d, polylineCentroid, polygonLength
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-04-30,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.


%   HISTORY
%   2006-05-22 manage any dimension for points, closed and open curves, 
%       and update doc accordingly.
%   2009-04-30 rename as polylineLength
%   2011-03-31 add control for empty polylines

% check there are enough points
if size(poly, 1) < 2
    len = 0;
    return;
end

% check whether the curve is closed or not (default is open)
closed = false;
if ~isempty(varargin)
    var = varargin{end};
    if ischar(var)
        if strcmpi(var, 'closed')
            closed = true;
        end
        varargin = varargin(1:end-1);
    end
end

% if the length is computed between 2 positions, compute only for a
% subcurve
if ~isempty(varargin)
    % values for 1 input argument
    t0 = 0;
    t1 = varargin{1};
    
    % values for 2 input arguments
    if length(varargin)>1
        t0 = varargin{1};
        t1 = varargin{2};
    end
    
    % extract a portion of the polyline
    poly = polylineSubcurve(poly, t0, t1);
end

% compute lengths of each line segment, and sum up
if closed
    len = sum(sqrt(sum(diff(poly([1:end 1],:)).^2, 2)));
else
    len = sum(sqrt(sum(diff(poly).^2, 2)));
end
