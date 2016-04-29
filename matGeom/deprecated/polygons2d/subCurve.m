function res = subCurve(curve, P1, P2, varargin)
%SUBCURVE  extract a portion of a curve
%
%   CURVE2 = subCurve(CURVE, POS1, POS2)
%   extract a subcurve by keeping only points located between indices POS1
%   and POS2. If POS1>POS2, function considers all points after POS1 and
%   all points before POS2.
%
%   CURVE2 = subCurve(CURVE, POS1, POS2, DIRECT)
%   If DIRECT is false, curve points are taken in reverse order, from POS1
%   to POS2 with -1 increment, or from POS1 to 1, then from last point to
%   POS2 index. If direct is true, behaviour corresponds to the first
%   described case.
%
%   Example
%   C = circleAsPolygon([0 0 10], 120);
%   C2 = subCurve(C, 30, 60);
%
%   See also
%   polygons2d
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2007-08-23,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2007 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

% deprecation warning
warning('geom2d:deprecated', ...
    '''subCurve'' will be deprecated in a future release, please consider using ''polylineSubcurve''');

% check if curve is inverted
direct = true;
if ~isempty(varargin)
    direct = varargin{1};
end

% process different cases
if direct
    if P1<P2
        res = curve(P1:P2, :);
    else
        res = curve([P1:end 1:P2], :);
    end
else
    if P1<P2
        res = curve([P1:-1:1 end:-1:P2], :);
    else
        res = curve(P1:-1:P2, :);
    end
end

