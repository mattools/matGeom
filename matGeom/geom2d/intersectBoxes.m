function box = intersectBoxes(box1, box2)
%INTERSECTBOXES Intersection of two bounding boxes.
%
%   RES = intersectBoxes(BOX1, BOX2)
%   BOX1 = [XMIN1 XMAX1 YMIN1 YMAX1]
%   BOX2 = [XMIN2 XMAX2 YMIN2 YMAX2]
%   RES = intersectBoxes(BOX1,BOX2) = [XMIN3 XMAX3 YMIN3 YMAX3]

%   Example
%   box1 = [5 20 5 30];
%   box2 = [0 15 0 15];
%   res=intersectBoxes(box1, box2)
%   res = 
%       5 15 5 15
%
%   See also 
%   boxes2d, drawBox, mergeBoxes
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2010-07-26, using Matlab 7.9.0.529 (R2009b)
% Copyright 2010-2024 INRA - Cepia Software Platform

% unify sizes of data
if size(box1,1) == 1
    box1 = repmat(box1, size(box2,1), 1);
elseif size(box2, 1) == 1
    box2 = repmat(box2, size(box1,1), 1);
elseif size(box1,1) ~= size(box2,1)
    error('Bad size for inputs');
end

% compute extreme coords
mini = min(box1(:,[2 4]), box2(:,[2 4]));
maxi = max(box1(:,[1 3]), box2(:,[1 3]));

% concatenate result into a new box structure
box = [maxi(:,1) mini(:,1) maxi(:,2) mini(:,2)];
