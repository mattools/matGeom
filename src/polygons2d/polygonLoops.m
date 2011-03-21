function loops = polygonLoops(poly)
%POLYGONLOOPS Divide a possibly self-intersecting polygon into a set of simple loops
%
%   LOOPS = polygonLoops(POLYGON);
%   POLYGON is a polygone defined by a series of vertices,
%   LOOPS is a cell array of polygons, containing the same vertices of the
%   original polygon, but no loop self-intersect, and no couple of loops
%   intersect each other.
%
%   Example:
%       poly = [0 0;0 10;20 10;20 20;10 20;10 0];
%       loops = polygonLoops(poly);
%       figure(1); hold on;
%       drawPolygon(loops);
%       polygonArea(loops)
%
%   See also
%   polygons2d, polygonSelfIntersections
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-06-15,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.


%% Initialisations

% compute intersections
[inters pos1 pos2] = polygonSelfIntersections(poly);

% case of a polygon without self-intersection
if isempty(inters)
    loops = {poly};
    return;
end

% array for storing loops
loops = cell(0, 1);

positions = sortrows([pos1 pos2;pos2 pos1]);


%% First loop

pos0 = 0;
loop = polygonSubcurve(poly, pos0, positions(1, 1));
pos = positions(1, 2);
positions(1, :) = [];

while true
    % index of next intersection point
    ind = find(positions(:,1)>pos, 1, 'first');
    
    % if not found, break
    if isempty(ind)
        break;
    end
    
    % add portion of curve
    loop = [loop;polygonSubcurve(poly, pos, positions(ind, 1))]; %#ok<AGROW>
    
    % look for next intersection point
    pos = positions(ind, 2);
    positions(ind, :) = [];
end

% add the last portion of curve
loop = [loop;polygonSubcurve(poly, pos, pos0)];

% remove redundant vertices
loop(sum(loop(1:end-1,:) == loop(2:end,:) ,2)==2, :) = [];
if sum(diff(loop([1 end], :))==0)==2
    loop(end, :) = [];
end

% add current loop to the list of loops
loops{1} = loop;


%% Other loops

Nl = 1;
while ~isempty(positions)

    loop    = [];
    pos0    = positions(1, 2);
    pos     = positions(1, 2);
    
    while true
        % index of next intersection point
        ind = find(positions(:,1)>pos, 1, 'first');

        % add portion of curve
        loop = [loop;polygonSubcurve(poly, pos, positions(ind, 1))]; %#ok<AGROW>

        % look for next intersection point
        pos = positions(ind, 2);
        positions(ind, :) = [];

        % if not found, break
        if pos==pos0
            break;
        end
    end

    % remove redundant vertices
    loop(sum(loop(1:end-1,:) == loop(2:end,:) ,2)==2, :) = []; %#ok<AGROW>
    if sum(diff(loop([1 end], :))==0)==2
        loop(end, :) = []; %#ok<AGROW>
    end

    % add current loop to the list of loops
    Nl = Nl + 1;
    loops{Nl} = loop;
end
