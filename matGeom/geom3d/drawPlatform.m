function  varargout = drawPlatform(plane, siz, varargin)
%DRAWPLATFORM Draw a rectangular platform with a given size.
%
%   drawPlatform(PLANE, SIZ) draws a rectangular platform with the
%   dimensions specified by SIZ. If SIZ contains only one value instead of 
%   two the platform will be quadratic.
%
%   drawPlatform(...,'PropertyName',PropertyValue,...) sets the value of 
%   the specified patch property. Multiple property values can be set with
%   a single statement. See function patch for details.
%
%   drawPlane3d(AX,...) plots into AX instead of GCA.
%
%   H = drawPlatform(...) returns a handle H to the patch object.
%
%   Example
%
%     p0 = [1 2 3];
%     v1 = [1 0 1];
%     v2 = [0 -1 1];
%     plane = [p0 v1 v2];
%     axis([-10 10 -10 10 -10 10]);
%     drawPlatform(plane, [7,3])
%     set(gcf, 'renderer', 'zbuffer');
%
%   See also
%   planes3d, createPlane, patch

% ------
% Author: oqilipo
% Created: 2018-08-09
% Copyright 2018

%% Parse inputs

% extract axis handle
if numel(plane) == 1 && ishandle(plane)
    hAx = plane;
    plane = siz;
    siz = varargin{1};
    varargin(1) = [];
else
    hAx = gca;
end

% parse optional arguments
p = inputParser;
addRequired(p, 'plane', @(x) size(x,1)==1 && isPlane(x))
addRequired(p, 'siz', @(x)validateattributes(x,{'numeric'},...
    {'size',[1, nan],'positive','nonnan','real','finite'}))
parse(p, plane, siz)

if ~isempty(varargin)
    if length(varargin) == 1
        if isstruct(varargin{1})
            % if options are specified as struct, need to convert to 
            % parameter name-value pairs
            varargin = [fieldnames(varargin{1}) struct2cell(varargin{1})]';
            varargin = varargin(:)';
        else
            % if option is a single argument, assume it corresponds to 
            % plane color
            varargin = {'FaceColor', varargin{1}};
        end
    end
else
    % default face color
    varargin = {'FaceColor', 'm'};
end

if numel(siz) == 1
    siz(2) = siz(1);
end


%% Algorithm
% Calculate vertex points of the platform 
pts(1,:) = planePoint(plane, [1,1]*0.5.*siz);
pts(2,:) = planePoint(plane, [1,-1]*0.5.*siz);
pts(3,:) = planePoint(plane, [-1,-1]*0.5.*siz);
pts(4,:) = planePoint(plane, [-1,1]*0.5.*siz);

pf.vertices = pts;
pf.faces = [1 2 3 4];

% Draw the patch
h = patch(hAx, pf, varargin{:});


%% Parse outputs
% Return handle to plane if needed
if nargout > 0
    varargout{1} = h;
end

end

