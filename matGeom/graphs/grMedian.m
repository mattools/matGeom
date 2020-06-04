function varargout = grMedian(varargin)
% Compute median value from neighbour nodes.
%
%   VALS2 = grMedian(EDGES, VALS)
%   new value for each node of the graph is computed as the median of the
%   values of neighbours and of old value.
%
%   Example
%   grMedian
%
%   See also
%   grMean, grDilate, grErode
%

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2006-01-20
% Copyright 2006 INRA - CEPIA Nantes - MIAJ (Jouy-en-Josas).


if length(varargin) == 2
    edges   = varargin{1};
    values  = varargin{2};
elseif length(varargin) == 3
    edges   = varargin{2};
    values  = varargin{3};
else
    error('Wrong number of arguments in "grMedian"');
end
   

res = zeros(size(values));

uni = unique(edges(:));
for n = 1:length(uni)
    neigh = grAdjacentNodes(edges, uni(n));
    res(uni(n)) = median(values([uni(n); neigh]));    
end

varargout{1} = res;