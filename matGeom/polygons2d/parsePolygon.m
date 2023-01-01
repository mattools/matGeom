function polyOut = parsePolygon(poly, format, varargin)
%PARSEPOLYGON Conversion between different polygon formats.
%
%   POLYOUT = parsePolygon(POLY, FORMAT)
%   Converts POLY to the specified format while FORMAT must be one of the
%   following options: 'cell','nan','repetition','polyshape'. Mainly used
%   in other polygon functions to bring the polygon into the required 
%   format.
%
%   Example
%     r = [2.5, 2, 1];
%     poly = flipud(circleToPolygon([0 0 r(1)], round(2*pi*r(1))));
%     midCircle = circleToPolygon([0 0 r(2)], round(2*pi*r(2)));
%     innerCircle = flipud(circleToPolygon([0 0 r(3)], round(2*pi*r(3))));
%     poly = {poly, midCircle, innerCircle};
%     polyOut = parsePolygon(poly, 'repetition');
%     polyOut = parsePolygon(polyOut, 'nan');
%     polyOut = parsePolygon(polyOut, 'polyshape');
%     polyOut = parsePolygon(polyOut, 'cell');
%     assert(isequal(poly, polyOut))
%
%   See also 
%   polygonToPolyshape
%

% ------
% Author: oqilipo
% E-mail: N/A
% Created: 2023-01-01, using MATLAB 9.13.0.2080170 (R2022b) Update 1
% Copyright 2023

% Parsing
p = inputParser;
% logParValidFunc=@(x) (islogical(x) || isequal(x,1) || isequal(x,0));
addRequired(p,'format',...
    @(x) any(validatestring(x,{'cell','nan','repetition','polyshape'})));
parse(p,format,varargin{:});

format = p.Results.format;

% If polygon is a polyshape object
if isa(poly,'polyshape')
    polyOut = parsePolygon(poly.Vertices, format);
    return
end

% If polygon is a cell
if iscell(poly)
    [r, c] = size(poly);
    if r > 1 && c > 1
        error(['Non-supported polygon cell format with ' num2str(r) ' rows and ' num2str(c) 'columns!'])
    elseif r > 1 && c == 1
        polyCell = poly';
    elseif r == 1 && c > 1
        polyCell = poly;
    elseif r == 1 && c == 1
        polyCell = poly;
    end
    if any(cellfun(@(x) any(isnan(x(:))), poly))
        error('Non-supported polygon cell format. Polygons in cell format should not contain NaN values!')
    end
end

if ~iscell(poly) && any(isnan(poly(:)))
    % If polygon contains nan
    polyCell = splitPolygons(poly)';
elseif ~iscell(poly)
    % If polygon contains vertex repetitions
    polyBackup = poly;
    polyCell = {};
    count = 0;
    while ~isempty(poly)
        count = count+1;
        repLIdx = ismember(poly, poly(1,:), 'rows');
        repIdx = find(repLIdx);
        if sum(repLIdx) == 1
            polyCell = {poly};
            if count == 1
                break
            else
                warning('Contains vertex repetitions but the last vertex is not a repetiton!')
                polyCell = {polyBackup};
            end
        elseif sum(repLIdx)>1
            polyCell = [polyCell, {poly(1:repIdx(2)-1,:)}]; %#ok<AGROW>
            poly(1:repIdx(2),:) = [];
        end
    end
end

% Convert to output format
switch format
    case 'cell'
        polyOut = polyCell;
    case 'nan'
        polyOut = cell2mat((cellfun(@(x) [x; nan(1, size(x,2))], polyCell, 'UniformOutput',false))');
        polyOut(end,:) = [];
    case 'repetition'
        polyOut = cell2mat((cellfun(@(x) [x; x(1,:)], polyCell, 'UniformOutput',false))');
    case 'polyshape'
        polyOut = polyshape(polyCell{1});
        NoP = length(polyCell);
        if NoP > 1
            for p=2:NoP
                polyOut = addboundary(polyOut, polyCell{p});
            end
        end
end

end