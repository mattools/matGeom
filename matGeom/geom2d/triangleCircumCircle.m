function varargout = triangleCircumCircle(varargin)
%TRIANGLECIRCUMCIRCLE Circumscribed circle of a triangle
%
%   CIRC = triangleCircumCircle(TRI)
%   CIRC = triangleCircumCircle(P1, P2, P3)
%   Compute circumcircle of a triangle given by 3 points.
%
%   Example
%     T = [10 20; 70 20; 30 70];
%     C = triangleCircumCircle(T);
%     figure; drawPolygon(T, 'linewidth', 2);
%     hold on; drawCircle(C);
%     axis equal; axis([0 100 0 100]);
%
%   See also
%     enclosingCircle
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-12-01,    using Matlab 7.9.0.529 (R2009b)
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

% pre-compute some terms
ah = sum(a .^2);
bh = sum(b .^2);
ch = sum(c .^2);

dab = a - b;
dbc = b - c;
dca = c - a;

% common denominator
D  = .5 / (a(1) * dbc(2) + b(1) * dca(2) + c(1) * dab(2));

% center coordinates
xc =  (ah * dbc(2) + bh * dca(2) + ch * dab(2) ) * D;
yc = -(ah * dbc(1) + bh * dca(1) + ch * dab(1) ) * D;

% radius
r = hypot(xc - a(1), yc - a(2));

% format output
if nargout <= 1
    varargout = {[xc yc r]};
else
    varargout = {[xc yc], r};
end
