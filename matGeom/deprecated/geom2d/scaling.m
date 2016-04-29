function trans = scaling(varargin)
%SCALING return 3*3 matrix of a scaling in 2 dimensions
%
%   TRANS = scaling(SX, SY);
%   return the matrix corresponding to scaling by SX and SY in the 2
%   main directions.
%   The returned matrix has the form:
%   [SX  0  0]
%   [0  SY  0]
%   [0   0  1]
%
%   TRANS = scaling(SX);
%   Assume SX and SY are equals.
%
%   See also:
%   transforms2d, transformPoint, createTranslation, createRotation
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 07/04/2004.

%   HISTORY
%   04/01/2007: rename as scaling
%   22/04/2009: copy to createScaling and deprecate

% deprecation warning
warning('geom2d:deprecated', ...
    '''scaling'' is deprecated, use ''createScaling'' instead');

% call current implementation
trans = createScaling(varargin{:});
