function perim = ellipsePerimeter(ellipse, varargin)
%ELLIPSEPERIMETER Perimeter of an ellipse
%
%   P = ellipsePerimeter(ELLI)
%   Computes the perimeter of an ellipse, using numerical integration.
%   ELLI is an ellipse, given using one of the following formats:
%   * a 1-by-5 row vector containing coordinates of center, length of
%       semi-axes, and orientation in degrees
%   * a 1-by-2 row vector containing only the lengths of the semi-axes.
%   The result
%
%   P = ellipsePerimeter(ELLI, TOL)
%   Specify the relative tolerance for numerical integration.
%
%
%   Example
%   P = ellipsePerimeter([30 40 30 10 15])
%   P = 
%       133.6489 
%
%   See also
%     ellipses2d, drawEllipse
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-02-20,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

%% Parse input argument

if size(ellipse, 2) == 5
    ra = ellipse(:, 3);
    rb = ellipse(:, 4);
    
elseif size(ellipse, 2) == 2
    ra = ellipse(:, 1);
    rb = ellipse(:, 2);
    
elseif size(ellipse, 2) == 1
    ra = ellipse;
    rb = varargin{1};
    varargin(1) = [];
    
end

% relative tolerance 
tol = 1e-10;
if ~isempty(varargin)
    tol = varargin{1};
end


%% Numerical integration

n = length(ra);

perim = zeros(n, 1);

for i = 1:n
    % function to integrate
    f = @(t) sqrt(ra(i) .^ 2 .* cos(t) .^ 2 + rb(i) .^ 2 .* sin(t) .^ 2) ;

    % absolute tolerance from relative tolerance
    eps = tol * max(ra(i), rb(i));
    
    % integrate on first quadrant
    perim(i) = 4 * quad(f, 0, pi/2, eps);
end

