function dest = transformEdge(edge, trans)
%TRANSFORMEDGE Transform an edge with an affine transform
%
%   EDGE2 = transformEdge(EDGE1, TRANS);
%   where EDGE1 has the form [x1 y1 x2 y1], and TRANS is a transformation
%   matrix, return the edge transformed with affine transform TRANS. 
%
%   Format of TRANS can be one of :
%   [a b]   ,   [a b c] , or [a b c]
%   [d e]       [d e f]      [d e f]
%                            [0 0 1]
%
%   EDGE2 = transformEdge(EDGES, TRANS); 
%   Also wotk when EDGES is a [N*4] array of double. In this case, EDGE2
%   has the same size as EDGE. 
%
%   See also:
%   edges2d, transforms2d, transformPoint, translation, rotation
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 06/04/2004.
%

% allocate memory
dest = zeros(size(edge));

% compute position
dest(:,1) = edge(:,1)*trans(1,1) + edge(:,2)*trans(1,2);
dest(:,2) = edge(:,1)*trans(2,1) + edge(:,2)*trans(2,2);
dest(:,3) = edge(:,3)*trans(1,1) + edge(:,3)*trans(1,2);
dest(:,4) = edge(:,4)*trans(2,1) + edge(:,4)*trans(2,2);

% add translation vector, if exist
if size(trans, 2)>2
    dest(:,1) = dest(:,1)+trans(1,3);
    dest(:,2) = dest(:,2)+trans(2,3);
    dest(:,3) = dest(:,3)+trans(1,3);
    dest(:,4) = dest(:,4)+trans(2,3);
end