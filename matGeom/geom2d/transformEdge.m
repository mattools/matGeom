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

% 14/08/2017 Updated by Juanpi Carbajal <ajuanpi+dev@gmail.com>


% allocate memory
dest = zeros(size(edge));

% compute position
for i=1:2
  T           = trans(i,1:2).';
  dest(:,i)   = edge(:,1:2) * T;
  dest(:,i+2) = edge(:,3:4) * T;
end

% add translation vector, if exist
if size(trans, 2) > 2
  dest = bsxfun (@plus, dest, trans([1:2 1:2],3).');
end

