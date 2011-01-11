function polylines2d(varargin)
%POLYLINES2D Description of functions operating on polylines
%   
%   Polylines are represented by a set of points. Contrary to polygons,
%   polylines are open: the last point is not connected to the first one.
%   
%   As most functions were used to describe curved objects, the name
%   'curve' is often present in function names.
%
%   Polylines are parametrized in the following way:
%   - the i-th vertex is located at position i-1
%   - points of the i-th edge have positions ranging linearly from i-1 to i
%   The parametrisation domain for an open polyline is from 0 to Nv-1, and
%   from 0 to Nv for a closed polyline (positions 0 and Nv correspond to
%   the same point).
%
%
%   See also:
%   polylinePoint, polylineLength, distancePointPolyline, polylineSubcurve
%   distancePolylines, projPointOnPolyline, intersectPolylines
%   polylineSelfIntersections, isPointOnPolyline, reversePolyline
%   polylineSubCurve, polylineLength, polylineCentroid
%   parametrize, curvature, cart2geod, geod2cart
%   curveMoment, curveCMoment, curveCSMoment
%   drawPolyline
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2008-10-13,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2008 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

help('polylines2d');