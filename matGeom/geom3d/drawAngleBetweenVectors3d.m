function varargout = drawAngleBetweenVectors3d(o, v1, v2, r, varargin)
%DRAWANGLEBETWEENVECTORS3D Draw an arc between 2 vectors.
%
%   drawAngleBetweenVectors3d(ORIGIN, VECTOR1, VECTOR2, RADIUS) 
%   draws the arc between VECTOR1 and VECTOR2.
%
%   drawAngleBetweenVectors3d(...,'ConjugateAngle',1) draws the conjugate
%   angle instead of the small angle. Default is false.
%   
%   H = drawAngleBetweenVectors3d(...)
%   returns the handle of the created LINE object
%   
%   Example
%     o=-100 + 200*rand(1,3);
%     v1=normalizeVector3d(-1 + 2*rand(1,3));
%     v2=normalizeVector3d(-1 + 2*rand(1,3));
%     r = rand;
%     figure('color','w'); view(3)
%     hold on; axis equal tight; xlabel X; ylabel Y; zlabel Z;
%     drawVector3d(o, v1, 'r')
%     drawVector3d(o, v2, 'g')
%     drawAngleBetweenVectors3d(o, v1, v2, r,'Color','m','LineWidth', 3)
%
%   See also
%     drawCircleArc3d

% ---------
% Author: oqilipo
% Created: 2020-02-02
% Copyright 2020

% parse axis handle
hAx = gca;
if isAxisHandle(o)
    hAx = o;
    o = v1;
    v1 = v2;
    v2 = r;
    r = varargin{1};
    varargin(1) = [];
end

p = inputParser;
p.KeepUnmatched = true;
logParValidFunc=@(x) (islogical(x) || isequal(x,1) || isequal(x,0));
addParameter(p,'ConjugateAngle',false,logParValidFunc);
parse(p, varargin{:});
conjugate=p.Results.ConjugateAngle;
drawOptions=p.Unmatched;

% Normal of the two vectors
normal=normalizeVector3d(crossProduct3d(v1, v2));
% Align normal with the z axis.
ROT = createRotationVector3d(normal,[0 0 1]);
% Align first vector with x axis
ROTv1 = createRotationVector3d(transformVector3d(v1,ROT),[1 0 0]);
% Get Euler angles of the arc. 
% The arc is an flat object. Hence, use the 'ZYZ' convention.
[PHI, THETA, PSI] = rotation3dToEulerAngles((ROTv1*ROT)','ZYZ');
% Get angle between the vectors
angle=rad2deg(vectorAngle3d(v1, v2));
% Draw the arc
if ~conjugate
    h = drawCircleArc3d(hAx, [o r [THETA PHI PSI] 0 angle],drawOptions);
else
    h = drawCircleArc3d(hAx, [o r [THETA PHI PSI] 0 angle-360],drawOptions);
end

% Format output
if nargout > 0
    varargout{1} = h;
end