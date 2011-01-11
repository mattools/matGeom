function polynomialCurves2d(varargin)
%POLYNOMIALCURVES2D Description of functions operating on polynomial curves
%
%   Polynomial curves are plane curves whose points are defined by a
%   polynomial for each x and y coordinate.
%   A polynomial curve is represented by 3 row vectors:
%   - the bounds of the parametrization
%   - the coefficients for the x coordinate (in increasing degree)
%   - the coefficients for the y coordinate (in increasing degree)
%
%   Example:
%   C = {[0 1], [3 4], [0 1 -1]};
%   represents the curve defined by:
%       x(t) = 3 + 4*t;
%       y(t) = t - t*t;
%   for t belonging to the interval [0 1].
%
%   As each coordinate are given by polynoms, it is possible to compute
%   various parameters like curvature, normal, or the exact geodesic length
%   of the curve.
%
%   See also
%   polynomialCurvePoint, polynomialCurvePosition
%   polynomialCurveDerivative, polynomialCurveNormal,
%   polynomialCurveCurvature, polynomialCurveCurvatures
%   polynomialCurveProjection
%   polynomialCurveLength, polynomialCurveCentroid
%   polynomialCurveFit, polynomialCurveSetFit, polyfit2
%   polynomialDerivate
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2008-10-13,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2008 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.
%
help('polynomialCurves2d');
