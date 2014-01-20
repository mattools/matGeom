function varargout = grOpen(varargin)
%GROPEN Morphological opening on graph
%
%   LBL2 = grOpen(EDGES, LBL1)
%   The labels are the result of a morphological erosion followed by a
%   morphological dilation.
%
%   Example
%   grOpen
%
%   See also
%   grClose, grErode, grDilate
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

% performs erosion
lbl2 = zeros(size(lbl));
for n = 1:length(uni)
    neigh = grAdjacentNodes(edges, uni(n));
    lbl2(uni(n)) = min(lbl([uni(n); neigh]));    
end

% performs dilation
for n = 1:length(uni)
    neigh = grAdjacentNodes(edges, uni(n));
    lbl(uni(n)) = max(lbl2([uni(n); neigh]));    
end

varargout{1} = lbl;