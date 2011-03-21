% POLYNOMIALCURVES2D Planar Polynomial Curves
% Version 1.0 21-Mar-2011 .
%
% POLYNOMIALCURVES2D Manipulation of planar smooth curves
%   Polynomial curves are plane curves whose points are defined by a
%   polynomial for each x and y coordinate.
%   A polynomial curve is represented by 3 row vectors:
%   * the bounds of the parametrization
%   * the coefficients for the x coordinate (in increasing degree)
%   * the coefficients for the y coordinate (in increasing degree)
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
%   For most functions, parameters are given as three separate arguments.
%   Sometimes, only the 2 parameters corresponding to the X and Y
%   coefficients are required. 
%
%
% Global features
%   polynomialCurveCentroid   - Compute the centroid of a polynomial curve
%   polynomialCurveProjection - Projection of a point on a polynomial curve
%   polynomialCurveLength     - Compute the length of a polynomial curve
%   polynomialCurvePoint      - Compute point corresponding to a position
%   polynomialCurvePosition   - Compute position on a curve for a given length
%
% Local features
%   polynomialCurveDerivative - Compute derivative vector of a polynomial curve
%   polynomialCurveNormal     - Compute the normal of a polynomial curve
%   polynomialCurveCurvature  - Compute the local curvature of a polynomial curve
%   polynomialCurveCurvatures - Compute curvatures of a polynomial revolution surface
%
% Fitting
%   polynomialCurveFit        - Fit a polynomial curve to a series of points
%   polynomialCurveSetFit     - Fit a set of polynomial curves to a segmented image
%
% Drawing
%   drawPolynomialCurve       - Draw a polynomial curve approximation
%
% Utilities
%   polynomialDerivate        - Derivate a polynomial
%   polyfit2                  - Polynomial approximation of a curve
%
%
% -----
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% created the  07/11/2005.
% homepage: http://matgeom.sourceforge.net/
% http://www.pfl-cepia.inra.fr/index.php?page=geom2d
% Copyright INRA - Cepia Software Platform.

help('Contents');


%%   Deprecated functions:


%% Others...

