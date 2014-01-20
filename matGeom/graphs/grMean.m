function varargout = grMean(varargin)
%GRMEAN Compute mean from neihgbours
%
%   LBL2 = grMean(EDGES, LBL1)
%   new label for each node of the graph is computed as the mean of the
%   values of neighbours and of old value.
%
%   Example
%   grMean
%
%   See also
%   grMedian, grDilate, grErode
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2006-01-20
% Copyright 2006 INRA - CEPIA Nantes - MIAJ (Jouy-en-Josas).


if length(varargin) == 2
    edges   = varargin{1};
    lbl 	= varargin{2};
elseif length(varargin) == 3
    edges   = varargin{2};
    lbl     = varargin{3};
else
    error('Wrong number of arguments in "grMean"');
end
   

lbl2 = zeros(size(lbl));

uni = unique(edges(:));
for n = 1:length(uni)
    neigh = grAdjacentNodes(edges, uni(n));
    lbl2(uni(n)) = mean(lbl([uni(n); neigh]));    
end

varargout{1} = lbl2;