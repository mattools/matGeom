function rect = boxToRect(box)
%BOXTORECT Convert box data to rectangle data
%
%   RECT = boxToRect(BOX)
%   Converts from boxrepresentation to rectangle representation.
%   BOX is given by [XMIN XMAX YMIN YMAX].
%   RECT is given by [X0 Y0 WIDTH HEIGHT], with WIDTH and HEIGHT > 0
%
%   See also
%   boxes2d, boxToRect, drawBox
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-08-23,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

rect = [box(:,1) box(:,3) box(:,2)-box(:,1) box(:,4)-box(:,3)];
