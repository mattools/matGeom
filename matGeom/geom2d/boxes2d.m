function boxes2d(varargin)
%BOXES2D Description of functions operating on bounding boxes.
%
%   A box is represented as a set of limits in each direction:
%   BOX = [XMIN XMAX YMIN YMAX].
%
%   Boxes are used as result of computation for bounding boxes, and to clip
%   shapes.
%
%   See also 
%   boundingBox, clipPoints, clipLine, clipEdge, clipRay
%   mergeBoxes, intersectBoxes, randomPointInBox, boxToRect, boxToPolygon
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2008-10-13, using Matlab 7.4.0.287 (R2007a)
% Copyright 2008-2023 INRA - Cepia Software Platform

help('boxes2d');
