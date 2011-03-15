function varargout = transformPoint(varargin)
%TRANSFORMPOINT Transform a point with an affine transform
%
%   PT2 = transformPoint(PT1, TRANS);
%   where PT1 has the form [xp yp], and TRANS is a [2*2], [2*3] or [3*3]
%   matrix, returns the point transformed with affine transform TRANS.
%
%   Format of TRANS can be one of :
%   [a b]   ,   [a b c] , or [a b c]
%   [d e]       [d e f]      [d e f]
%                            [0 0 1]
%
%   PT2 = transformPoint(PT1, TRANS);
%   Also works when PTA is a [N*2] array of double. In this case, PT2 has
%   the same size as PT1.
%
%   [PX2 PY2] = transformPoint(PX1, PY1, TRANS);
%   Also works when PX1 and PY1 are arrays the same size. The function
%   transform each couple of (PX1, PY1), and return the result in 
%   (PX2, PY2), which is the same size as (PX1 PY1).
%
%
%   See also:
%   points2d, transforms2d, translation, rotation
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 06/04/2004.
%

%   HISTORY
%   25/04/2005 : support for 2D arrays of points (px, py, trans).


if length(varargin)==2
    var = varargin{1};
    px = var(:,1);
    py = var(:,2);
    trans = varargin{2};
elseif length(varargin)==3
    px = varargin{1};
    py = varargin{2};
    trans = varargin{3};
else
    error('wrong number of arguments in "transformPoint"');
end


% compute position
px2 = px*trans(1,1) + py*trans(1,2);
py2 = px*trans(2,1) + py*trans(2,2);

% add translation vector, if exist
if size(trans, 2)>2
    px2 = px2 + trans(1,3);
    py2 = py2 + trans(2,3);
end


if nargout==0 || nargout==1
    varargout{1} = [px2 py2];
elseif nargout==2
    varargout{1} = px2;
    varargout{2} = py2;
end