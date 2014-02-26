function varargout = polynomialCurveSetFit(seg, varargin)
%POLYNOMIALCURVESETFIT Fit a set of polynomial curves to a segmented image
%
%   COEFS = polynomialCurveSetFit(IMG);
%   COEFS = polynomialCurveSetFit(IMG, DEG);
%   Result is a cell array of matrices. Each matrix is DEG+1-by-2, and
%   contains coefficients of polynomial curve for each coordinate.
%   IMG is first binarised, then skeletonized. Each cure
%
%   [COEFS LBL] = polynomialCurveSetFit(...);
%   also returns an image of labels for the segmented curves. The max label
%   is the number of curves, and the length of COEFS.
%
%   Requires the toolboxes:
%   - Optimization
%   - Image Processing
%
%   Example
%     % Fit a set of curves to a binary skeleton
%     img = imread('circles.png');
%     % compute skeleton, and ensure one-pixel thickness
%     skel = bwmorph(img, 'skel', 'Inf');
%     skel = bwmorph(skel, 'shrink');
%     figure; imshow(skel==0)
%     coeffs = polynomialCurveSetFit(skel, 2);
%     % Display segmented image with curves
%     figure; imshow(~img); hold on;
%     for i = 1:length(coeffs)
%         hc = drawPolynomialCurve([0 1], coeffs{i});
%         set(hc, 'linewidth', 2, 'color', 'g');
%     end
%
%   See also
%   polynomialCurves2d, polynomialCurveFit
%

% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2007-03-21
% Copyright 2007 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.


%% Initialisations

% default degree for curves
deg = 2;
if ~isempty(varargin)
    deg = varargin{1};
end

% ensure image is binary
seg = seg > 0;


%% Extract branching points and terminating points

% compute image of end points
imgEndPoints = imfilter(double(seg), ones([3 3])) .* seg == 2;

% compute centroids of end points
lblEndPoints    = bwlabel(imgEndPoints, 4);
regEndPoints    = bwconncomp(imgEndPoints, 4);
struct   = regionprops(regEndPoints, 'Centroid');

endPoints = cat(1, struct.Centroid);


% compute image of multiple points (intersections between curves)
imgBranching    = imfilter(double(seg), ones([3 3])) .* seg > 3;

% compute coordinate of nodes, as centroids of the multiple points
lblBranching = bwlabel(imgBranching, 4);
regBranching = bwconncomp(imgBranching, 4);
struct   = regionprops(regBranching, 'Centroid');

branchPoints = cat(1, struct.Centroid);


% list of nodes (all categories)
nodes = [branchPoints; endPoints];

% image of node labels
lblNodes = lblBranching;
lblNodes(lblEndPoints > 0) = lblEndPoints(lblEndPoints > 0) + size(branchPoints, 1);

% isolate branches
imgBranches = seg & ~imgBranching & ~imgEndPoints;
lblBranches = bwlabel(imgBranches, 8);

% number of curves
nBranches = max(lblBranches(:));

% allocate memory
coefs = cell(nBranches, 1);


% For each curve, find interpolated polynomial curve
for i = 1:nBranches
    %disp(i);
    
    % extract points corresponding to current curve
    imgBranch = lblBranches == i;
    points = chainPixels(imgBranch);
    
    % if number of points is not sufficient, simply create a line segment
    if size(points, 1) < max(deg+1-2, 2)
        % find labels of nodes
        inds = unique(lblNodes(imdilate(imgBranch, ones(3,3))));
        inds = inds(inds~=0);
        
        if length(inds)<2
            disp(['Could not find extremities of branch number ' num2str(i)]);
            coefs{i} = [0 0;0 0];
            continue;
        end
        
        % consider extremity nodes
        node0 = nodes(inds(1),:);
        node1 = nodes(inds(2),:);
        
        % use only a linear approximation
        xc = zeros(1, deg+1);
        yc = zeros(1, deg+1);
        xc(1) = node0(1);
        yc(1) = node0(2);
        xc(2) = node1(1)-node0(1);
        yc(2) = node1(2)-node0(2);
        
        % assigne au tableau de courbes
        coefs{i} = [xc;yc];
        
        % next branch
        continue;
    end

    % find nodes closest to first and last points of the current curve
    [dist, ind0] = minDistancePoints(points(1, :), nodes); %#ok<*ASGLU>
    [dist, ind1] = minDistancePoints(points(end, :), nodes);
    
    % add nodes to the curve.
    points = [nodes(ind0,:); points; nodes(ind1,:)]; %#ok<AGROW>
    
    % parametrization of the polyline
    t = parametrize(points);
    t = t/max(t);
    
    % fit a polynomial curve to the set of points
    [xc yc] = polynomialCurveFit(...
        t, points, deg, ...
        0, {points(1,1), points(1,2)},...
        1, {points(end,1), points(end,2)});
    
    % stores result
    coefs{i} = [xc ; yc];
end


%% Post-processing

% manage outputs
if nargout == 1
    varargout = {coefs};
elseif nargout == 2
    varargout = {coefs, lblBranches};
end



function points = chainPixels(img, varargin)
%CHAINPIXELS return the list of points which constitute a curve on image
%   output = chainPixels(input)
%
%   Example
%   chainPixels
%
%   See also
%

% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2007-03-21
% Copyright 2007 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.


conn = 8;
if ~isempty(varargin)
    conn = varargin{1};
end

% matrice de voisinage
if conn==4
    f = [0 1 0;1 1 1;0 1 0];
elseif conn==8
    f = ones([3 3]);
end

% find extremity points
nb = imfilter(double(img), f).*img;
imgEnding = nb==2 | nb==1;
[yi xi] = find(imgEnding);

% extract coordinates of points
[y x] = find(img);

% index of first point
if isempty(xi)
    % take arbitrary point
    ind = 1;
else
    ind = find(x==xi(1) & y==yi(1));
end

% allocate memory
points  = zeros(length(x), 2);

if conn==8
    for i=1:size(points, 1)
        % avoid multiple neighbors (can happen in loops)
        ind = ind(1);
        
        % add current point to chained curve
        points(i,:) = [x(ind) y(ind)];

        % remove processed coordinate
        x(ind) = [];    y(ind) = [];

        % find next candidate
        ind = find(abs(x-points(i,1))<=1 & abs(y-points(i,2))<=1);
    end
else
    for i=1:size(points, 1)
        % avoid multiple neighbors (can happen in loops)
        ind = ind(1);
        
        % add current point to chained curve
        points(i,:) = [x(ind) y(ind)];

        % remove processed coordinate
        x(ind) = [];    y(ind) = [];

        % find next candidate
        ind = find(abs(x-points(i,1)) + abs(y-points(i,2)) <=1 );
    end
end    
