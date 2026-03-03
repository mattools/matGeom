function varargout = transformPoint(varargin)
%TRANSFORMPOINT Apply an affine transform to a point or a point set.
%
%   PT2 = transformPoint(PT1, TRANSFO);
%   Returns the result of the transformation TRANSFO applied to the point
%   PT1. PT1 has the form [xp yp], and TRANSFO is either a 2-by-2, a
%   2-by-3, or a 3-by-3 matrix, 
%
%   Format of TRANSFO can be one of :
%   [a b]   ,   [a b c] , or [a b c]
%   [d e]       [d e f]      [d e f]
%                            [0 0 1]
%
%   PT2 = transformPoint(PT1, TRANSFO);
%   Also works when PTA is a N-by-2 array representing point coordinates.
%   In this case, the result PT2 has the same size as PT1.
%
%   [X2, Y2] = transformPoint(X1, Y1, TRANS);
%   Also works when PX1 and PY1 are two arrays the same size. The function
%   transforms each pair (PX1, PY1), and returns the result in (X2, Y2),
%   which has the same size as (PX1 PY1). 
%
%   PT2 = transformPoint(..., FUN);
%   Also works when FUN is a function handle accepting as input an N-by-2
%   array of coordinates, and returning as output the N-by-2 array of
%   transformed coordinates.
%
%   See also 
%     points2d, transforms2d, translation, rotation
%

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2004-04-06
% Copyright 2004-2024 INRA - TPV URPOI - BIA IMASTE

% parse input arguments
if length(varargin) == 2
    var = varargin{1};
    px = var(:,1);
    py = var(:,2);
    transfo = varargin{2};
elseif length(varargin) == 3
    px = varargin{1};
    py = varargin{2};
    transfo = varargin{3};
else
    error('wrong number of arguments in "transformPoint"');
end

if isnumeric(transfo)
    % case of an affine transform given as a transformation matrix.

    % first apply linear part of the transform
    px2 = px * transfo(1,1) + py * transfo(1,2);
    py2 = px * transfo(2,1) + py * transfo(2,2);

    % then add translation vector, if exist
    if size(transfo, 2) > 2
        px2 = px2 + transfo(1,3);
        py2 = py2 + transfo(2,3);
    end

elseif isa(transfo, "function_handle")
    % use transfo as a function handle
    res = transfo([px(:) py(:)]);
    px2 = reshape(res(:,1), size(px));
    py2 = reshape(res(:,2), size(py));

else
    error('can not manage transform given as %s', class(transfo));
end


% format output arguments
if nargout < 2
    varargout{1} = [px2 py2];
elseif nargout
    varargout{1} = px2;
    varargout{2} = py2;
end
