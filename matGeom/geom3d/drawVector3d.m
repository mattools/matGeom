function varargout = drawVector3d(varargin)
%DRAWVECTOR3D Draw vector at a given position.
%
%   drawVector3d(POS, VECT)
%   Draws the vector VECT starting at the position POS. Both VECT and POS
%   are N-by-3 arrays.
%
%   drawVector3d(..., PNAME, PVALUE)
%   Specifies additional optional parameters that will be given to the
%   quiver3 function.
%
%   Example
%     figure; hold on;
%     drawVector3d([2 3 4], [1 0 0]);
%     drawVector3d([2 3 4], [0 1 0]);
%     drawVector3d([2 3 4], [0 0 1]);
%     view(3);
%
%   See also 
%     vectors3d, quiver3
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2011-12-19, using Matlab 7.9.0.529 (R2009b)
% Copyright 2011-2024 INRA - Cepia Software Platform

% extract handle of axis to draw on
[hAx, varargin] = parseAxisHandle(varargin{:});

% retrieve geometric data
pos = varargin{1};
vect = varargin{2};
varargin(1:2) = [];

% draw the vectors using the quiver3 function
h = quiver3(hAx, pos(:, 1), pos(:, 2), pos(:, 3), ...
    vect(:, 1), vect(:, 2), vect(:, 3), 0, varargin{:});

% format output
if nargout > 0
    varargout{1} = h;
end
