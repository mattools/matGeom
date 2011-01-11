function varargout = hexMesh(x, y, z)
%HEXMESH  One-line description here, please.
%
%   output = hexMesh(input)
%
%   Example
%   hexMesh
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-10-13,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

dim = size(x);

nr = dim(1);
nc = dim(2);

nh1 = floor((dim(1)-1)/2);
nh2 = floor((dim(2)-1)/10) + 1;
nh3 = floor((dim(2)-4)/10) + 1;

