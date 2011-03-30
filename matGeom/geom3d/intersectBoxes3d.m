function box = intersectBoxes3d(box1, box2)
%INTERSECTBOXES3D Intersection of two 3D bounding boxes
%
%   RES = intersectBoxes3d(BOX1, BOX2)
%
%   Example
%   box1 = [5 20 5 30 10 50];
%   box2 = [0 15 0 15 0 20];
%   intersectBoxes3d(box1, box2)
%   ans = 
%       5 15 5 15 10 20
%
%   See also
%   boxes3d, drawBox3d, mergeBoxes3d
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
mini = min(box1(:,2:2:end), box2(:,2:2:end));
maxi = max(box1(:,1:2:end), box2(:,1:2:end));

% concatenate result into a new box structure
box = [maxi(:,1) mini(:,1) maxi(:,2) mini(:,2) maxi(:,3) mini(:,3)];

