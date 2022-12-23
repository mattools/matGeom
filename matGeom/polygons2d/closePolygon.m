function closedPoly = closePolygon(poly)
%CLOSEPOLYGON Closes a polygon, if necessary.
%
%   CLOSEDPOLY = closePolygon(POLY)
%   Checks if the first and last vertex of POLY are the same. If not, 
%   CLOSEDPOLY has one vertices more than POLY by copying the first vertex
%   to the end of POLY.
%
%   Example
%       poly = [0 0; 1 0; 1 1; 0 1];
%       closePolygon([0 0; 1 0; 1 1; 0 1])
%
%   See also 
%   reversePolygon

% ------
% Author: oqilipo
% E-mail: N/A
% Created: 2022-12-23, using MATLAB 9.13.0.2080170 (R2022b) Update 1
% Copyright 2022

closedPoly = poly;
if ~isequal(poly(1,:), poly(end,:))
    closedPoly = [poly; poly(1,:)];
end