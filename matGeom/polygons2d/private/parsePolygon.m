function polyOut = parsePolygon(poly, format, varargin)
%PARSEPOLYGON Conversion between different polygon formats.
%
%

% Parsing
p = inputParser;
% logParValidFunc=@(x) (islogical(x) || isequal(x,1) || isequal(x,0));
addRequired(p,'format',...
    @(x) any(validatestring(x,{'cell','nan','repetition','polyshape'})));
parse(p,format,varargin{:});

format = p.Results.format;

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