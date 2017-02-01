function v = vech (x)
%VECH  Return the vector obtained by removing supradiagonal elements
%
%   V = vech(MAT)
%
%   Return the vector obtained by eliminating all supradiagonal elements of
% the square matrix @var{x} and stacking the result one column above the
% other.
% 
% See Magnus and Neudecker (1988), Matrix differential calculus with
% applications in statistics and econometrics.
%
%   Example
%   vech
%
%   See also
%

 
% ------
% Author KH <Kurt.Hornik@ci.tuwien.ac.at>
% Created: 8 May 1995
% Adapted-By: jwe
% Adapted to Matlab by David Legland
% e-mail: david.legland@inra.fr
% Created: 2017-02-01,    using Matlab 9.1.0.441655 (R2016b)
% Copyright 2017 INRA - Cepia Software Platform.

if nargin ~= 1
    disp('Usage: V = vech(M)');
end

if size(x, 1) ~= size(x, 2)
    error('vech: x must be square');
end

% This should be quicker than having an inner `for' loop as well.
% Ideally, vech should be written in C++.
n = size(x, 1);
v = zeros ((n+1)*n/2, 1);
count = 0;
for j = 1 : n
    i = j : n;
    v (count + i) = x (i, j);
    count = count + n - j;
end

end