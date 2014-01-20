function varargout = grClose(varargin)
%GRCLOSE Morphological closing on graph
%
%   LBL2 = grClose(EDGES, LBL1)
%   First performs dilatation, then erosion.
%
%   Example
%   grOpen
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2006-01-20
% Copyright 2006 INRA - CEPIA Nantes - MIAJ (Jouy-en-Josas).


if length(varargin) == 2
    edges   = varargin{1};
    lbl     = varargin{2};
elseif length(varargin) == 3
    edges   = varargin{2};
    lbl     = varargin{3};
else
    error('Wrong number of arguments in "grOpen"');
end

uni = unique(edges(:));

% performs dilation
lbl2 = zeros(size(lbl));
for n = 1:length(uni)
    neigh = grAdjacentNodes(edges, uni(n));
    lbl2(uni(n)) = max(lbl([uni(n); neigh]));    
end

% performs erosion
for n = 1:length(uni)
    neigh = grAdjacentNodes(edges, uni(n));
    lbl(uni(n)) = min(lbl2([uni(n); neigh]));    
end

varargout{1} = lbl;
