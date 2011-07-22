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
%   See also
%   drawPolygon, drawRect, drawBox
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-05-09,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

% HISTORY
%   2011-07-22 simplifies code


%% Parses input arguments

if nargin > 4 && sum(cellfun(@isnumeric, varargin(1:4))) == 4
    cx  = box;
    cy  = varargin{1};
    hl   = varargin{2} / 2;
    hw   = varargin{3} / 2;
    theta   = varargin{4};
    varargin = varargin(5:end);
else
    cx  = box(:,1);
    cy  = box(:,2);
    hl   = box(:,3) / 2;
    hw   = box(:,4) / 2;
    theta = box(:,5);
end


%% Draw each box

% allocate memory for graphical handle
hr = zeros(length(cx), 1);

% iterate on oriented boxes
for i = 1:length(cx)
    % pre-compute angle data
    cot = cosd(theta(i));
    sit = sind(theta(i));
    
    % x and y shifts
    lc = hl(i) * cot;
    ls = hl(i) * sit;
    wc = hw(i) * cot;
    ws = hw(i) * sit;

    % coordinates of box vertices
    vx = cx(i) + [-lc + ws; lc + ws ; lc - ws ; -lc - ws ; -lc + ws];
    vy = cy(i) + [-ls - wc; ls - wc ; ls + wc ; -ls + wc ; -ls - wc];

    % draw polygons
    hr(i) = line(vx, vy, varargin{:});
end


%% Format output

if nargout > 0
    varargout = {hr};
end
