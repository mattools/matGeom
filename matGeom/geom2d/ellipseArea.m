function area = ellipseArea(elli)
%ELLIPSEAREA Area of an ellipse.
%
%   AREA = ellipseArea(ELLI)
%   Computes he area of the ellipse ELLI, by taking the product of the semi
%   axis length and multiplying by PI:
%      AREA = PI * RA * RB 
%
%   Example
%     % area of a simple ellipse
%     elli =  [50 50   40 20  30];
%     ellipseArea(elli)
%     ans =
%        2.5133e+03
%     % when scaling by K, area is scaled by K^2:
%     transfo = createScaling(.2);
%     elliT = transformEllipse(elli, transfo);
%     ellipseArea(elliT)
%     ans =
%       100.5310
%
%
%   See also 
%     ellipses2d, ellipsePerimeter, ellipseToPolygon
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2022-09-09, using Matlab 9.12.0.1884302 (R2022a)
% Copyright 2022-2024 INRAE - BIA Research Unit - BIBS Platform (Nantes)

area = elli(:,3) .* elli(:,4) * pi;
