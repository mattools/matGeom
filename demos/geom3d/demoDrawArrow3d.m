function demoDrawArrow3d
%DEMODRAWARROW3D Demo of drawArrow3d
%
%   Example
%     demoDrawArrow3d
%
%   See also
%

% ------
% Authors: Shawn Arseneau, oqilipo
% History:
%   Created: 2006-09-14 by Shawn Arseneau
%   Updated: 2020-02-08 by oqilipo

% Output a collection of arrows with various color and shape options
figure('Color','w')
spH=arrayfun(@(x) subplot(2,2,x), 1:4);
for s=1:length(spH)
    axis(spH(s),'equal');
    grid(spH(s),'on');
    xlabel(spH(s),'X'); ylabel(spH(s),'Y'); zlabel(spH(s),'Z');
    view(spH(s),20,30);
    lighting(spH(s),'phong');
    camlight(spH(s),'head');
end

% Examples
[X, Y] = meshgrid(0:3:9, 0:3:9);
Z = ones(size(X));
U = zeros(size(X));
V = U;
W = ones(size(X))*8;
posArray = [X(:),Y(:),Z(:)];
magnitudeArray = [U(:),V(:),W(:)];

% Basic call
drawArrow3d(spH(1), posArray, magnitudeArray,'yellow','FaceAlpha', 0.5);

% Arrow-specific colors and change of stem ratio
arrowColors = jet(size(posArray,1));
drawArrow3d(spH(2), posArray, magnitudeArray, arrowColors, 'stemRatio',0.9);

% Change of stem ratios and stem radius
qH = drawArrow3d(spH(3), posArray, magnitudeArray, arrowColors, ...
    'stemRatio',linspace(0.5,0.9,size(posArray,1)), 'arrowRadius', 0.01);
delete(qH(end,:))

% Helix example
radius = 7;   height = 1;  numRotations = 2;  numPoints = 25;  arrowScale = 0.8;
[posArray1, magnitudeArray1] = helix(radius, height, numRotations, numPoints, arrowScale);
drawArrow3d(posArray1, magnitudeArray1)

radius = 2;   height = 0.66;  numRotations = 3;
[posArray2, magnitudeArray2] = helix(radius, height, numRotations, numPoints, arrowScale);
arrowColors2 = autumn(numPoints);
drawArrow3d(posArray2, magnitudeArray2, arrowColors2, 'stemRatio',0.6)

end

function [pos, vec] = helix(radius, height, numRevolutions, numPoints, arrowScale)
%HELIX Parametric equation of a helix
%
%     pos = helix(radius, height) outputs pos (x,y,z) locations along
%     a helix
%     [pos, vec] = helix(radius, height) outputs (x,y,z) along with 
%     tangent vectors (u,v,w) with a fixed magnitude
%     [...] = helix(..., numRevolutions) defines the number of  
%     revolutions. Default is two rotations of the helix.
%     [...] = helix(..., numRevolutions, numPoints) defines the number of
%     samples along the helix. Default is 25.
%     [...] = helix(..., numRevolutions, numPoints, arrowScale) defines 
%     the magnitude of the tangent vectors as proportion the length 
%     between the sampled points. Default is 0.8.
%     
% Example:
%     [pos, vec] = helix(5, 4, 7, 50, 0.24);  
%     drawArrow3d(pos, magn); 
%

% ------
% Author: Shawn Arseneau
% History:
%   Created: 2006-09-15 by Shawn Arseneau
%   Updated: 2020-02-08 by oqilipo

    if nargin<2 || nargin>5         
        error('Incorrect number of inputs to helix');   
    end
    if nargout~=1 && nargout~=2     
        error('Incorrect number of outputs to helix');  
    end
    if nargin<=4                    
        arrowScale = 0.8;                               
    end
    if nargin<=3                    
        numPoints = 25;                                 
    end
    if nargin<=2                    
        numRevolutions = 2;                               
    end

    endAngle = numRevolutions*2*pi;
    t = (0:endAngle/numPoints:endAngle);
    X_all = radius*cos(t);
    Y_all = radius*sin(t);
    Z_all = height*t;
    
    X = X_all(1:end-1);   X_end = X_all(2:end);
    Y = Y_all(1:end-1);   Y_end = Y_all(2:end);
    Z = Z_all(1:end-1);   Z_end = Z_all(2:end);
    
    pos = [X(:),Y(:),Z(:)];
    
    if nargout==2
        U = arrowScale*(X_end - X);
        V = arrowScale*(Y_end - Y);
        W = arrowScale*(Z_end - Z);
        vec = [U(:),V(:),W(:)];
    end
end