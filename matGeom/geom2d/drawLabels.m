function varargout = drawLabels(varargin)
%DRAWLABELS Draw labels at specified positions
%   
%   DRAWLABELS(X, Y, LBL) draw labels LBL at position X and Y.
%   LBL can be either a string array, or a number array. In this case,
%   string are created by using sprintf function, with '%.2f' mask.
%
%   DRAWLABELS(POS, LBL) draw labels LBL at position specified by POS,
%   where POS is a N*2 int array.
%
%   DRAWLABELS(..., NUMBERS, FORMAT) create labels using sprintf function,
%   with the mask given by FORMAT (e. g. '%03d' or '5.3f'), and the
%   corresponding values.
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 15/12/2003.
%

%   HISTORY
%   09/03/2007: (re)implement it...
%   2011-10-11 add management of axes handle

% check if enough inputs are given
if isempty(varargin)
    error('wrong number of arguments in drawLabels');
end

% extract handle of axis to draw on
if isscalar(varargin{1}) && ishandle(varargin{1})
    ax = varargin{1};
    varargin(1) = [];
else
    ax = gca;
end

% process input parameters
var = varargin{1};
if size(var, 2) == 1
    % coordinates given as separate arguments
    if length(varargin) < 3
        error('wrong number of arguments in drawLabels');
    end
    px  = var;
    py  = varargin{2};
    lbl = varargin{3};
    varargin(1:3) = [];
else
    % parameters given as a packed array
    if length(varargin) < 2
        error('wrong number of arguments in drawLabels');
    end
    px  = var(:,1);
    py  = var(:,2);
    lbl = varargin{2};
    varargin(1:2) = [];
end

% format for displaying numeric values
format = '%.2f';
if ~isempty(varargin)
    format = varargin{1};
end
if size(format, 1) == 1 && size(px, 1) > 1
    format = repmat(format, size(px, 1), 1);
end

% compute the strings that have to be displayed
labels = cell(length(px), 1);
if isnumeric(lbl)
    for i = 1:length(px)
        labels{i} = sprintf(format(i,:), lbl(i));
    end
elseif ischar(lbl)
    for i = 1:length(px)
        labels{i} = lbl(i,:);
    end
elseif iscell(lbl)
    labels = lbl;
end
labels = char(labels);

% display the text
h = text(px, py, labels, 'parent', ax);

% format output
if nargout > 0
    varargout = {h};
end

