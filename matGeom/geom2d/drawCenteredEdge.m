function varargout = drawCenteredEdge(center, len, theta, varargin)
%DRAWCENTEREDEDGE Draw an edge centered on a point
%   
%   drawCenteredEdge(CENTER, L, THETA)
%   Draws an edge centered on point CENTER, with length L, and orientation
%   THETA (given in degrees). Input arguments can also be arrays, that must
%   all have the same number odf rows.
%
%   drawCenteredEdge(EDGE)
%   Concatenates edge parameters into a single N-by-4 array, containing:
%   [XC YV L THETA].
%
%   drawCenteredEdge(..., NAME, VALUE)
%   Also specifies drawing options by using one or several parameter name -
%   value pairs (see doc of plot function for details).
%
%   H = drawCenteredEdge(...)
%   Returns handle(s) to the created edges(s).
%
%   Example
%     % Draw an ellipse with its two axes
%     figure(1); clf;
%     center = [50 40];
%     r1 = 30; r2 = 10;
%     theta = 20;
%     elli = [center r1 r2 theta];
%     drawEllipse(elli, 'linewidth', 2);
%     axis([0 100 0 100]); axis equal;
%     hold on;
%     edges = [center 2*r1 theta ; center 2*r2 theta+90];
%     drawCenteredEdge(edges, 'linewidth', 2, 'color', 'g');
% 
%   See also:
%   edges2d, drawEdge
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 05/08/2005.
%

%   HISTORY
%   2007-06-15 update doc, clean up code
%   2011-05-18 use angle in degrees, cleanup code and doc


%% process input variables

if size(center, 2) == 4
    % manage edge in single parameter
    
    varargin = [{len, theta}, varargin];

    len     = center(:, 3);
    theta   = center(:, 4);
    center  = center(:, 1:2);

    N = size(center, 1);    

else
    % parameters given in different arguments
    
    % size of data
    NP = size(center, 1);
    NL = size(len, 1);
    ND = size(theta, 1);
    N  = max([NP NL ND]);

    % ensure all data have same size
    if N > 1
        if NP == 1, center = repmat(center, [N 1]); end
        if NL == 1, len = repmat(len, [N 1]); end
        if ND == 1, theta = repmat(theta, [N 1]); end
    end
    
end

% extract drawing options
options = varargin(:);


%% Draw edges

% coordinates of center point
xc = center(:, 1);
yc = center(:, 2);

% convert angle to radians
theta = theta * pi / 180;

% computation shortcuts
cot = cos(theta);
sit = sin(theta);

% compute starting and ending points
x1 = xc - len .* cot / 2;
x2 = xc + len .* cot / 2;
y1 = yc - len .* sit / 2;
y2 = yc + len .* sit / 2;


% draw the edges
h = zeros(N, 1);
for i = 1:N
    h(i) = plot([x1(i) x2(i)], [y1(i) y2(i)]);
end

% apply style to edges
if ~isempty(options) > 0
    for i = 1:N
        set(h(i), options{:});
    end
end


%% Format output

% process output arguments
if nargout > 0
    varargout = {h};
end
