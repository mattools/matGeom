function ROT = createRotationVector3d(A,B)
%CREATEROTATIONVECTOR3D Calculates the rotation between two vectors
%
%   ROT = createRotationVector3d(A, B) returns the 4x4 rotation matrix ROT
%   to transform vector A in the same direction as vector B.
%
%   Example
%     A=[ .1  .2  .3];
%     B=-1+2.*rand(1,3);
%     ROT = createRotationVector3d(A,B);
%     C = transformVector3d(A,ROT);
%     figure('color','w'); hold on; view(3)
%     O=[0 0 0];
%     drawVector3d(O, A,'r');
%     drawVector3d(O, B,'g');
%     drawVector3d(O, C,'r');
%
%   See also
%   transformPoint3d, createRotationOx, createRotationOy, createRotationOz
%
%   Source
%     https://math.stackexchange.com/a/897677
%
% ---------
% Author: oqilipo
% Created: 2017-08-07
% Copyright 2017

if isParallel3d(A,B)
    if A*B'>0
        ROT = eye(4);
    else
        ROT = -1*eye(4); ROT(end)=1;
    end
else
    a=normalizeVector3d(A);
    b=normalizeVector3d(B);
    a=reshape(a,3,1);
    b=reshape(b,3,1);
    
    v = cross(a,b);
    ssc = [0 -v(3) v(2); v(3) 0 -v(1); -v(2) v(1) 0];
    ROT = eye(3) + ssc + ssc^2*(1-dot(a,b))/(norm(v))^2;
    
    ROT = [ROT, [0;0;0]; 0 0 0 1];
end

end