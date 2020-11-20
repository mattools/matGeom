function silhouette = meshSilhouette(v, f, varargin)
%MESHSILHOUETTE Compute the 2D outline of a 3D mesh on an arbitrary plane.
%
%   ATTENTION: Very slow brute force approach! Keep the number of faces as
%   low as possible.
%
%   SILHOUETTE = meshSilhouette(MESH, PLANE)
%   Calculates the silhouette (2D outline) of the MESH projected on the
%   PLANE.
%
%   SILHOUETTE = meshSilhouette(MESH) uses the x-y plane.
%
%   SILHOUETTE = meshSilhouette(V, F, ...)
%
%   SILHOUETTE = meshSilhouette(..., 'visu', 1) visualizes the results.
%   By default the results are not visualized.
%
%   Example:
%     v = [5, 2, 6, 0, 3;  0, 2, 4, 2, 1;  -5, -6, -6, -7, -9]';
%     f = [1, 2, 4; 1, 5, 4; 1, 2, 5; 2, 3, 5; 2, 4, 3; 3, 4, 5];
%     sil = meshSilhouette(v, f, rand(1,9),'visu',1);
%   
%   See also:
%     projPointOnPlane
%
%   Source:
%     Sean de Wolski - https://www.mathworks.com/matlabcentral/answers/68004

% ---------
% Authors: oqilipo
% Created: 2020-07-29
% Copyright 2020

narginchk(1,5)
nargoutchk(0,1)

%% Parse inputs
% If first argument is a struct
if isstruct(v)
    if nargin > 1
        varargin=[{f} varargin{:}];
    end
    mesh = v;
    [v, f] = parseMeshData(v);
else
    mesh.vertices = v;
    mesh.faces = f;
end

p = inputParser;
logParValidFunc = @(x) (islogical(x) || isequal(x,1) || isequal(x,0));
addOptional(p,'plane',[0 0 0 1 0 0 0 1 0],@isPlane)
addParameter(p,'visualization',false,logParValidFunc);
parse(p, varargin{:});
plane = p.Results.plane;

% Transform into the x-y plane
TFM = createBasisTransform3d('g', plane);
v = transformPoint3d(v,TFM);

% Initialize final polygon vectors
[px, py] = boundary(polyshape(v(f(1,:),1) ,v(f(1,:),2), 'Simplify',false));
for i = 2:size(f,1)
    A = polyshape(v(f(i,:),1), v(f(i,:),2), 'Simplify',false);
    B = polyshape(px, py, 'Simplify',false);
    [px, py] = boundary(union(A,B));
end

% Transform back into the plane
silhouette = transformPoint3d([px,py,zeros(size(px))], inv(TFM));

if p.Results.visualization
    figure('Color','w'); axH = axes(); axis(axH, 'equal', 'tight')
    drawPolyline3d(axH, silhouette,'Color','r','LineWidth',3)
    drawPlane3d(axH, plane,'FaceAlpha',0.5)
    drawMesh(mesh,'FaceAlpha',0.5,'FaceColor','none')
    axis(axH, 'equal')
    camTar = nanmean(silhouette);
    axH.CameraTarget = camTar;
    axH.CameraPosition = camTar + ...
        planeNormal(plane)*vectorNorm3d(axH.CameraPosition-axH.CameraTarget);
    axH.CameraUpVector = plane(4:6);
    xlabel(axH, 'x'); ylabel(axH, 'y'); zlabel(axH, 'z');
end

end