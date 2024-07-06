function varargout = clipPolygonByLine(poly, line, varargin)
%CLIPPOLYGONBYLINE Clip a polygon by a directed line.
%
%   POLY2 = clipPolygonByLine(POLY, LINE)
%   POLY is a [Nx2] array of points, and LINE is given as [x0 y0 dx dy].
%   The result POLY2:
%    - Represents the part of the polygon on the left side of the directed 
%      line, the left half-plane, if the line intersects the polygon.
%    - Is the same as POLY if the polygon is on the left side of the 
%      directed line and the line does not intersect the polygon.
%    - Is an empty polygon [0x2] if the polygon on the right side of the 
%      directed line and the line does not intersect the polygon.
%   
%   [POLY_L, POLY_R] = clipPolygonByLine(POLY, LINE, 'method', 'polyshape')
%   Uses MATLAB polyshape objects and functions to clip the polygon by the
%   line. Returns the right part POLY_R (right half-plane) in addition to 
%   the left part POLY_L (left half-plane) in the polygon cell format.
%
%   Example
%     line = [0.4 0 1 1];
%     r = [2.5, 2, 1];
%     poly = flipud(circleToPolygon([0 0 r(1)], round(2*pi*r(1))));
%     poly2 = clipPolygonByLine(poly, line);
%     figure('color','w','numbertitle','off','name','Method: legland')
%     axis equal tight; hold on; xlabel('x'); ylabel('y')
%     fillPolygon(poly2)
%     poly2_centroid = polygonCentroid(poly2);
%     drawLabels(poly2_centroid,'L ','HorizontalAlignment','Right')
%     scatter(poly2_centroid(1), poly2_centroid(2),[],'k','filled')
%     midCircle = circleToPolygon([0 0 r(2)], round(2*pi*r(2)));
%     innerCircle = flipud(circleToPolygon([0 0 r(3)], round(2*pi*r(3))));
%     poly = {poly, midCircle, innerCircle};
%     clipPolygonByLine(poly, line, 'method','polyshape','debug',1);
%
%   See also 
%   clipPolygon

% ------
% Author: David Legland, oqilipo
% E-mail: david.legland@inrae.fr
% Created: 2005-07-31
% Copyright 2005-2024 INRA - Cepia Software Platform

% Parsing
p = inputParser;
logParValidFunc=@(x) (islogical(x) || isequal(x,1) || isequal(x,0));
addParameter(p,'method','legland',@(x) any(validatestring(x,{'legland','polyshape'})));
addParameter(p,'debugVisu',false,logParValidFunc);
parse(p,varargin{:});

method = p.Results.method;
debugVisu = p.Results.debugVisu;

if iscell(poly) && numel(poly)==1
    poly = poly{1};
elseif iscell(poly) && length(poly) > 1
    method = 'polyshape';
end

if ~iscell(poly) && any(isnan(poly(:)))
    poly = splitPolygons(poly);
    method = 'polyshape';
end

