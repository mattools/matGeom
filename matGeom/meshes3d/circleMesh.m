function varargout = circleMesh(circle, varargin)
%CIRCLEMESH Create a mesh defined by a 3D circle.
%
%   [V, F] = cylinderMesh(CYL)
%   Computes vertex coordinates V and face vertex indices F of a mesh
%   representing a 3D circle given as [xc yc zc R theta phi psi].
%
%   [V, F] = cylinderMesh(..., NAME, VALUE);
%   Specifies one or several options using parameter name-value pairs.
%   Available options are:
%       'nP' the number of points represeting the perimeter
%       'nR' the number of points along the radius excluding the center
%
%   Example
%     c = [10 20 30 50 70 60 50];
%     [v, f] = circleMesh(c, 'nP',100, 'nR',50);
%     figure('color','w');
%     drawMesh(v, f, 'facecolor', 'r');
%     drawCircle3d(c,'LineWidth',2, 'Color','g');
%     view(3); axis equal;
%
%   See also 
%   cylinderMesh, circles3d

% ------
% Author: oqilipo
% E-mail: N/A
% Created: 2023-07-30, using Matlab 9.13.0.2080170 (R2022b) Update 1
% Copyright 2023-2024

parser = inputParser;
addParameter(parser, 'nP', 60, @(x) validateattributes(x,{'numeric'},...
    {'integer','scalar','>=',3}));
addParameter(parser, 'nR', 10, @(x) validateattributes(x,{'numeric'},...
    {'integer','scalar','>=',1}));
parse(parser, varargin{:});
nP = parser.Results.nP;
nR = parser.Results.nR;
nR = nR+1;

% Radius
r = circle(4); 

% Check that the number of points of the inner circles stay valid
if (nP-(nR*2-4))<3
    nR = floor(((nP-3)+4)/2);
end

rr = linspace(0, r, nR);
rr = rr(2:end);
cp = fliplr(repmat(nP,1,nR-1)-(0:2:2*nR-4));

% Create points of the inner circles and the outer circle
center = [0 0];
vertices = nan(sum(cp)+1,2);
vertices(1,:) = center;
sIdx = 2;
eIdx = 1;
for i=1:length(rr)
    eIdx = eIdx+cp(i);
    vertices(sIdx:eIdx,:) = circleToPolygon([center rr(i)], cp(i));
    sIdx = eIdx+1;
end

% Triangulate points
DT = delaunayTriangulation(vertices);
faces = DT.ConnectivityList;
vertices(:,3) = 0;

% Transform points from 2D to 3D
tfm = localToGlobal3d([circle(1:3) circle(5:7)]);
vertices = transformPoint3d(vertices, tfm);

% Format output
varargout = formatMeshOutput(nargout, vertices, faces);

end
