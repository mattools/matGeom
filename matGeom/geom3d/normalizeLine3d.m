function line2 = normalizeLine3d(line)
%NORMALIZELINE3D Normalizes the direction vector of a 3D line.
%
%   LINE2 = normalizeVector3d(LINE);
%   Returns the normalization of the direction vector of the line, such 
%   that ||LINE2(4:6)|| = 1. 
%
%   See also:
%     normalizePlane, normalizeVector3d
%

% ------
% Author: oqilipo
% Created: 2020-03-13
% Copyright 2020

isLine3d = @(x) validateattributes(x,{'numeric'},...
    {'nonempty','nonnan','real','finite','size',[nan,6]});

% Check if the line is valid
p=inputParser;
addRequired(p,'line',isLine3d)
parse(p,line)

line2 = line;
line2(:,4:6) = normalizeVector3d(line2(:,4:6));

end

