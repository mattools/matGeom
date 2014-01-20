function varargout = grErode(varargin)
%GRERODE Morphological erosion on graph
%
%   LBL2 = grErode(EDGES, LBL1)
%   Each label of the graph is assigned the smallest label of its
%   neighbours, or it keeps the same label this one is smaller.
%
%   Example
%   grErode
%
%   See also
%   grDilate, grOpen, grClose
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
    error('Wrong number of arguments in "grErode"');
end
   
lbl2 = zeros(size(lbl));

uni = unique(edges(:));
for n = 1:length(uni)
    neigh = grAdjacentNodes(edges, uni(n));
    lbl2(uni(n)) = min(lbl([uni(n); neigh]));    
end

varargout{1} = lbl2;