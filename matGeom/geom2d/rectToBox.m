function box = rectToBox(rect)
%RECTTOBOX Convert rectangle data to box data.
%
%   BOX = rectToBox(RECT)
%   Converts from rectangle representation to box representation.
%   RECT is given by [X0 Y0 WIDTH HEIGHT], with WIDTH and HEIGHT > 0
%   BOX is given by [XMIN XMAX YMIN YMAX].
%
%   Example
%   rectToBox
%
%   See also 
%   boxToRect, drawBox, drawRect

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2012-08-23, using Matlab 7.9.0.529 (R2009b)
% Copyright 2012-2023 INRA - Cepia Software Platform

box = [rect(:,1) rect(:,1)+rect(:,3) rect(:,2) rect(:,2)+rect(:,4)];
