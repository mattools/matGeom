function box = mergeBoxes(box1, box2)
%MERGEBOXES Merge two boxes, by computing their greatest extent
%
%   BOX = mergeBoxes(BOX1, BOX2);
%
%   Example
%   box1 = [5 20 5 30];
%   box2 = [0 15 0 15];
%   mergeBoxes(box1, box2)
%   ans = 
%       0 20 0 30
%
%
%   See also
%   boxes2d, drawBox, intersectBoxes
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-07-26,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

% unify sizes of data
if size(box1,1) == 1
    box1 = repmat(box1, size(box2,1), 1);
elseif size(box2, 1) == 1
    box2 = repmat(box2, size(box1,1), 1);
elseif size(box1,1) ~= size(box2,1)
    error('Bad size for inputs');
end

% compute extreme coords
mini = min(box1(:,[1 3]), box2(:,[1 3]));
maxi = max(box1(:,[2 4]), box2(:,[2 4]));

% concatenate result into a new box structure
box = [mini(:,1) maxi(:,1) mini(:,2) maxi(:,2)];
