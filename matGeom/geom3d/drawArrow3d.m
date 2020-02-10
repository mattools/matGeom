function varargout = drawArrow3d(pos, vec, varargin)
%DRAWARROW3D plot a quiver of 3D arrows.
%
%   drawArrow3d(pos, vec) 
%   Plots 3D arrows given the (pos)ition array [x1 y1 z1; x2 y2 z2; ...] 
%   and the (vec)tor array [dx1 dy1 dz1; dx2 dy2 dz2; ...].
%
%   drawArrow3d(pos, vec, color)
%   Optional positional argument color conforms to 'ColorSpec.'  
%   For example, 'r','red',[1 0 0] will all plot a quiver with all arrows 
%   as red. This can also be in the form of Nx3 where 'N' is the number of 
%   arrows and each column corresponds to the RGB values. Default color is 
%   black.
%
%   drawArrow3d(...,Name,Value) Optional name-value pair arguments:
%   'stemRatio': Ratio of the arrow head (cone) to the arrow stem (cylinder)
%       For example, setting this value to 0.94 will produce arrows with 
%       arrow stems 94% of the length and short, 6% cones as arrow heads.
%       Values above 0 and below 1 are valid. Default is 0.75.
%   'arrowRadius': changes the radius of the arrowstem. Percentage of the
%       lenght of the arrow. Values between 0.01 and 0.01 are valid. 
%       Default is 0.025.
%   Uses the 'patch' function to plot the arrows. 'patch' properties can be  
%   used to control the appearance of the arrows.
%
%   drawArrow3d(AX,...) plots into AX instead of GCA.
%
%   H = drawArrow3d(...) returns the handles of the arrows.
%
% Example:
%    [X,Y] = meshgrid(1:5, -2:2);
%    Z = zeros(size(X));
%    pos = [X(:),Y(:),Z(:)];
%    vec = zeros(size(pos));
%    vec(:,1) = 1;
%    drawArrow3d(pos, vec, 'g', 'stemRatio', 0.6);
%    view(3); lighting('phong'); camlight('head'); axis('equal')
%

% ------
% Authors: Shawn Arseneau, oqilipo
% History:
%   Created: 2006-09-14 by Shawn Arseneau
%   Updated: 2020-02-08 by oqilipo

% Check if first argument is an axes handle
if numel(pos) == 1 && ishghandle(pos, 'axes')
    hAx = pos;
    pos=vec;
    vec=varargin{1};
    varargin(1)=[];
else
    hAx = gca;
end

numArrows = size(pos,1);
if numArrows ~= size(vec,1)
    error(['Number of rows of position and magnitude inputs do not agree. ' ...
        'Type ''help drawArrow3d'' for details']);
end

% Parsing
p = inputParser;
p.KeepUnmatched = true;
isPointArray3d = @(x) validateattributes(x,{'numeric'},...
    {'nonempty','nonnan','real','finite','size',[nan,3]});
addRequired(p,'pos',isPointArray3d)
addRequired(p,'vec',isPointArray3d);
addOptional(p,'color', 'k', @(x) validateColor(x, numArrows));
isStemRatio = @(x) validateattributes(x,{'numeric'},{'vector','>', 0, '<', 1});
addParameter(p,'stemRatio', 0.75, isStemRatio);
isArrowRadius = @(x) validateattributes(x,{'numeric'},{'scalar','>=', 0.01, '<=', 0.1});
addParameter(p,'arrowRadius',0.025, isArrowRadius);

parse(p,pos,vec,varargin{:});
pos = p.Results.pos;
vec = p.Results.vec;
[~, color] = validateColor(p.Results.color, numArrows);
stemRatio = p.Results.stemRatio;
if numel(stemRatio) == 1; stemRatio = repmat(stemRatio,numArrows,1); end
arrowRadius = p.Results.arrowRadius;
if numel(arrowRadius) == 1; arrowRadius = repmat(arrowRadius,numArrows,1); end
drawOptions=p.Unmatched;

%% Loop through all arrows and plot in 3D
hold(hAx,'on')
qHandle=gobjects(numArrows,1);
for i=1:numArrows
    qHandle(i) = drawSingleVector3d(hAx, pos(i,:), vec(i,:), color(i,:), ...
        stemRatio(i),arrowRadius(i),drawOptions);
