function varargout = createSoccerBall()
%CREATESOCCERBALL Create a 3D mesh representing a soccer ball
%
%   It is basically a wrapper of the 'bucky' function in matlab.
%   [V E F] = createSoccerBall
%   return vertices, edges and faces that constitute a soccerball
%   V is a 60-by-3 array containing vertex coordinates
%   E is a 90-by-2 array containing indices of neighbor vertices
%   F is a 32-by-1 cell array containing vertex indices of each face
%   Example
%   [v f] = createSoccerBall;
%   drawMesh(v, f);
%
%   See also
%   meshes, drawMesh, bucky
%
%
% ------
% Author: David Legland
% e-mail: david.legland@jouy.inra.fr
% Created: 2006-08-09
% Copyright 2006 INRA - CEPIA Nantes - MIAJ (Jouy-en-Josas).

%   HISTORY
%   2007-01-04 remove unused variables, enhance output processing
%   2010-12-07 clean up edges, uses formatMeshOutput


% get vertices and adjacency matrix of the buckyball
[b, n] = bucky;

% compute edges
[i, j] = find(b);
e = [i j];
e = unique(sort(e, 2), 'rows');

% compute polygons that correspond to each 3D face
f = minConvexHull(n)';

% format output
varargout = formatMeshOutput(nargout, n, e, f);
