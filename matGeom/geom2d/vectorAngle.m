function alpha = vectorAngle(v1, varargin)
%VECTORANGLE Horizontal angle of a vector, or angle between 2 vectors.
%
%   A = vectorAngle(V);
%   Returns angle between Ox axis and vector direction, in radians, in
%   counter-clockwise orientation.
%   The result is normalised between 0 and 2*PI.
%
%   A = vectorAngle(V1, V2);
%   Returns the angle from vector V1 to vector V2, in counter-clockwise
%   order, in radians.
%
%   A = vectorAngle(..., 'midAngle', MIDANGLE);
%   Specifies convention for angle interval. MIDANGLE is the center of the
%   2*PI interval containing the result. See <a href="matlab:doc
%   ('normalizeAngle')">normalizeAngle</a> for details.
%
%   Example:
%   rad2deg(vectorAngle([2 2]))
%   ans =
%       45
%   rad2deg(vectorAngle([1 sqrt(3)]))
%   ans =
%       60
%   rad2deg(vectorAngle([0 -1]))
%   ans =
%       270
%        
%   See also:
%     vectors2d, angles2d, normalizeAngle
%

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2007-10-18
% Copyright 2011 INRA - Cepia Software Platform.

%   HISTORY
%   2010-04-16 add psb to specify center interval
%   2011-04-10 add support for angle between two vectors


%% Initializations

% default values
v2 = [];
midAngle = pi; % normalize angles between 0 and 2*PI

% process input arguments
while ~isempty(varargin)
    var = varargin{1};
    if isnumeric(var) && isscalar(var)
        % argument is normalization constant
        midAngle = varargin{1};
        varargin(1) = [];
        
    elseif isnumeric(var) && size(var, 2) == 2
        % argument is second vector
        v2 = varargin{1};
        varargin(1) = [];
        
    elseif ischar(var) && length(varargin) >= 2
        % argument is option given as string + value
        if strcmpi(var, 'cutAngle') || strcmpi(var, 'midAngle')
            midAngle = varargin{2};
            varargin(1:2) = [];
            
        else
            error(['Unknown option: ' var]);
        end
        
    else
        error('Unable to parse inputs');
    end
end


%% Case of one vector

% If only one vector is provided, computes its angle
if isempty(v2)
    % compute angle and format result in a 2*pi interval
    alpha = atan2(v1(:,2), v1(:,1));
    
    % normalize within a 2*pi interval
    alpha = normalizeAngle(alpha + 2*pi, midAngle);
    
    return;
end


%% Case of two vectors

% compute angle of each vector
alpha1 = mod(atan2(v1(:,2), v1(:,1)), 2*pi);
alpha2 = mod(atan2(v2(:,2), v2(:,1)), 2*pi);

% difference
alpha = bsxfun(@minus, alpha2, alpha1);

% normalize within a 2*pi interval
alpha = normalizeAngle(alpha + 2*pi, midAngle);

