function varargout = cvtUpdate(germs, points)
%CVTUPDATE Update germs of a CVT with given points
%
%   G2 = cvtUpdate(G, PTS)
%   G: inital germs 
%   PTS: the points
%
%   Example
%   G = randPointDiscUnif(50);
%   P = randPointDiscUnif(10000);
%   G2 = cvtUpdate(G, P);
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

% number of germs and of points
Ng  = size(germs, 1);
N   = size(points, 1);

% initialize centroids with values of germs
centroids = germs;

% number of updates of each centroid
count = ones(Ng, 1);


%% Generate random points

% for each point, determines which germ is the closest ones
[dist ind] = minDistancePoints(points, germs); %#ok<ASGLU>

h = zeros(Ng, 1);
for i = 1:Ng
    h(i) = sum(ind==i);
end


%% Centroids update

% add coordinate of each point to closest centroid
energy = 0;
for j = 1:N
    centroids(ind(j), :) = centroids(ind(j), :) + points(j, :);
    energy = energy + sum ( ( centroids(ind(j), :) - points(j, :) ).^2);
    count(ind(j)) = count(ind(j)) + 1;
end

% estimate coordinate by dividing by number of counts
centroids = centroids ./ repmat(count, 1, size(germs, 2));

% normalizes energy by number of sample points
energy = energy / N;


%% Format output

varargout{1} = centroids;
if nargout > 1
    varargout{2} = energy;
end

    
  