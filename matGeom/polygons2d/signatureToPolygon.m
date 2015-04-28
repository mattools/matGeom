function poly = signatureToPolygon(signature, varargin)
%SIGNATURETOPOLYGON Reconstruct a polygon from its polar signature
%
%   POLY = signatureToPolygon(SIGNATURE)
%   POLY = signatureToPolygon(SIGNATURE, ANGLES)
%
%   Example
%   signatureToPolygon
%
%   See also
%     polygonSignature
 
% ------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% Created: 2015-04-28,    using Matlab 8.4.0.150421 (R2014b)
% Copyright 2015 INRA - Cepia Software Platform.

nAngles = length(signature);

% compute default signature
angleList = linspace(0, 360, nAngles+1);
angleList(end) = [];

if ~isempty(varargin)
    angleList = varargin{1};
    if length(angleList) ~= nAngles
        msg = 'signature and angle list must have same length (here %d and %d)';
        error(sprintf(msg, nAngles, length(angleList))); %#ok<SPERR>
    end
end

poly = zeros(nAngles, 2);
for iAngle = 1:nAngles
    angle = angleList(iAngle);
    
    poly(iAngle, :) = signature(iAngle) * [cosd(angle) sind(angle)];
end
