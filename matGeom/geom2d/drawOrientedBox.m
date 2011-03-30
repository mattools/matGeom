function varargout = drawOrientedBox(box, varargin)
%DRAWORIENTEDBOX Draw centered oriented rectangle
%   
%   Syntax
%   drawOrientedBox(BOX)
%   drawOrientedBox(BOX, 'PropertyName', propertyvalue, ...)
%
%   Description
%   drawOrientedBox(OBOX)
%   Draws an oriented rectangle (or bounding box) on the current axis. 
%   OBOX is a 1-by-5 row vector containing box center, dimension (length
%   and width) and orientation (in degrees): 
%   OBOX = [CX CY LENGTH WIDTH THETA].
%
%   When OBOX is a N-by-5 array, the N boxes are drawn.
%
%   HB = drawOrientedBox(...) 
%   Returns a handle to the created graphic object(s). Object style can be
%   modified using syntaw like:
%   set(HB, 'color', 'g', 'linewidth', 2);
%
%   
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-05-09,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

%% Parses input arguments

if nargin > 4 && sum(cellfun(@isnumeric, varargin(1:4))) == 4
    cx  = box;
    cy  = varargin{1};
    w   = varargin{2};
    h   = varargin{3};
    theta   = varargin{4};
    varargin = varargin(5:end);
else
    cx  = box(:,1);
    cy  = box(:,2);
    w   = box(:,3);
    h   = box(:,4);
    theta = box(:,5);
end


%% Draw each box

% use only the half length of each rectangle
w = w/2;
h = h/2;

% allocate memory for graphical handle
hr = zeros(length(cx), 1);

% iterate on oriented boxes
for i=1:length(cx)
    % pre-compute angle data
    cot = cosd(theta(i));
    sit = sind(theta(i));
    
    % x and y shifts
    wc = w(i)*cot;
    ws = w(i)*sit;
    hc = h(i)*cot;
    hs = h(i)*sit;

    % coordinates of box vertices
    vx = cx(i) + [-wc + hs; wc + hs ; wc - hs ; -wc - hs ; -wc + hs];
    vy = cy(i) + [-ws - hc; ws - hc ; ws + hc ; -ws + hc ; -ws - hc];

    % draw polygons
    hr(i) = line(vx, vy, varargin{:});
end

if nargout > 0
    varargout = {hr};
end
