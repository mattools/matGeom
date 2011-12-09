function [a b c] = parseThreePoints(varargin)
%PARSETHREEPOINTS Parse three points from variable length input array
%
%   [A B C] = parseThreePoints(PTS);
%   [A B C] = parseThreePoints(P1, P2, P3);
%   [A B C] = parseThreePoints(VERTICES, INDS);
%
%   Example
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-12-09,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

% extract input args
if nargin == 1
    % inputs are 3 points packed into a 3-by-2 array
    var = varargin{1};
    a = var(1,:);
    b = var(2,:);
    c = var(3,:);
    
elseif nargin == 3
    % inputs are 3 separate points
    a = varargin{1};
    b = varargin{2};
    c = varargin{3};
    
elseif nargin == 2
    % inputs are a vertex array, and index array
    pts = varargin{1};
    inds = varargin{2};
    a = pts(inds(1), :);
    b = pts(inds(2), :);
    c = pts(inds(3), :);
end
