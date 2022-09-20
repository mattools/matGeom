function varargout = drawVector(varargin)
% Draw vector at a given position.
%
%   drawVector(POS, VECT)
%   Draws the 2D or 3D vector VECT at the position POS.
%   POS should be a N-by-2 or N-by-3 array containing position of vector
%   origins, and VECT should be a N-by-2 or N-by-3 array containing the
%   direction of the vectors.
%
%   drawVector(POS, VECT, OPTS)
%   Specifies additional drawing options that will be provided to the
%   'quiver' or 'quiver3' function.
%
%   Example
%     figure; hold on;
%     drawVector([1 2], [3 2]);
%     drawVector([1 2], [-2 3]);
%     axis equal;
%
%   See also
%     quiver, drawVector3d
%

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2013-03-18,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2013 INRA - Cepia Software Platform.

% extract handle of axis to draw on
if isAxisHandle(varargin{1})
    ax = varargin{1};
    varargin(1) = [];
else
    ax = gca;
end

% retrieve position and direction of vector
pos = varargin{1};
vect = varargin{2};
varargin(1:2) = [];

% check input dimension
nd = size(pos, 2);
if size(vect, 2) ~= nd
    error('input vector and position must have same dimension');
end

if nd == 2
    % Display 2D vectors
    h = quiver(ax, pos(:, 1), pos(:, 2), vect(:, 1), vect(:, 2), 0, varargin{:});
    
elseif nd == 3
    % Display 3D vectors
    h = quiver3(ax, pos(:, 1), pos(:, 2), pos(:, 3), ...
        vect(:, 1), vect(:, 2), vect(:, 3), 0, varargin{:});
    
else
    error('Can not display vectors of dimension > 3');
end

% format output
if nargout > 0
    varargout{1} = h;
end
