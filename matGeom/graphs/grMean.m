function varargout = grMean(varargin)
% Compute mean value from neighbour nodes.
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

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2006-01-20
% Copyright 2006 INRA - CEPIA Nantes - MIAJ (Jouy-en-Josas).


if length(varargin) == 2
    edges   = varargin{1};
    values 	= varargin{2};
elseif length(varargin) == 3
    edges   = varargin{2};
    values  = varargin{3};
else
    error('Wrong number of arguments in "grMean"');
end
   

res = zeros(size(values));

uni = unique(edges(:));
for n = 1:length(uni)
    neigh = grAdjacentNodes(edges, uni(n));
    res(uni(n)) = mean(values([uni(n); neigh]));    
end

varargout{1} = res;