function varargout = cyl2cart(varargin)
%CYL2CART  Convert cylindrical to cartesian coordinates
%
%   CART = cyl2cart(CYL)
%   convert the 3D cylindrical coordinates of points CYL (given by 
%   [THETA R Z] where THETA, R, and Z have the same size) into cartesian
%   coordinates CART, given by [X Y Z]. 
%   The transforms is the following :
%   X = R*cos(THETA);
%   Y = R*sin(THETA);
%   Z remains inchanged.
%
%   CART = cyl2cart(THETA, R, Z)
%   provides coordinates as 3 different parameters
%
%   Example
%   cyl2cart([-1 0 2])
%   gives : 4.7124    1.0000     2.0000
%
%   See also angles3d, cart2pol, cart2sph2, cart2cyl
%
%
% ------
% Author: David Legland
% e-mail: david.legland@jouy.inra.fr
% Created: 2006-03-23
% Copyright 2006 INRA - CEPIA Nantes - MIAJ (Jouy-en-Josas).

% process input parameters
if length(varargin)==1
    var = varargin{1};
    theta = var(:,1);
    r = var(:,2);
    z = var(:,3);
elseif length(varargin)==3
    theta = varargin{1};
    r = varargin{2};
    z = varargin{3};
end

% convert coordinates
dim = size(theta);
x = reshape(r(:).*cos(theta(:)), dim);
y = reshape(r(:).*sin(theta(:)), dim);

% process output parameters
if nargout==0 ||nargout==1
    if length(dim)>2 || dim(2)>1
        varargout{1} = {x y z};
    else
        varargout{1} = [x y z];
    end
elseif nargout==3
    varargout{1} = x;
    varargout{2} = y;
    varargout{3} = z;
end
