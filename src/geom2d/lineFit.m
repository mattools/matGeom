function line = lineFit(varargin)
%LINEFIT Fit a straight line to a set of points
%
%   L = lineFit(X, Y)
%   Computes parametric line minimizing square error of all points (X,Y).
%   Result is a 4*1 array, containing coordinates of a point of the line,
%   and the direction vector of the line, that is  L=[x0 y0 dx dy];
%
%   L = lineFit(PTS) 
%   Gives coordinats of points in a single array.
%
%   L = lineFit(PT0, PTS);
%   L = lineFit(PT0, X, Y);
%   with PT0 = [x0 y0], imposes the line to contain point PT0.
%
%   Requires:
%   Optimiaztion toolbox
%
%   See also:
%   lines2d, polyfit, polyfit2, lsqlin
%
%
%   -----
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 30/04/2004.
%

%   HISTORY
%   09/12/2004 : update implementation



% ---------------------------------------------
% extract input arguments

if length(varargin)==1
    % argument is an array of points
    var = varargin{1};
    x = var(:,1);
    y = var(:,2);   
elseif length(varargin)==2
    var = varargin{1};
    if size(var, 1)==1
        var = varargin{2};
        x = var(:,1);
        y = var(:,2);
    else
        % two arguments : x and y
        x = var;
        y = varargin{2};
    end
elseif length(varargin)==3
    % three arguments : ref point, x and y
    x = varargin{2};
    y = varargin{3};
end
    
% ---------------------------------------------
% Initializations :


N = size(x, 1);

% ---------------------------------------------
% Main algorithm :


% main matrix of the problem
X = [x y ones(N,1)];

% conditions initialisations
A = zeros(0, 3);
b = [];
Aeq1 = [1 1 0];
beq1 = 1;
Aeq2 = [1 -1 0];
beq2 = 1;

% disable verbosity of optimisation
opt = optimset('lsqlin');
opt.LargeScale = 'off';
opt.Display = 'off';

% compute line coefficients [a;b;c] , in the form a*x + b*y + c = 0
% using linear regression
% Not very clean : I could not impose a*a+b*b=1, so I checked for both a=1
% and b=1, and I kept the result with lowest residual error....
[coef1 res1] = lsqlin(X, zeros(N, 1), A, b, Aeq1, beq1, [], [], [], opt);
[coef2 res2] = lsqlin(X, zeros(N, 1), A, b, Aeq2, beq2, [], [], [], opt);

% choose the best line
if res1<res2
    coef = coef1;
else
    coef = coef2;
end

line = cartesianLine(coef');
