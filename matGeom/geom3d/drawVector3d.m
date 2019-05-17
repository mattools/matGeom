function varargout = drawVector3d(pos, vect, varargin)
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
%   vectors3d, quiver3
%

% ------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% Created: 2011-12-19,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

h = quiver3(pos(:, 1), pos(:, 2), pos(:, 3), ...
    vect(:, 1), vect(:, 2), vect(:, 3), 0, varargin{:});

% format output
if nargout > 0
    varargout{1} = h;
end
