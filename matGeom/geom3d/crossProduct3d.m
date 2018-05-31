function c = crossProduct3d(a,b)
%CROSSPRODUCT3D Vector cross product faster than inbuilt MATLAB cross.
%
%   C = crossProduct3d(A, B) 
%   returns the cross product of the two 3D vectors A and B, that is: 
%       C = A x B
%   A and B must be N-by-3 element vectors. If either A or B is a 1-by-3
%   row vector, the result C will have the size of the other input and will
%   be the  concatenation of each row's cross product. 
%
%   Example
%     v1 = [2 0 0];
%     v2 = [0 3 0];
%     crossProduct3d(v1, v2)
%     ans =
%         0   0   6
%
%
%   Class support for inputs A,B:
%      float: double, single
%
%   See also DOT.

%   Sven Holcombe

% HISTORY
% 2017-11-24 rename from vectorCross3d to crossProduct3d

% size of inputs
sizeA = size(a);
sizeB = size(b);

% Initialise c to the size of a or b, whichever has more dimensions. If
% they have the same dimensions, initialise to the larger of the two
switch sign(numel(sizeA) - numel(sizeB))
    case 1
        c = zeros(sizeA);
    case -1
        c = zeros(sizeB);
    otherwise
        c = zeros(max(sizeA, sizeB));
end

c(:) = bsxfun(@times, a(:,[2 3 1],:), b(:,[3 1 2],:)) - ...
       bsxfun(@times, b(:,[2 3 1],:), a(:,[3 1 2],:));
