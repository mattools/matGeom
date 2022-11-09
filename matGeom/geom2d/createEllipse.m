function elli = createEllipse(type, varargin)
%CREATEELLIPSE Create an ellipse, from various input types.
%
%   ELLI = createEllipse('CartesianCoefficients', COEFFS)
%   ELLI = createEllipse(COEFFS)
%   Where COEFFS are the cartesian coefficients of the ellipse:
%     COEFFS = [A B C D E F] 
%   such that the points on the ellipse follow:
%     A*X^2 + B*X*Y + C*Y^2 + D*X + E*Y + F = 0
%   
%
%   Example
%     elli = [30 20 40 20 30];
%     coeffs = ellipseCartesianCoefficients(elli)
%     elli2 = createEllipse(coeffs)
%     elli2 =
%        30.0000   20.0000   40.0000   20.0000   30.0000
%
%
%   References
%   https://en.wikipedia.org/wiki/Ellipse#Standard_parametric_representation
%
%   See also
%     ellipses2d, equivalentEllipse, fitEllipse,
%     ellipseCartesianCoefficients
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2022-09-05,    using Matlab 9.12.0.1884302 (R2022a)
% Copyright 2022 INRAE.

if nargin == 1 && isnumeric(type)
    varargin = {type};
    type = 'CartesianCoefficients';
end

if strcmpi(type, 'CartesianCoefficients')
    % retrieve coefficients
    coeffs = varargin{1};
    if ~isnumeric(coeffs) || any(size(coeffs) ~= [1 6])
        error('Conversion from cartesian coefficients expects a 1-by-6 numeric array');
    end

    % call coefficients with their usual names
    A = coeffs(1); B = coeffs(2); C = coeffs(3);
    D = coeffs(4); E = coeffs(5); F = coeffs(6);

    % retrieve center
    delta = B * B - 4 * A * C;
    xc = (2 * C * D - B * E) / delta;
    yc = (2 * A * E - B * D) / delta;

    % find orientation
    theta = 0.5 * atan(B / (A - C));

    % retrieve length of semi-axes
    common = 2 * (A * E^2 + C * D^2 - B * D * E + delta * F);
    root = sqrt((A - C)^2 + B^2);
    a1 = -sqrt(common * ((A + C) + root)) / delta;
    a2 = -sqrt(common * ((A + C) - root)) / delta;

    elli = [xc yc a1 a2 rad2deg(theta)];

else
    error('Unknown representation type: ' + type);
end

