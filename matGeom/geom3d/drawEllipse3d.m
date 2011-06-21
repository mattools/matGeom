function varargout = drawEllipse3d(varargin)
%DRAWELLIPSE3D Draw a 3D ellipse
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
%   containing the ellipse (PHI between 0 and 380 corresponding to
%   longitude, and THETA from 0 to 180, corresponding to angle with
%   vertical).
%   
%   H = drawEllipse3d(...)
%   return handle on the created LINE object
%   
%   ------
%   Author: David Legland
%   e-mail: david.legland@grignon.inra.fr
%   Created: 2008-05-07
%   Copyright 2008 INRA - CEPIA Nantes - MIAJ (Jouy-en-Josas).

%   HISTORY

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


% extract drawing options
ind = find(cellfun(@ischar, varargin), 1, 'first');
options = {};
if ~isempty(ind)
    options = varargin(ind:end);
    varargin(ind:end) = [];
end

if length(varargin)==1
    % get center and radius
    ellipse = varargin{1};
    xc = ellipse(:,1);
    yc = ellipse(:,2);
    zc = ellipse(:,3);
    a  = ellipse(:,4);
    b  = ellipse(:,5);
    
    % get colatitude of normal
    if size(ellipse, 2)>=6
        theta = ellipse(:,6);
    else
        theta = zeros(size(ellipse, 1), 1);
    end

    % get azimut of normal
    if size(ellipse, 2)>=7
        phi     = ellipse(:,7);
    else
        phi = zeros(size(ellipse, 1), 1);
    end
    
    % get roll
    if size(ellipse, 2)==8
        psi = ellipse(:,8);
    else
        psi = zeros(size(ellipse, 1), 1);
    end
    
elseif length(varargin)==2
    % get center and radius
    ellipse = varargin{1};
    xc = ellipse(:,1);
    yc = ellipse(:,2);
    zc = ellipse(:,3);
    a  = ellipse(:,4);
    b  = ellipse(:,5);
    
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
    ellipse = varargin{1};
    xc = ellipse(:,1);
    yc = ellipse(:,2);
    zc = ellipse(:,3);
    a  = ellipse(:,4);
    b  = ellipse(:,5);
    
    % get angle of normal and roll
    theta   = varargin{2};
    phi     = varargin{3};
    psi     = zeros(size(phi, 1), 1);
    
elseif length(varargin)==4
    % get center and radius
    ellipse = varargin{1};
    xc = ellipse(:,1);
    yc = ellipse(:,2);
    zc = ellipse(:,3);
    
    if size(ellipse, 2)==5
        a  = ellipse(:,4);
        b  = ellipse(:,5);
    end
    
    theta   = varargin{2};
    phi     = varargin{3};
    psi     = varargin{4};
    
elseif length(varargin)==5
    % get center and radius
    ellipse = varargin{1};
    xc      = ellipse(:,1);
    yc      = ellipse(:,2);
    zc      = ellipse(:,3);
    a       = varargin{2};
    b       = varargin{3};
    theta   = varargin{4};
    phi     = varargin{5};
    psi     = zeros(size(phi, 1), 1);

elseif length(varargin)==6
    ellipse = varargin{1};
    xc      = ellipse(:,1);
    yc      = ellipse(:,2);
    zc      = ellipse(:,3);
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

% polyline approximation of ellipse, centered and parallel to main axes
x       = a * cos(t);
y       = b * sin(t);
z       = zeros(length(t), 1);
base    = [x y z];

% compute transformation from local basis to world basis
trans   = localToGlobal3d(xc, yc, zc, theta, phi, psi);

% transform points composing the ellipse
ellipse = transformPoint3d(base, trans);

% draw the curve
h = drawPolyline3d(ellipse, options{:});

if nargout > 0
    varargout = {h};
end

