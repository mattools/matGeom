function kappa = curvature(varargin)
%CURVATURE Estimate curvature of a polyline defined by points
%
%   KAPPA = curvature(T, PX, PY, METHOD, DEGREE)
%   First compute an approximation of the curve given by PX and PY, with
%   the parametrization T. METHOD used for approximation can be only:
%   'polynom', with specified degree
%   Further methods will be provided in a future version.
%   T, PX, and PY are N*1 array of the same length.
%   Then compute the curvature of approximated curve for each point.
%
%   For example:
%   KAPPA = curvature(t, px, py, 'polynom', 6)
%
%   KAPPA = curvature(T, POINTS, METHOD, DEGREE)
%   specify curve as a suite of points. POINTS is size [N*2].
%
%   KAPPA = curvature(PX, PY, METHOD, DEGREE)
%   KAPPA = curvature(POINTS, METHOD, DEGREE)
%   compute implicite normalization of the curve, based on euclidian
%   distance between 2 consecutive points, and normalized between 0 and 1.
%
%
%   See Also:
%   polygons2d, parametrize
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 07/04/2003.
%


% default values
degree = 5;
t=0;                    % parametrization of curve
tc=0;                   % indices of points wished for curvature


% ================================================================= 

% Extract method and degree ------------------------------

nargin = length(varargin);
varN = varargin{nargin};
varN2 = varargin{nargin-1};

if ischar(varN2)
    % method and degree are specified
    method = varN2;
    degree = varN;
    varargin = varargin(1:nargin-2);
elseif ischar(varN)
    % only method is specified, use degree 6 as default
    method = varN;
    varargin = varargin{1:nargin-1};
else
    % method and degree are implicit : use 'polynom' and 6 
    method = 'polynom';
end

% extract input parametrization and curve. -----------------------
nargin = length(varargin);
if nargin==1
    % parameters are just the points -> compute caracterization.
    var = varargin{1};
    px = var(:,1);
    py = var(:,2);
elseif nargin==2
    var = varargin{2};
    if size(var, 2)==2
        % parameters are t and POINTS
        px = var(:,1);
        py = var(:,2);
        t = varargin{1};
    else
        % parameters are px and py
        px = varargin{1};
        py = var;
    end
elseif nargin==3
    var = varargin{2};
    if size(var, 2)==2
        % parameters are t, POINTS, and tc
        px = var(:,1);
        py = var(:,2);
        t = varargin{1};
    else
        % parameters are t, px and py
        t = varargin{1};
        px = var;
        py = varargin{3};
    end
elseif nargin==4
    % parameters are t, px, py and tc
    t  = varargin{1};
    px = varargin{2};
    py = varargin{3};
    tc = varargin{4};
end

% compute implicit parameters --------------------------

% if t and/or tc are not computed, use implicit definition
if t==0
    t = parametrize(px, py);
    t = t/t(length(t)); % normalize between 0 and 1
end

% if tc not defined, compute curvature for all points
if tc==0
    tc = t;
else
    % else convert from indices to parametrization values
    tc = t(tc);
end


% ================================================================= 
%    compute curvature for each point of the curve

if strcmp(method, 'polynom')
    % compute coefficients of interpolation functions
    x0 = polyfit(t, px, degree);
    y0 = polyfit(t, py, degree);

    % compute coefficients of first and second derivatives. In the case of a
    % polynom, it is possible to compute coefficient of derivative by
    % multiplying with a matrix.
    derive = diag(degree:-1:0);
    xp = circshift(x0*derive, [0 1]);
    yp = circshift(y0*derive, [0 1]);
    xs = circshift(xp*derive, [0 1]);
    ys = circshift(yp*derive, [0 1]);

    % compute values of first and second derivatives for needed points 
    xprime = polyval(xp, tc);
    yprime = polyval(yp, tc);
    xsec = polyval(xs, tc);
    ysec = polyval(ys, tc);

    % compute value of curvature
    kappa = (xprime.*ysec - xsec.*yprime)./ ...
        power(xprime.*xprime + yprime.*yprime, 3/2);
else
    error('unknown method');
end