switch method
    case 'legland'
        % avoid to process empty polygons
        if size(poly, 1)<3
            varargout{1} = zeros([0 2]);
            return;
        end

        % ensure the last point is the same as the first one
        if sum(poly(end, :)==poly(1,:))~=2
            poly = [poly; poly(1,:)];
        end

        N = size(poly, 1);
        edges = [poly([N 1:N-1], :) poly];

        b = isLeftOriented(poly, line);

        % case of totally clipped polygon
        if sum(b)==0
            varargout{1} = zeros(0, 2);
            return;
        end

        poly2 = zeros(0, 2);

        i=1;
        while i<=N
            if isLeftOriented(poly(i,:), line)
                % keep all points located on the right side of line
                poly2 = [poly2; poly(i,:)]; %#ok<AGROW>
            else
                % compute of preceeding edge with line
                if i>1
                    poly2 = [poly2; intersectLineEdge(line, edges(i, :))]; %#ok<AGROW>
                end
                % go to the next point on the left side
                i=i+1;
                while i<=N

                    % find the next point on the right side
                    if isLeftOriented(poly(i,:), line)
                        % add intersection of previous edge
                        poly2 = [poly2; intersectLineEdge(line, edges(i, :))]; %#ok<AGROW>

                        % add current point
                        poly2 = [poly2; poly(i,:)]; %#ok<AGROW>

                        % exit the second loop
                        break;
                    end
                    i=i+1;
                end
            end
            i=i+1;
        end

        % remove last point if it is the same as the first one
        if sum(poly2(end, :)==poly(1,:))==2
            poly2 = poly2(1:end-1, :);
        end

        if debugVisu
            figure('color','w','numbertitle','off', ...
                'name', ['Debug Figure: ' mfilename ...
                '.m, Method: ' method]);
            axis equal tight; hold on; xlabel('x'); ylabel('y')
            fillPolygon(poly2,'g')
            poly2_centroid = polygonCentroid(poly2);
            drawLabels(poly2_centroid,'L ','HorizontalAlignment','Right')
            scatter(poly2_centroid(1), poly2_centroid(2),[],'k','filled')
        end
        
        varargout{1} = poly2; 

    case 'polyshape'
        warning('off','MATLAB:polyshape:repairedBySimplify')
        polyShape = polygonToPolyshape(poly, 'debugVisu',0);
        warning('on','MATLAB:polyshape:repairedBySimplify')
        [bblim(1:2), bblim(3:4)] = boundingbox(polyShape);
        bbXdist = bblim(2)-bblim(1);
        bbYdist = bblim(4)-bblim(3);
        % Increase the bounding box a little bit
        bblim(1) = bblim(1)-0.01*bbXdist;
        bblim(2) = bblim(2)+0.01*bbXdist;
        bblim(3) = bblim(3)-0.01*bbYdist;
        bblim(4) = bblim(4)+0.01*bbYdist;
        % Bounding box
        BB = [bblim(1) bblim(3); bblim(2) bblim(3); ...
            bblim(2) bblim(4); bblim(1) bblim(4)];
        % Clip the bounding box by the line
        BB_L = clipPolygonByLine(BB, line);
        PS_R = subtract(polyShape, polyshape(BB_L));
        lineRev = [line(1:2) -line(3:4)];
        BB_R = clipPolygonByLine(BB, lineRev);
        PS_L = subtract(polyShape, polyshape(BB_R));
        lineSeg = clipLine(line, bblim);
        lineSeg = [lineSeg(1:2); lineSeg(3:4)];
        % Intersection edges
        itsEdges = intersect(polyShape,lineSeg);
        itsEdges(2:end+1, 3:4) = itsEdges;
        itsEdges(1,3:4) = nan;
        itsEdges(end,1:2) = nan; 
        itsEdges(any(isnan(itsEdges),2),:) = [];


        if debugVisu
            figure('color','w','numbertitle','off', ...
                'name', ['Debug Figure: ' mfilename ...
                '.m, Method: ' method]);
            axis equal tight; hold on; xlabel('x'); ylabel('y')
            plot(PS_R,'FaceColor','g','EdgeColor','k')
            plot(PS_L,'FaceColor','b','EdgeColor','k')
            [PS_R_centroid(1), PS_R_centroid(2)] = centroid(PS_R);
            drawLabels(PS_R_centroid,' R','HorizontalAlignment','Left')
            scatter(PS_R_centroid(1), PS_R_centroid(2),[],'g','filled')
            [PS_L_centroid(1), PS_L_centroid(2)] = centroid(PS_L);
            drawLabels(PS_L_centroid,'L ','HorizontalAlignment','Right')
            scatter(PS_L_centroid(1), PS_L_centroid(2),[],'b','filled')
            drawEdge(itsEdges,'LineStyle','-','LineWidth',2,'Color','k')
        end

        varargout{1} = splitPolygons(PS_L.Vertices);
        varargout{2} = splitPolygons(PS_R.Vertices);
        varargout{3} = itsEdges;

end
        
        
end
