function edges = crackPattern(box, points, alpha, varargin)
%CRACKPATTERN Create a (bounded) crack pattern tessellation
%
%   E = crackPattern(BOX, POINTS, ALPHA)
%   create a crack propagation pattern wit following parameters :
%   - pattern is bounded by area BOX given by [xmin xmax ymin ymax].
%   - each crack originates from points given in POINTS
%   - direction of each crack is given by array ALPHA
%   - a crack stop when it reaches another already created crack. 
%   - all cracks stop when they reach the border of the frame, given by box
%   (a serie of 4 points).
%   The result is a collection of edges, in the form [x1 y1 x2 y2].
%
%   E = crackPattern(BOX, POINTS, ALPHA, SPEED)
%   Also specify speed of propagation of each crack.
%
%
%   See the result with :
%     figure;
%     drawEdge(E);
%
%   See also drawEdge
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 25/05/2004.
%

%   HISTORY :

if ~isempty(varargin)
    speed = varargin{1};
else
    speed = ones(size(points, 1), 1);
end

% Compute line equations for each initial crack.
% The two 'Inf' at the end correspond to the position of the limit.
% If an intersection point is found with another line, but whose position
% is after this value, this means that another crack stopped it before it
% reach the intersection point.
% There is one 'end position' for each side of the crack.
lines = [points speed.*cos(alpha) speed.*sin(alpha) Inf*ones(size(points, 1), 2)];

% initialize lines for borders, but assign a very high speed, to be sure
% borders will stop all cracks.
dx = (box([2 3 4 1],1)-box([1 2 3 4],1))*max(speed)*5;
dy = (box([2 3 4 1],2)-box([1 2 3 4],2))*max(speed)*5;

% add borders to the lines set
lines = [lines ; createLine(box, dx, dy) Inf*ones(4,2)];

edges = zeros(0, 4);


while true    
    modif = 0;
    
    % try to update each line
	for i=1:size(points, 1)
        
        % compute intersections with all other lines
        pi = intersectLines(lines(i,:), lines);
        
        % compute position of all intersection points on the current line 
        pos = linePosition(pi, lines(i,:));
        
        % consider points to the right (positive position), and sort them
        indr = find(pos>=0 & pos~=Inf);
        [posr, indr2] = sort(pos(indr));
        
        
        % look for the closest intersection to the right
        for i2=1:length(indr2)
            
            % index of intersected line
            il = indr(indr2(i2));

            % position of point relative to intersected line
            pos2 = linePosition(pi(il, :), lines(il, :));
            
            % depending on the sign of position, tests if the line2 can
            % stop the current line, or if it was stopped before
            if pos2>0
                if pos2<abs(posr(i2)) && pos2<lines(il, 5)
                    if lines(i, 5) ~= posr(i2)
                        edges(i, 3:4) = pi(il,:);
                        lines(i, 5) = posr(i2); 
                        modif = 1;
                    end                                                           
                    break;
                end
            else
                 if abs(pos2)<abs(posr(i2)) && abs(pos2)<lines(il, 6)
                    if lines(i, 5) ~= posr(i2);
                        edges(i, 3:4) = pi(il,:);
                        lines(i, 5) = posr(i2);
                        modif = 1;
                    end                    
                    break;
                end
            end
                
        end   % end processing of right points of the line
            
        
        
         % consider points to the left (negative position), and sort them
        indl = find(pos<=0 && pos~=Inf);
        [posl, indl2] = sort(abs(pos(indl)));        

        % look for the closest intersection to the right
        for i2=1:length(indl2)
            % index of intersected line
            il = indl(indl2(i2));
            
            % position of point relative to intersected line
            pos2 = linePosition(pi(il, :), lines(il, :));
	
            % depending on the sign of position, tests if the line2 can
            % stop the current line, or if it was stopped before
            if pos2>0
                if pos2<abs(posl(i2)) && pos2<lines(il, 5)
                    if lines(i, 6) ~= abs(posl(i2));
                        edges(i, 1:2) = pi(il, :);
                        lines(i, 6) = abs(posl(i2));
                        modif = 1;
                    end                    
                    break;
                end
            else
                 if abs(pos2)<abs(posl(i2)) && abs(pos2)<lines(il, 6)
                    if lines(i, 6) ~= abs(posl(i2));
                        edges(i, 1:2) = pi(il, :);
                        lines(i, 6) = abs(posl(i2));
                        modif = 1;
                    end                    
                    break;
                end
            end    
            
        end % end processing of left points of the line
        
        
	end % end processing of all lines
    
    % break the infinite loop if no more modification was made
    if ~modif
        break;
    end
end

% add edges of the surronding box.
edges = [edges ; box(1,:) box(2,:) ; box(2,:) box(3,:); ...
                 box(3,:) box(4,:) ; box(4,:) box(1,:)  ];
 
