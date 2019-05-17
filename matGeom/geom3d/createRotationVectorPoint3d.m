function TFM = createRotationVectorPoint3d(A,B,P)
%CREATEROTATIONVECTORPOINT3D Calculates the rotation between two vectors.
%   around a point
%   
%   TFM = createRotationVectorPoint3d(A,B,P) returns the transformation 
%   to rotate the vector A in the direction of vector B around point P
%   
%   Example
%     A=-5+10.*rand(1,3);
%     B=-10+20.*rand(1,3);
%     P=-50+100.*rand(1,3);
%     ROT = createRotationVectorPoint3d(A,B,P);
%     C = transformVector3d(A,ROT);
%     figure('color','w'); hold on; view(3)
%     drawPoint3d(P,'k')
%     drawVector3d(P, A,'r')
%     drawVector3d(P, B,'g')
%     drawVector3d(P, C,'r')
%
%   See also
%   transformPoint3d, createRotationVector3d
%
% ---------
% Author: oqilipo
% Created: 2017-08-07
% Copyright 2017

P = reshape(P,3,1);

% Translation from P to origin
invtrans = [eye(3),-P; [0 0 0 1]];

% Rotation from A to B
rot = createRotationVector3d(A, B);

% Translation from origin to P
trans = [eye(3),P; [0 0 0 1]];

% Combine
TFM = trans*rot*invtrans;

end