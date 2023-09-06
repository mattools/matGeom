function [ax, varargin] = parseAxisHandle(varargin)
%PARSEAXISHANDLE  Parse handle to axis, or return current axis.
%
%   Usage:
%   [ax, varargin] = parseAxisHandle(varargin{:});
%
%   Example
%   parseAxisHandle
%
%   See also
%     isAxisHandle
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2023-09-05,    using Matlab 9.14.0.2206163 (R2023a)
% Copyright 2023 INRAE.

% varargin can not be empty
if isempty(varargin)
    error('Requires at least one input argument');
end

% extract handle of axis to draw on
var1 = varargin{1};
if isscalar(var1) && ishandle(var1) && strcmp(get(var1, 'type'), 'axes')
    ax = varargin{1};
    varargin(1) = [];
else
    ax = gca;
end
