function coef = polyfit2(varargin)
%POLYFIT2 Polynomial approximation of a curve
%
%
%   usage :
%   P = POLYFIT2(X, Y, N) finds the coefficients of a polynomial P(X) of
%   degree N that fits the data, P(X(I))~=Y(I), in a least-squares sense.
%
%   P = POLYFIT2(Y, N) use default equal spacing between all values of Y
%   array.
%
%   P = POLYFIT2(..., COND) specify end conditions for interpolated
%   polynom. COND is [M*1] array of values, M(0) is value of interpolated
%   polynom for X(1), M(2) is value of first derivative at first point, and
%   so on for each derivative degree of X.
%   If COND is [M*2] array, first column gives conditions for first point,
%   and second column gives conditions for second point.
%   
%   P = POLYFIT2(..., COND1, COND2) 
%   where COND1 and COND2 are column arrays, specify different end
%   condition for each limit of the polynom domain.
%   
%   Example
%   % defines a basis and a function to interpolate
%   N = 50;                         % 50 points
%   x = linspace(0, pi, N);         % basis range from 0 to PI
%   y = cos(x)+randn(1,N)*.2;       % cosine plus gaussian noise
%   figure; plot(x, y, '+');        % display result
%   % Fit a degree 3 polynom, imposing to pass through end points [0 1] and
%   % [PI -1]:
%   p1 = polyfit2(x, y, 3, [1], [-1]);
%   % Fit a degree 3 polynom, imposing to pass through end points [0 1] and
%   % [PI -1], and imposing first derivative equals to zero at end points:
%   p2 = polyfit2(x, y, 3, [1;0], [-1;0]);
%   % display the different approximations
%   hold on;
%   plot(x, polyval(p1, x), 'g');
%   plot(x, polyval(p2, x), 'r');
%
%
%   See also  :
%   polyfit (matlab)
%

%   -----
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 30/04/2004.
%

%   HISTORY
%   05/01/2007 adapt to polynom bases others than [0...1]
%   08/01/2007 update doc accordingly
%   27/02/2007 code clean up

%% Default values

% boundary conditions
cond1 = [];
cond2 = [];


%% extract input arguments

if length(varargin)>2
    t = varargin{1};
    x = varargin{2};
    N = varargin{3};
    
    % extract end conditions
    if length(varargin)==4
        % one input for both end conditions
        var = varargin{4};
        if size(var, 2)==1
            % only first condition is specified
            cond1 = var;
            cond2 = [];
        else
            % two end conditions in a single array
            cond1 = var(:,1);
            cond2 = var(:,2);
        end       
    elseif length(varargin)==5
        % both end conditions are given is separates inputs
        cond1 = varargin{4};
        cond2 = varargin{5};
    end
elseif length(varargin)==2
    % extract curve values and interpolation order, and compute default
    % parametrization.
    x = varargin{1};
    t = 0:1/(length(x)-1):1;
    N = varargin{2};
else
    error ('POLYFIT2 : needs at least 2 input arguments');
end
    

%% Initializations

% transform to column vectors
x= x(:);
t = t(:);

% number of points
L = length(x);

% start and end values of parametrisation
t0 = t(1);
t1 = t(end);


%% Initialize matrices for end conditions

% For a solution vector 'x', the following relation must hold:
%   Aeq * x == beq,
% with:
%   Aeq   Matrix M*N 
%   beq   column vector with length M
% The coefficients of the Aeq matrix are initialized as follow:
% First point and last point are considered successively. For each point,
% k-th condition is the value of the (k-1)th derivative. This value is
% computed using relation of the form:
%   value = sum_i ( fact(i) * t_j^pow(i) )
% with:
%   i     indice of the (i-1) derivative. 
%   fact  row vector containing coefficient of each power of t, initialized
%       with a row vector equals to [1 1 ... 1], and updated for each
%       derivative by multiplying by corresponding power minus 1.
%   pow   row vector of the powers of each monome. It is represented by a
%       row vector containing an increasing series of power, eventually
%       completed with zeros for lower degrees (for the k-th derivative,
%       the coefficients with power lower than k are not relevant).

% Example for degree 5 polynom:
%   iter deriv  pow                 fact
%   1    0      [0 1 2 3 4 5]       [1 1 1 1 1 1]
%   2    1      [0 0 1 2 3 4]       [0 1 2 3 4 5]
%   3    2      [0 0 0 1 2 3]       [0 0 1 2 3 4]
%   4    3      [0 0 0 0 1 2]       [0 0 0 1 2 3]
%   ...

% Initialize empty matrices
Aeq = zeros(0, N+1);
beq = zeros(0, 1);

% start condition initialisations
fact = ones(1, N+1);
for i = 1:length(cond1)    
    pow = [zeros(1, i) 1:N+1-i];
    Aeq = [Aeq ; fact.*power(t0, pow)]; %#ok<AGROW>
    beq = [beq; cond1(i)]; %#ok<AGROW>
    fact = fact.*pow;
end

% end condition initialisations
fact = ones(1, N+1);
for i = 1:length(cond2)    
    pow = [zeros(1, i) 1:N+1-i];
    Aeq = [Aeq ; fact.*power(t1, pow)];%#ok<AGROW>
    beq = [beq; cond2(i)];%#ok<AGROW>
    fact = fact.*pow;
end

%% Main algorithm

% main matrix of the problem, size L*(deg+1)
X = ones(L, N+1);
for i = 1:N
    X(:, i+1) = power(t, i);
end

% compute interpolation
coef = lsqlin(X, x, zeros(1, N+1), 1, Aeq, beq);


%% format output

% format output to a format similar to polyfit
coef = coef(end:-1:1)';
