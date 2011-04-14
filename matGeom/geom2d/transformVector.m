function varargout = transformVector(varargin)
%TRANSFORMVECTOR Transform a vector with an affine transform
%
%   VECT2 = transformVector(VECT1, TRANS);
%   where VECT1 has the form [xv yv], and TRANS is a [2*2], [2*3] or [3*3]
%   matrix, returns the vector transformed with affine transform TRANS.
%
%   Format of TRANS can be one of :
%   [a b]   ,   [a b c] , or [a b c]
%   [d e]       [d e f]      [d e f]
%                            [0 0 1]
%
%   VECT2 = transformVector(VECT1, TRANS);
%   Also works when PTA is a [N*2] array of double. In this case, VECT2 has
%   the same size as VECT1.
%
%   [vx2 vy2] = transformVector(vx1, vy1, TRANS);
%   Also works when vx1 and vy1 are arrays the same size. The function
%   transform each couple of (vx1, vy1), and return the result in 
%   (vx2, vy2), which is the same size as (vx1 vy1).
%
%
%   See also:
%   vectors2d, transforms2d, rotateVector, transformPoint
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 12/03/2007.
%

%   HISTORY


if length(varargin)==2
    var = varargin{1};
    vx = var(:,1);
    vy = var(:,2);
    trans = varargin{2};
elseif length(varargin)==3
    vx = varargin{1};
    vy = varargin{2};
    trans = varargin{3};
else
    error('wrong number of arguments in "transformVector"');
end


% compute new position of vector
vx2 = vx*trans(1,1) + vy*trans(1,2);
vy2 = vx*trans(2,1) + vy*trans(2,2);

% format output
if nargout==0 || nargout==1
    varargout{1} = [vx2 vy2];
elseif nargout==2
    varargout{1} = vx2;
    varargout{2} = vy2;
end