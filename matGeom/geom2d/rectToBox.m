function box = rectToBox(rect)
%RECTTOBOX Convert rectangle data to box data
%
%   RECT = rectToBox(BOX)
%   Converts from rectangle representation to box representation.
%   BOX is given by [XMIN XMAX YMIN YMAX].
%   RECT is given by [X0 Y0 WIDTH HEIGHT], with WIDTH and HEIGHT > 0
%
%   Example
%   rectToBox
%
%   See also
%   boxToRect, drawBox, drawRect
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-08-23,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

box = [rect(:,1) rect(:,1)+rect(:,3) rect(:,2) rect(:,2)+rect(:,4)];
