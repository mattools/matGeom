function varargout = grMedian(varargin)
%GRMEDIAN Compute median from neihgbours
%
%   LBL2 = grMedian(EDGES, LBL1)
%   new label for each node of the graph is computed as the median of the
%   values of neighbours and of old value.
%
%   Example
%   grMedian
%
%   See also
%   grMean, grDilate, grErode
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
    error('Wrong number of arguments in "grMedian"');
end
   

lbl2 = zeros(size(lbl));

uni = unique(edges(:));
for n = 1:length(uni)
    neigh = grNeighborNodes(edges, uni(n));
    lbl2(uni(n)) = median(lbl([uni(n); neigh]));    
end

varargout{1} = lbl2;