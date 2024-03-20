function progressbar(n,N,w)
%PROGRESSBAR Display a progress bar.
%
%   progressbar(n,N,w);
%   Displays the progress of n out of N. n should start at 1. w is the 
%   width of the bar (default w=20).
% 

% ------
% Author: Gabriel Peyré
% E-mail: gabriel.peyre@ens.fr
% Created: 2006
% Copyright 2006-2023

if nargin<3
    w = 20;
end

% progress char
cprog = '.';
cprog1 = '*';
% begining char
cbeg = '[';
% ending char
cend = ']';

p = min( floor(n/N*(w+1)), w);

global pprev;
if isempty(pprev)
    pprev = -1;
end

if not(p==pprev)
    ps = repmat(cprog, [1 w]);
    ps(1:p) = cprog1;
    ps = [cbeg ps cend];
    if n>1
        % clear previous string
        fprintf( repmat('\b', [1 length(ps)]) );
    end
    fprintf(ps);
end
pprev = p;
if n==N
    fprintf('\n');
end
