function elli = fitEllipse(varargin)
%FITELLIPSE Fit an ellipse to a set of 2D points.
%
%   ELLI = fitEllipse(PTS)
%
%   Example
%     elli = [50 40  30 10 20];
%     pts = ellipseToPolygon(elli, 60) + randn(60,2);
%     figure; hold on; drawPoint(pts, 'ko');
%     axis equal; axis([0 100 0 100]);
%     ellFit = fitEllipse(pts);
%     drawEllipse(ellFit, 'b')
%     
%   This is a rewrite of an original function from the authors cited below.
%   Changes from original submission include:
%   * convert angle of result ellipse to degrees (to comply with MatGeom
%       convention)
%   * update comments
%
% Authors:
% Andrew Fitzgibbon, Maurizio Pilu, Bob Fisher
% Reference: "Direct Least Squares Fitting of Ellipses", IEEE T-PAMI, 1999
%
% https://fr.mathworks.com/matlabcentral/fileexchange/3215-fit_ellipse
%
%  @Article{Fitzgibbon99,
%   author = "Fitzgibbon, A.~W.and Pilu, M. and Fisher, R.~B.",
%   title = "Direct least-squares fitting of ellipses",
%   journal = pami,
%   year = 1999,
%   volume = 21,
%   number = 5,
%   month = may,
%   pages = "476--480"
%  }
%
%   See also 
%     geom2d, ellipses2d, createEllipse, equivalentEllipse, fitLine
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2022-07-16, using Matlab 9.12.0.1884302 (R2022a)
% Copyright 2022-2023 INRAE - BIA Research Unit - BIBS Platform (Nantes)

%% Process input arguments

if nargin==1
    var = varargin{1};
    X = var(:,1);
    Y = var(:,2);
else
    X = varargin{1};
    Y = varargin{2};
end

%% Normalize data

% recenter and reduce range
mx = mean(X);
my = mean(Y);
sx = (max(X) - min(X)) / 2;
sy = (max(Y) - min(Y)) / 2; 
x = (X-mx) / sx;
y = (Y-my) / sy;

% Force to column vectors
x = x(:);
y = y(:);


%% Main processing

% Build design matrix
D = [ x.*x  x.*y  y.*y  x  y  ones(size(x)) ];

% Build scatter matrix
S = D' * D;

% Build 6x6 constraint matrix
C(6,6) = 0; 
C(1,3) = -2; 
C(2,2) = 1; 
C(3,1) = -2;

% Solve eigensystem

% Break into blocks
tmpA = S(1:3,1:3);
tmpB = S(1:3,4:6);
tmpC = S(4:6,4:6);
tmpD = C(1:3,1:3);
tmpE = tmpC \ tmpB';

[evec_x, eval_x] = eig(tmpD \ (tmpA - tmpB*tmpE));

% Find the positive (as det(tmpD) < 0) eigenvalue
I = real(diag(eval_x)) < 1e-8 & ~isinf(diag(eval_x));

% Extract eigenvector corresponding to negative eigenvalue
A = real(evec_x(:,I));

% Recover the bottom half...
evec_y = -tmpE * A;
A = [A; evec_y];

% re-calibrate
par = [
    A(1)*sy*sy,   ...
    A(2)*sx*sy,   ...
    A(3)*sx*sx,   ...
    -2*A(1)*sy*sy*mx - A(2)*sx*sy*my + A(4)*sx*sy*sy,   ...
    -A(2)*sx*sy*mx - 2*A(3)*sx*sx*my + A(5)*sx*sx*sy,   ...
    A(1)*sy*sy*mx*mx + A(2)*sx*sy*mx*my + A(3)*sx*sx*my*my   ...
    - A(4)*sx*sy*sy*mx - A(5)*sx*sx*sy*my   ...
    + A(6)*sx*sx*sy*sy   ...
    ]';


%% Identify parameters

% rotation angle
theta = 0.5 * atan2(par(2), par(1) - par(3));

% pre-comptute trigonometrics
cost = cos(theta);
sint = sin(theta);
sin2 = sint .* sint;
cos2 = cost .* cost;
cos_sin = sint .* cost;

%
Ao =  par(6);
Au =  par(4) .* cost + par(5) .* sint;
Av = -par(4) .* sint + par(5) .* cost;
Auu = par(1) .* cos2 + par(3) .* sin2 + par(2) .* cos_sin;
Avv = par(1) .* sin2 + par(3) .* cos2 - par(2) .* cos_sin;

% ROTATED = [Ao Au Av Auu Avv]

tuCentre = - Au./(2.*Auu);
tvCentre = - Av./(2.*Avv);
wCentre = Ao - Auu.*tuCentre.*tuCentre - Avv.*tvCentre.*tvCentre;

uCentre = tuCentre .* cost - tvCentre .* sint;
vCentre = tuCentre .* sint + tvCentre .* cost;

Ru = -wCentre ./ Auu;
Rv = -wCentre ./ Avv;

Ru = sqrt(abs(Ru)) .* sign(Ru);
Rv = sqrt(abs(Rv)) .* sign(Rv);

% create row vector representing ellipse
elli = [uCentre, vCentre, Ru, Rv, rad2deg(theta)];
