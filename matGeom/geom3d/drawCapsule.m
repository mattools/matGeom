function varargout = drawCapsule(varargin)
% Draw a capsule.
%
%   drawCapsule(CAP)
%   Draws the capsule CAP on the current axis. 
%   CAP is a 1-by-7 row vector in the form [x1 y1 z1 x2 y2 z2 r] where:
%   * [x1 y1 z1] are the coordinates of starting point, 
%   * [x2 y2 z2] are the coordinates of ending point, 
%   * R is the radius of the cylinder and the two semi-spheres at the ends
%
%   drawCapsule(CAP, N)
%   Uses N points for discretizating the circles of the cylinder and the
%   semi-spheres (domes). Default value is 32. 
%
%   drawCapsule(..., 'FaceColor', COLOR)
%   Specifies the color of the capsule. Any couple of parameters name and
%   value can be given as argument, and will be transfered to the 'surf'
%   matlab function
%
%   drawCapsule(..., 'FaceAlpha', ALPHA)
%   Specifies the transparency of the capsule and of the semi-spheres.
% 
%   drawCapsule(..., NAME, VALUE);
%   Specifies one or several options using parameter name-value pairs.
%   Available options are usual drawing options, as well as:
%   'nPhi'    the number of arcs used for drawing the meridians
%             (for the semi-spheres and the cylinder(
%   'nTheta'  the number of circles used for drawing the parallels
%             (only for the semi-spheres at the ends of the capsule)
%
%   drawCapsule(AX, ...)
%   Specifies the axis to draw on. AX should be a valid axis handle.
%
%   H = drawCapsule(...)
%   Returns a handle to the patch representing the capsule.
%
%
%   Examples:
%   % basic example
%     figure; drawCapsule([0 0 0 10 20 30 5]);
%
%   % change capsule color
%     figure; drawCapsule([0 0 0 10 20 30 5], 'FaceColor', 'r');
%
%   % change capsule color using graphical handle
%     figure;
%     h = drawCapsule([0 0 0 10 20 30 5]);
%     set(h, 'facecolor', 'b');
%
%   % Draw three mutually intersecting capsules
%     p0 = [10 10 10];
%     p1 = p0 + 80 * [1 0 0];
%     p2 = p0 + 80 * [0 1 0];
%     p3 = p0 + 80 * [0 0 1];
%     figure; axis equal; axis([0 100 0 100 0 100]); hold on
%     drawCapsule([p0 p1 10], 'FaceColor', 'r');
%     drawCapsule([p0 p2 10], 'FaceColor', 'g');
%     drawCapsule([p0 p3 10], 'FaceColor', 'b');
%     axis equal
%     set(gcf, 'renderer', 'opengl')
%     view([60 30]); light;
%
%   % draw cube skeleton
%     [v, e, f] = createCube;
%     figure; axis equal; axis([-0.2 1.2 -0.2 1.2 -0.2 1.2]); hold on; view(3);
%     caps = [v(e(:,1), :) v(e(:,2),:) repmat(0.1, size(e, 1), 1)];
%     drawCapsule(caps);
%     light
% 
%   % Draw a capsule with high resolution
%     figure;
%     h = drawCapsule([10,20,10,50,70,40,6], 'nPhi', 360, 'nTheta', 180);
%     l = light; view(3);
%     
%
%   See Also:
%     crawCylinder, drawDome, drawSphere
%

%   ---------
%   author: Moritz Schappler
%   created the 27/07/2013
%

%   HISTORY
%   2013-07-27 initial version as copy of drawCylinder
%   2020-05-18 changes based on current version of geom3d


%% Input argument processing

% parse axis handle
if isAxisHandle(varargin{1})
    hAx = varargin{1};
    varargin(1) = [];
else
    hAx = gca;
end

% input argument representing capsules
cap = varargin{1};
varargin(1) = [];

% process the case of multiple capsules
if iscell(cap)
    hCaps = gobjects(length(cap), 1);
    for i = 1:length(cap)
        hCaps(i) = drawCapsule(hAx, cap{i}, varargin{:});
    end
    if nargout > 0
        varargout{1} = hCaps;
    end    
    return;
elseif size(cap, 1) > 1
    hCaps = gobjects(size(cap, 1), 3);
    for i = 1:size(cap, 1)
        hCaps(i,:) = drawCapsule(hAx, cap(i, :), varargin{:});
    end
    
    if nargout > 0
        varargout{1} = hCaps;
    end    
    return;
end

faceColor = 'g';
ind = find(strcmpi(varargin, 'FaceColor'), 1, 'last');
if ~isempty(ind)
    faceColor = varargin{ind+1};
    varargin(ind:ind+1) = [];
end

% extract transparency
alpha = 1;
ind = find(strcmpi(varargin, 'FaceAlpha'), 1, 'last');
if ~isempty(ind)
    alpha = varargin{ind+1};
    varargin(ind:ind+1) = [];
end

% add default drawing options
varargin = [{'FaceColor', faceColor, 'edgeColor', 'none', 'FaceAlpha', alpha} varargin];

% adjust drawing options for the cylinder. Options nPhi and nTheta may only
% be given to the function drawDome, not drawCylinder
options_cyl = ['open', varargin];
ind = find(strcmpi(options_cyl, 'nPhi'), 1, 'last');
if ~isempty(ind)
    ind = ind(1);
    nPhi = options_cyl{ind+1};
    options_cyl(ind:ind+1) = [];
    options_cyl = [nPhi, options_cyl];
end
ind = find(strcmpi(options_cyl, 'nTheta'), 1, 'last');
if ~isempty(ind)
    options_cyl(ind:ind+1) = [];
end

hold on
if all(cap(1:3) == cap(4:6))
  % the capsule is only a sphere. take arbitrary axis to be able to plot
  cap(4:6) = cap(1:3)+eps*([0 0 1]);
  h1 = 0;
else
  h1 = drawCylinder(cap, options_cyl{:});
end
h2 = drawDome(cap([1:3,7]),  (cap(1:3)-cap(4:6)), varargin{:});
h3 = drawDome(cap([4:6,7]), -(cap(1:3)-cap(4:6)), varargin{:});

% return handles
if nargout == 1
    varargout{1} = [h1, h2, h3];
end
