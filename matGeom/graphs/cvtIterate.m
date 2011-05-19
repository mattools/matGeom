function varargout = cvtIterate(germs, funcPtr, funcArgs, N)
%CVTITERATE Update germs of a CVT using random points with given density
%
%   G2 = cvtIterate(G, FPTR, FARGS, N)
%   G: inital germs 
%   FPTR: pointer to a function which accept a scalar M and return M random
%       points with a given distribution
%   FARGS: arguments to be given to the FPTR function (can be empty)
%   N: number of random points to generate
%
%   Example
%   P = randPointDiscUnif(50);
%   P2 = cvtIterate(P, @randPointDiscUnif, [], 1000);
%   P3 = cvtIterate(P2, @randPointDiscUnif, [], 1000);
%
%   See also
%
%
%   Rewritten from programs found in
%   http://people.scs.fsu.edu/~burkardt/m_src/cvt/cvt.html
%
%  Reference:
%    Qiang Du, Vance Faber, and Max Gunzburger,
%    Centroidal Voronoi Tessellations: Applications and Algorithms,
%    SIAM Review, Volume 41, 1999, pages 637-676.
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2007-10-10,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2007 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.


%% Init

% format input
if isempty(funcArgs)
    funcArgs = {};
end

% number of germs
Ng = size(germs, 1);

% initialize centroids with values of germs
centroids = germs;

% number of updates of each centroid
count = ones(Ng, 1);


%% random points

% generate N random points
pts = feval(funcPtr, N, funcArgs{:});

% for each point, determines which germ is the closest ones
[dist ind] = minDistancePoints(pts, germs); %#ok<ASGLU>

h = zeros(Ng, 1);
for i = 1:Ng
    h(i) = sum(ind==i);
end


%% Centroids update

% add coordinate of each point to closest centroid
energy = 0;
for j = 1:N
    centroids(ind(j), :) = centroids(ind(j), :) + pts(j, :);
    energy = energy + sum ( ( centroids(ind(j), :) - pts(j, :) ).^2);
    count(ind(j)) = count(ind(j)) + 1;
end

% estimate coordinate by dividing by number of counts
centroids = centroids ./ repmat(count, 1, size(germs, 2));

% normalizes energy by number of sample points
energy = energy / N;


%% format output

varargout{1} = centroids;
if nargout > 1
    varargout{2} = energy;
end
