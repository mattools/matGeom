function varargout = drawEllipse3d(varargin)
%DRAWELLIPSE3D Draw a 3D ellipse.
%
%   Possible calls for the function :
%   drawEllipse3d([XC YC ZC A B THETA PHI])
%   drawEllipse3d([XC YC ZC A B THETA PHI PSI])
%   drawEllipse3d([XC YC ZC A B], [THETA PHI])
%   drawEllipse3d([XC YC ZC A B], [THETA PHI PSI])
%   drawEllipse3d([XC YC ZC A B], THETA, PHI)
%   drawEllipse3d([XC YC ZC], A, B, THETA, PHI)
%   drawEllipse3d([XC YC ZC A B], THETA, PHI, PSI)
%   drawEllipse3d([XC YC ZC], A, B, THETA, PHI, PSI)
%   drawEllipse3d(XC, YC, ZC, A, B, THETA, PHI)
%   drawEllipse3d(XC, YC, ZC, A, B, THETA, PHI, PSI)
%
%   where XC, YC, ZY are coordinate of ellipse center, A and B are the
%   half-lengths of the major and minor axes of the ellipse,
%   PHI and THETA are 3D angle (in degrees) of the normal to the plane
%   containing the ellipse (PHI between 0 and 360 corresponding to
%   longitude, and THETA from 0 to 180, corresponding to angle with
%   vertical).
%   
%   H = drawEllipse3d(...)
%   return handle on the created LINE object
%   
%   Example
%     figure; axis([-10 10 -10 10 -10 10]); hold on;
%     ellXY = [0 0 0  8 5  0 0 0];
%     drawEllipse3d(ellXY, 'color', [.8 0 0], 'linewidth', 2)
%     ellXZ = [0 0 0  8 2  90 90 90];
%     drawEllipse3d(ellXZ, 'color', [0 .8 0], 'linewidth', 2)
%     ellYZ = [0 0 0  5 2  90 0 90];
%     drawEllipse3d(ellYZ, 'color', [0 0 .8], 'linewidth', 2)
% 

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2008-05-07
% Copyright 2008-2024 INRA - CEPIA Nantes - MIAJ (Jouy-en-Josas)

%   Possible calls for the function, with number of arguments :
%   drawEllipse3d([XC YC ZC A B THETA PHI])             1
%   drawEllipse3d([XC YC ZC A B THETA PHI PSI])         1
%   drawEllipse3d([XC YC ZC A B], [THETA PHI])          2
%   drawEllipse3d([XC YC ZC A B], [THETA PHI PSI])      2
%   drawEllipse3d([XC YC ZC A B], THETA, PHI)           3
%   drawEllipse3d([XC YC ZC A B], THETA, PHI, PSI)      4
%   drawEllipse3d([XC YC ZC], A, B, THETA, PHI)         5
%   drawEllipse3d([XC YC ZC], A, B, THETA, PHI, PSI)    6
%   drawEllipse3d(XC, YC, ZC, A, B, THETA, PHI)         7
%   drawEllipse3d(XC, YC, ZC, A, B, THETA, PHI, PSI)    8

% extract handle of axis to draw on
[hAx, varargin] = parseAxisHandle(varargin{:});

% extract drawing options
ind = find(cellfun(@ischar, varargin), 1, 'first');
options = {};
if ~isempty(ind)
    options = varargin(ind:end);
    varargin(ind:end) = [];
end

if length(varargin)==1
    % get center and radius
    elli3d = varargin{1};
    xc = elli3d(:,1);
    yc = elli3d(:,2);
    zc = elli3d(:,3);
    a  = elli3d(:,4);
    b  = elli3d(:,5);
    
    % get colatitude of normal
    if size(elli3d, 2)>=6
        theta = elli3d(:,6);
    else
        theta = zeros(size(elli3d, 1), 1);
    end

    % get azimut of normal
    if size(elli3d, 2)>=7
        phi     = elli3d(:,7);
    else
        phi = zeros(size(elli3d, 1), 1);
    end
    
    % get roll
    if size(elli3d, 2)==8
        psi = elli3d(:,8);
    else
        psi = zeros(size(elli3d, 1), 1);
    end
    
