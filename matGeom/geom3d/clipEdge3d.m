function clipped = clipEdge3d(edge, box)
%CLIPEDGE3D Clip a 3D edge with a cuboid box.
%
%   CLIPPED = clipEdge3d(EDGE, BOX)
%
%   Example
%   clipEdge3d
%
%   See also
%     lines3d, edges3d, clipLine3d
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2018-04-12,    using Matlab 9.3.0.713579 (R2017b)
% Copyright 2018 INRA - Cepia Software Platform.

% compute supporting line of edge
line = [edge(:, 1:3) edge(:,4:6)-edge(:,1:3)];

% clip supporting line
clipped = clipLine3d(line, box);

% for each clipped line, check that extremities are contained in edge
nEdges = size(edge, 1);
for i = 1:nEdges
    % if supporting line does not intersect the box, the edge is totally
    % clipped.
    if isnan(clipped(i,1))
        continue;
    end
    
    % position of intersection points on the current supporting line
    pos1 = linePosition3d(clipped(i,1:3), line(i,:));
    pos2 = linePosition3d(clipped(i,4:6), line(i,:));
    
    if pos1 > 1 || pos2 < 0
        % case of an edge totally clipped
        clipped(i,:) = NaN;
    elseif pos1 > 0 && pos2 < 1
        % case of an edge already contained within the bounding box
        % -> nothin to do...
        continue;
    else
        % otherwise, need to adjust bounds of the clipped edge
        pos1 = max(pos1, 0);
        pos2 = min(pos2, 1);
        p1 = line(i,1:3) + pos1 * line(i,4:6);
        p2 = line(i,1:3) + pos2 * line(i,4:6);
        clipped(i,:) = [p1 p2];
    end
end
