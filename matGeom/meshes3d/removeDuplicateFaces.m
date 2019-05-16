function faces2 = removeDuplicateFaces(faces, varargin)
%REMOVEDUPLICATEFACES Remove duplicate faces in a face array.
%
%   [V, F] = removeDuplicateFaces(V, F)
%
%   Example
%     faces = [1 2 3;2 3 4;3 4 5;2 3 4];
%     removeDuplicateFaces(faces)
%     ans =
%         1 2 3
%         2 3 4
%         2 3 5
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2019-01-08,    using Matlab 8.6.0.267246 (R2015b)
% Copyright 2019 INRA - Cepia Software Platform.

nFaces = size(faces, 1);

removeFlag = false(nFaces, 1);
for iFace = 1:nFaces
    if removeFlag(iFace)
        continue;
    end
    
    face = faces(iFace, :);
    
    inds = find(sum(ismember(faces, face), 2) == 3);
    inds(inds <= iFace) = [];
    
    if ~isempty(inds)
        removeFlag(inds) = true;
    end
end

faces2 = faces(~removeFlag, :);