elseif length(varargin)==2
    % get center and radius
    elli3d = varargin{1};
    xc = elli3d(:,1);
    yc = elli3d(:,2);
    zc = elli3d(:,3);
    a  = elli3d(:,4);
    b  = elli3d(:,5);
    
    % get angle of normal
    angle = varargin{2};
    theta   = angle(:,1);
    phi     = angle(:,2);
    
    % get roll
    if size(angle, 2)==3
        psi = angle(:,3);
    else
        psi = zeros(size(angle, 1), 1);
    end

elseif length(varargin)==3    
    % get center and radius
    elli3d = varargin{1};
    xc = elli3d(:,1);
    yc = elli3d(:,2);
    zc = elli3d(:,3);
    a  = elli3d(:,4);
    b  = elli3d(:,5);
    
    % get angle of normal and roll
    theta   = varargin{2};
    phi     = varargin{3};
    psi     = zeros(size(phi, 1), 1);
    
elseif length(varargin)==4
    % get center and radius
    elli3d = varargin{1};
    xc = elli3d(:,1);
    yc = elli3d(:,2);
    zc = elli3d(:,3);
    
    if size(elli3d, 2)==5
        a  = elli3d(:,4);
        b  = elli3d(:,5);
    end
    
    theta   = varargin{2};
    phi     = varargin{3};
    psi     = varargin{4};
    
elseif length(varargin)==5
    % get center and radius
    elli3d = varargin{1};
    xc      = elli3d(:,1);
    yc      = elli3d(:,2);
    zc      = elli3d(:,3);
    a       = varargin{2};
    b       = varargin{3};
    theta   = varargin{4};
    phi     = varargin{5};
    psi     = zeros(size(phi, 1), 1);

elseif length(varargin)==6
    elli3d = varargin{1};
    xc      = elli3d(:,1);
    yc      = elli3d(:,2);
    zc      = elli3d(:,3);
    a       = varargin{2};
    b       = varargin{3};
    theta   = varargin{4};
    phi     = varargin{5};
    psi     = varargin{6};
  
elseif length(varargin)==7   
    xc      = varargin{1};
    yc      = varargin{2};
    zc      = varargin{3};
    a       = varargin{4};
    b       = varargin{5};
    theta   = varargin{6};
    phi     = varargin{7};
    psi     = zeros(size(phi, 1), 1);
    
elseif length(varargin)==8   
    xc      = varargin{1};
    yc      = varargin{2};
    zc      = varargin{3};
    a       = varargin{4};
    b       = varargin{5};
    theta   = varargin{6};
    phi     = varargin{7};
    psi     = varargin{8};

else
    error('drawEllipse3d: please specify center and radius');
end

% uses 60 intervals
t = linspace(0, 2*pi, 61)';

nElli = size(xc, 1);

% save hold state
holdState = ishold(hAx);
hold(hAx, 'on');

% iterate over ellipses to draw
for i = 1:nElli
    % polyline approximation of ellipse, centered and parallel to main axes
    xt = a(i) * cos(t);
    yt = b(i) * sin(t);
    zt = zeros(length(t), 1);
    elli2d = [xt yt zt];
    
    % compute transformation from local basis to world basis
    trans = localToGlobal3d(xc(i), yc(i), zc(i), theta(i), phi(i), psi(i));
    
    % transform points composing the ellipse
    elli3d = transformPoint3d(elli2d, trans);
    
    % draw the curve
    h = drawPolyline3d(hAx, elli3d, options{:});
end

% restore hold state
if ~holdState
    hold(hAx, 'off');
end

% format output arguments
if nargout > 0
    varargout = {h};
end