end

if nargout > 0
    varargout = {qHandle};
end

end

function [valid, color]=validateColor(color,numArrows)
valid=true;
[arrowRow, arrowCol] = size(color);
if arrowRow==1
    if ischar(color) %in ShortName or LongName color format
        color=repmat(color,numArrows,1);
    else
        if arrowCol~=3
            error('color in RGBvalue must be of the form 1x3.');
        end
        color=repmat(color,numArrows,1);
    end
elseif arrowRow~=numArrows
    error('color in RGBvalue must be of the form Nx3.');
end

end

function arrowHandle = drawSingleVector3d(hAx, pos, vec, color, stemRatio, arrowRadius, drawOptions)
%ARROW3D Plot a single 3D arrow with a cylindrical stem and cone arrowhead
%
% See header of drawArrow3d

X = pos(1); Y = pos(2); Z = pos(3);

[~, ~, srho] = cart2sph(vec(1), vec(2), vec(3));

%% CYLINDER == STEM
cylinderRadius = srho*arrowRadius;
cylinderLength = srho*stemRatio;
[CX,CY,CZ] = cylinder(cylinderRadius);
CZ = CZ.*cylinderLength; % lengthen

% Rotate Cylinder
[row, col] = size(CX); % initial rotation to coincide with x-axis

newEll = transformPoint3d([CX(:), CY(:), CZ(:)],createRotationVector3d([1 0 0],[0 0 -1]));
CX = reshape(newEll(:,1), row, col);
CY = reshape(newEll(:,2), row, col);
CZ = reshape(newEll(:,3), row, col);

[row, col] = size(CX);
newEll = transformPoint3d([CX(:), CY(:), CZ(:)],createRotationVector3d([1 0 0],vec));
stemX = reshape(newEll(:,1), row, col);
stemY = reshape(newEll(:,2), row, col);
stemZ = reshape(newEll(:,3), row, col);

% Translate cylinder
stemX = stemX + X;
stemY = stemY + Y;
stemZ = stemZ + Z;

%% CONE == ARROWHEAD
RADIUS_RATIO = 1.5;
coneLength = srho*(1-stemRatio);
coneRadius = cylinderRadius*RADIUS_RATIO;
incr = 4;  % Steps of cone increments
coneincr = coneRadius/incr;
[coneX, coneY, coneZ] = cylinder(cylinderRadius*2:-coneincr:0); % Cone
coneZ = coneZ.*coneLength;

% Rotate cone
[row, col] = size(coneX);
newEll = transformPoint3d([coneX(:), coneY(:), coneZ(:)],createRotationVector3d([1 0 0],[0 0 -1]));
coneX = reshape(newEll(:,1), row, col);
coneY = reshape(newEll(:,2), row, col);
coneZ = reshape(newEll(:,3), row, col);

newEll = transformPoint3d([coneX(:), coneY(:), coneZ(:)],createRotationVector3d([1 0 0],vec));
headX = reshape(newEll(:,1), row, col);
headY = reshape(newEll(:,2), row, col);
headZ = reshape(newEll(:,3), row, col);

% Translate cone
% centerline for cylinder: the multiplier is to set the cone 'on the rim' of the cylinder
V = [0, 0, srho*stemRatio];
Vp = transformPoint3d(V,createRotationVector3d([1 0 0],[0 0 -1]));
Vp = transformPoint3d(Vp,createRotationVector3d([1 0 0],vec));
headX = headX + Vp(1) + X;
headY = headY + Vp(2) + Y;
headZ = headZ + Vp(3) + Z;

% Draw cylinder & cone
hStem = patch(hAx, surf2patch(stemX, stemY, stemZ), 'FaceColor', color, 'EdgeColor', 'none', drawOptions);
hold(hAx,'on')
hHead = patch(hAx, surf2patch(headX, headY, headZ), 'FaceColor', color, 'EdgeColor', 'none', drawOptions);
arrowHandle = hggroup(hAx);
set([hStem, hHead],'Parent',arrowHandle);

end