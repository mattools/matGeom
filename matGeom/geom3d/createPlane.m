function plane = createPlane(varargin)
%CREATEPLANE Create a plane in parametrized form.
%
%   PLANE = createPlane(P1, P2, P3) 
%   creates a plane containing the 3 points
%
%   PLANE = createPlane(PTS) 
%   The 3 points are packed into a single 3-by-3 array.
%
%   PLANE = createPlane(P0, N);
%   Creates a plane from a point P0 and a normal N to the plane. The
%   parameter N is given either as a 3D vector (1-by-3 row vector), or as
%   [THETA PHI], where THETA is the colatitute (angle with the vertical
%   axis) and PHI is angle with Ox axis, counted counter-clockwise (both
%   given in radians).
% 
%   PLANE = createPlane(P0, Dip, DipDir);
%   Creates a plane from a point and from a dip and dip direction angles 
%   of the plane. Parameters Dip and DipDir angles are given as numbers.
%   Dip : maximum inclination to the horizontal.
%   DipDir : direction of the horizontal trace of the line of dip, 
%            measured clockwise from north.
%
%   The created plane data has the following format:
%   PLANE = [X0 Y0 Z0  DX1 DY1 DZ1  DX2 DY2 DZ2], with
%   - (X0, Y0, Z0) is a point belonging to the plane
%   - (DX1, DY1, DZ1) is a first direction vector
%   - (DX2, DY2, DZ2) is a second direction vector
%   The 2 direction vectors are normalized and orthogonal.
%
%   See also 
%   planes3d, medianPlane

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2005-02-18
% Copyright 2005-2023 INRA - TPV URPOI - BIA IMASTE

if length(varargin) == 1
    % If a single input is provided, it can be:
    % * an array of three points belonging to the plane
    % * a cell array -> one plane per array element is created

    var = varargin{1};
    if iscell(var)
        plane = zeros([length(var) 9]);
        for i = 1:length(var)
            plane(i,:) = createPlane(var{i});
        end

    elseif size(var, 1) >= 3
        % 3 points in a single array
        p1 = var(1,:);
        p2 = var(2,:);
        p3 = var(3,:);
        
        % create direction vectors
        v1 = p2 - p1;
        v2 = p3 - p1;

        % create plane
        plane = normalizePlane([p1 v1 v2]);

    else
        error ('MatGeom:createPlane', 'In case of single a.');
    end
    
elseif length(varargin) == 2
    % Two arguments -> correspond to plane origin and plane normal

    % plane origin
    p0 = varargin{1};
    
    % second parameter is either a 3D vector or a 3D angle (2 params)
    var = varargin{2};
    if size(var, 2) == 2
        % normal is given in spherical coordinates
        n = sph2cart2([var ones(size(var, 1))]);
    elseif size(var, 2) == 3
        % normal is given by a 3D vector
        n = normalizeVector3d(var);
    else
        error ('MatGeom:createPlane', 'Can not parse plane normal.');
    end
    
    % ensure same dimension for parameters
    if size(p0, 1) == 1
        p0 = repmat(p0, [size(n, 1) 1]);
    end
    if size(n, 1) == 1
        n = repmat(n, [size(p0, 1) 1]);
    end

    % find a vector not colinear to the normal, in the direction of [1 0 0]
    % first try with vector [0 0 1]
    v0 = repmat([0 0 1], [size(p0, 1) 1]);
    % if vectors are close to colinear, use vector [0 -1 0]
    inds = vectorNorm3d(cross(n, v0, 2)) < 1e-12;
    v0(inds, :) = repmat([0 -1 0], [sum(inds) 1]);
    
    % create direction vectors
    v1 = normalizeVector3d(cross(n, v0, 2));
    v2 = -normalizeVector3d(cross(v1, n, 2));

    % concatenate results in the array representing the plane
    plane = [p0 v1 v2];
    
elseif length(varargin) == 3
    % Three input arguments:
    % * three points (as 1-by-3 or 1-by-N numeric arrays)
    % * center, Dip and DipDir (?)

    var1 = varargin{1};
    var2 = varargin{2};
    var3 = varargin{3};
    if size(var1, 2) == 3 && size(var2, 2) == 3 && size(var3, 2) == 3
        % input arguments are three points
        p1 = var1;    
        p2 = var2;
        p3 = var3;

        % create direction vectors
        v1 = p2 - p1;
        v2 = p3 - p1;

        plane = normalizePlane([p1 v1 v2]);
        
    elseif size(var1, 2) == 3 && size(var2, 2) == 1 && size(var3, 2) == 1
        p0 = var1;
        n = [sin(var2)*sin(var3) sin(var2)*cos(var3) cos(var2)];
        
        % find a vector not colinear to the normal
        v0 = repmat([1 0 0], [size(p0, 1) 1]);
        inds = vectorNorm3d(cross(n, v0, 2))<1e-14;
        v0(inds, :) = repmat([0 1 0], [sum(inds) 1]);

        % create direction vectors
        v1 = normalizeVector3d(cross(n, v0, 2));
        v2 = -normalizeVector3d(cross(v1, n, 2));

        % concatenate result in the array representing the plane
        plane = [p0 v1 v2];  
        
    else
        error('MatGeom:createPlane', 'Wrong argument in "createPlane".');
    end  
else
    error ('MatGeom:createPlane', 'Wrong number of input parameters.');
end

