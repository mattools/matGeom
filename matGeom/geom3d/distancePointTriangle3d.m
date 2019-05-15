function [dist, proj] = distancePointTriangle3d(point, triangle)
%DISTANCEPOINTTRIANGLE3D Minimum distance between a 3D point and a 3D triangle.
%
%   DIST = distancePointTriangle3d(PT, TRI);
%   Computes the minimum distance between the point PT and the triangle
%   TRI. The Point PT is given as a row vector of three coordinates. The
%   triangle TRI is given as a 3-by-3 array containing the coordinates of
%   each vertex in a row of the array:
%   TRI = [...
%      X1 Y1 Z1;...
%      X2 Y2 Z2;...
%      X3 Y3 Z3];
%
%   [DIST, PROJ] = distancePointTriangle3d(PT, TRI);
%   Also returns the coordinates of the projeced point.
%
%   Example
%      tri = [1 0 0; 0 1 0;0 0 1];
%      pt = [0 0 0];
%      dist = distancePointTriangle3d(pt, tri)
%      dist =
%           0.5774
%
%   See also
%   meshes3d, distancePointMesh, distancePointEdge3d, distancePointPlane
%
%   Reference
%   * David Eberly (1999), "Distance Between Point and Triangle in 3D"
%   https://www.geometrictools.com/Documentation/DistancePoint3Triangle3.pdf
%   * see <a href="matlab:
%     web('https://fr.mathworks.com/matlabcentral/fileexchange/22857-distance-between-a-point-and-a-triangle-in-3d')
%   ">Distance between a point and a triangle in 3d</a>, by Gwendolyn Fischer.
%   (same algorithm, but different order of input argument)
%
%   * https://fr.mathworks.com/matlabcentral/fileexchange/22857-distance-between-a-point-and-a-triangle-in-3d
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2018-03-08,    using Matlab 9.3.0.713579 (R2017b)
% Copyright 2018 INRA - Cepia Software Platform.

% triangle origin and vectors
p1 = triangle(1,:);
v12 = triangle(2,:) - p1;
v13 = triangle(3,:) - p1;

% identify coefficients of second order equation
a = dot(v12, v12, 2);
b = dot(v12, v13, 2);
c = dot(v13, v13, 2);
diffP = p1 - point;
d = dot(v12, diffP, 2);
e = dot(v13, diffP, 2);
% f = dot(diffP, diffP, 2);

% compute position of projected point in the plane of the triangle
det = a * c - b * b ;
s = b * e - c * d ;
t = b * d - a * e ;

% switch depending on the region where the projection occur
if s + t < det
    if s < 0
        if t < 0
            % region 4
            % The minimum distance must occur 
            % * on the line t = 0
            % * on the line s = 0 with t >= 0
            % * at the intersection of the two lines
            
            if d < 0
                % minimum on edge t = 0 with s > 0.
                t = 0;
                if a <= -d
                    s = 1;
                else
                    s = -d / a;
                end
            else
                % minimum on edge s = 0
                s = 0;
                if e >= 0
                    t = 0;
                elseif c <= -e
                    t = 1;
                else
                    t = -e / c;
                end
            end
        else
            % region 3
            % The minimum distance must occur on the line s = 0
            s = 0;
            if e >= 0
                t = 0;
            else
                if c <= -e
                    t = 1;
                else
                    t = -e / c;
                end
            end
        end
        
    else
        if t < 0
            % region 5
            % The minimum distance must occur on the line t = 0
            t = 0;
            if d >= 0
                s = 0;
            else
                if a <= -d
                    s = 1;
                else
                    s = -d / a;
                end
            end
        else
            % region 0
            % the minimum distance occurs inside the triangle
            s = s / det;
            t = t / det;
        end
    end
else
    if s < 0
        % region 2
        % The minimum distance must occur:
        % * on the line s + t = 1
        % * on the line s = 0 with t <= 1
        % * or at the intersection of the two (s=0; t=1)
        
        tmp0 = b + d;
        tmp1 = c + e;
        
        if tmp1 > tmp0
            % minimum on edge s+t = 1, with s > 1
            numer = tmp1 - tmp0;
            denom = a - 2 * b + c;
            if numer >= denom
                s = 1;
            else
                s = numer / denom;
            end
            t = 1 - s;
        else
            % minimum on edge s = 0, with t <= 1
            s = 0;
            if tmp1 <= 0
                t = 1;
            elseif e >= 0
                t = 0;
            else
                t = -e / c;
            end
        end
        
    elseif t < 0
        % region 6
        % The minimum distance must occur
        % * on the line s + t = 1
        % * on the line t = 0, with s <= 1
        % * at the intersection of the two lines
        tmp0 = b + e;
        tmp1 = a + d;
        
        if tmp1 > tmp0 
            % minimum on edge s+t=1, with t > 0
            numer = tmp1 - tmp0;
            denom = a - 2 * b + c;
            if numer > denom
                t = 1;
            else
                t = numer / denom;
            end
            s = 1 - t;
            
        else
            % minimum on edge t = 0 with s <= 1
            t = 0;
            if tmp1 <= 0
                s = 1;
            elseif d >= 0
                s = 0;
            else
                s = -d / a;
            end
        end
        
    else
        % region 1
        % The minimum distance must occur on the line s + t = 1
        numer = (c + e) - (b + d);
        if numer <= 0
            s = 0;
        else
            denom = a - 2 * b + c;
            if numer >= denom
                s = 1;
            else
                s = numer / denom;
            end
        end
        
        t = 1 - s;
    end
end

% compute coordinates of closest point on plane
proj = p1 + s * v12 + t * v13;

% distance between point and closest point on plane
dist = sqrt(sum((point - proj).^2));
