function [hAx, prim, varargin]=parseDrawInput(prim,valFun,type,defOpts,varargin)
%PARSEDRAWINPUT Parse input arguments for drawing functions: draw*.
% 
%   INPUT:
%       PRIM: The primitive object: line, plane, ...
%       VALFUN: An anonymous Function to validate PRIM
%       TYPE: The drawing type of PRIM: 'line', 'patch', ...
%       DEFOPTS: The default drawing options for PRIM as struct
%
%   OUTPUT:
%       HAX: The current or specified axes for drawing
%       PRIM: validated PRIM
%
% ------
% Author: oqilipo
% Created: 2017-10-13, using R2017b
% Copyright 2017

% Check if first input argument is an axes handle
if isAxisHandle(prim)
    hAx = prim;
    prim = varargin{1};
    varargin(1) = [];
else
    hAx = gca;
end

% Check if the primitive is valid
p=inputParser;
addRequired(p,'prim',valFun)
parse(p,prim)

% parse input arguments if there are any
if ~isempty(varargin)
    if length(varargin) == 1
        if isstruct(varargin{1})
            % if options are specified as struct, need to convert to 
            % parameter name-value pairs
            varargin = [fieldnames(varargin{1}) struct2cell(varargin{1})]';
            varargin = varargin(:)';
        else
            % if option is a single argument, assume it is the color
            switch type
                case 'line'
                    varargin = {'Color', varargin{1}};
                case 'patch'
                    varargin = {'FaceColor', varargin{1}};
            end
        end
    end
else
    % If no arguments are given, use the default options
    varargin = [fieldnames(defOpts) struct2cell(defOpts)]';
    varargin = varargin(:)';
end

end