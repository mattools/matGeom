function varargout = grDilate(varargin)
%GRDILATE Morphological dilation on graph
%
%   LBL2 = grDilate(EDGES, LBL1)
%   Each label of the graph is assigned the highest label of its
%   neighbours, or it keeps the same label this one is bigger.
%
%   Example
%   grDilate
%
%   See also
%   grErode, grOpen, grClose
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
    error('Wrong number of arguments in "grDilate"');
end
   

lbl2 = zeros(size(lbl));

uni = unique(edges(:));
for n = 1:length(uni)
    neigh = grNeighborNodes(edges, uni(n));
    lbl2(uni(n)) = max(lbl([uni(n); neigh]));    
end

varargout{1} = lbl2;
