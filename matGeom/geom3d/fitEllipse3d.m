function [fittedEllipse3d, TFM3D] = fitEllipse3d(points, varargin)
%FITELLIPSE3D Fit an ellipse to a set of points.
%
%   FITTEDELLIPSE3D = fitEllipse3d(POINTS) returns the 3D ellipse fitted to
%   a set of 3D points.
%
%   Example
%     % Create 2D ellipse
%     n=randi([10,100]);
%     a=randi([30,50]); b=randi([5,25]);
%     [x, y] = ellipseToPolygon([0 0 a b 0 ], n);
%     % 3D and add some noise
%     points = [x, y, zeros(n,1)];
%     points=points+(-1+2*rand(n,3));
%     % Create a random transformation
%     center=-100+200*rand(1,3);
%     phi=randi([-180,180]); theta=randi([-180,180]); psi=randi([-180,180]);
%     TFM=eulerAnglesToRotation3d(phi, theta, psi, 'ZYZ'); TFM(1:3,4)=center';
%     points = transformPoint3d(points, TFM);
%     % Fit ellipse
%     [fE, fTFM] = fitEllipse3d(points, 'vis', true);
%     % Plot reconstructed ellipse
%     [fx, fy] = ellipseToPolygon([0 0 fE(4), fE(5) 0 ], n);
%     fpoints = transformPoint3d([fx, fy, zeros(n,1)], fTFM);
%     drawEllipse3d(fE,'k')
%   
%   See also
%     drawEllipse3d, ellipseToPolygon
%
%   Source
%     Nested functions are part of the quadfit toolbox of Levente Hunyadi
%     https://de.mathworks.com/matlabcentral/fileexchange/45356
%
% ---------
% Author: oqilipo
% Created: 2017-08-11
% Copyright 2017

parser = inputParser;
addRequired(parser, 'points', @(x) validateattributes(x, {'numeric'},...
    {'ncols',3,'real','finite','nonnan'}));
addOptional(parser,'visualization',false,@islogical);
parse(parser,points,varargin{:});

points=parser.Results.points;

% Mean of all points
meanPoint = mean(points,1);
% Center points around origin
centeredPoints = bsxfun(@minus, points, meanPoint);

% Transformation to x-y plane
[~,~,R]=svd(centeredPoints);
tfmPoints = transformPoint3d(centeredPoints, R');

% Fit ellipse
parEllipse = ellipsefit_direct(tfmPoints(:,1),tfmPoints(:,2));
% Convert to explicit form
[X, Y, A, B, phi2D] = ellipse_im2ex(parEllipse);

% Transform to fitted 2d ellipse
TFM2D = createRotationOz(phi2D);
TFM2D(1:3,4)=[X; Y; 0];

% Transformation back to 3d space
TFM3D = [inv(R'), meanPoint'; 0 0 0 1]*TFM2D;

% Extract translation
center = TFM3D(1:3,4)';

% Extract rotation
TFM3D_ROT=TFM3D(1:3,1:3);
% Convert to euler angles
[PHI, THETA, PSI] = rotation3dToEulerAngles(TFM3D_ROT,'ZYZ');

% Test if psi is correct
TFM3D_test = eulerAnglesToRotation3d(PHI, THETA, PSI,'ZYZ');
if ~all(all(ismembertol(TFM3D_test(1:3,1:3), TFM3D_ROT)))
    PSI=-1*PSI;
end

% matGeom format
fittedEllipse3d=[center A B THETA PHI PSI];

%% Visualization
if parser.Results.visualization == true
    
    figure('Color','w'); axis equal tight; hold on; view(3)
    xlabel('x'); ylabel('y'); zlabel('z');
    
    % Input points
    scatter3(points(:,1),points(:,2),points(:,3), 'r', 'filled')
    
    % Centered points
    scatter3(centeredPoints(:,1),centeredPoints(:,2),centeredPoints(:,3), 'g', 'filled')
    
    % SVD points
    scatter3(tfmPoints(:,1),tfmPoints(:,2),tfmPoints(:,3), 'b', 'filled')
    % planeProps.FaceAlpha=0.25;
    % planeProps.FaceColor='b';
    % drawPlane3d([0 0 0 1 0 0 0 1 0],planeProps)
    
    % Fitted ellipse
    drawEllipse3d(fittedEllipse3d)
end

%% Nested functions
    function p = ellipsefit_direct(x,y)
        % Direct least squares fitting of ellipses.
        %
        % Input arguments:
        % x,y;
        %    x and y coodinates of 2D points
        %
        % Output arguments:
        % p:
        %    a 6-parameter vector of the algebraic ellipse fit with
        %    p(1)*x^2 + p(2)*x*y + p(3)*y^2 + p(4)*x + p(5)*y + p(6) = 0
        %
        % References:
        % Andrew W. Fitzgibbon, Maurizio Pilu and Robert B. Fisher, "Direct Least
        %    Squares Fitting of Ellipses", IEEE Trans. PAMI 21, 1999, pp476-480.
        
        % Copyright 2011 Levente Hunyadi
        
        narginchk(2,2);
        validateattributes(x, {'numeric'}, {'real','nonempty','vector'});
        validateattributes(y, {'numeric'}, {'real','nonempty','vector'});
        x = x(:);
        y = y(:);
        
        % normalize data
        mx = mean(x);
        my = mean(y);
        sx = (max(x)-min(x))/2;
        sy = (max(y)-min(y))/2;
        smax = max(sx,sy);
        sx = smax;
        sy = smax;
        x = (x-mx)/sx;
        y = (y-my)/sy;
        
        % build design matrix
        D = [ x.^2  x.*y  y.^2  x  y  ones(size(x)) ];
        
        % build scatter matrix
        S = D'*D;
        
        % build 6x6 constraint matrix
        C = zeros(6,6);
        C(1,3) = -2;
        C(2,2) = 1;
        C(3,1) = -2;
        
        if 1
            p = ellipsefit_robust(S,-C);
        elseif 0
            % solve eigensystem
            [gevec, geval] = eig(S,C);
            geval = diag(geval);
            
            % extract eigenvector corresponding to unique negative (nonpositive) eigenvalue
            p = gevec(:,geval < 0 & ~isinf(geval));
            r = geval(geval < 0 & ~isinf(geval));
        elseif 0
            % formulation as convex optimization problem
            gamma = 0; %#ok<*UNRCH>
            cvx_begin sdp
            variable('gamma');
            variable('lambda');
            
            maximize(gamma);
            lambda >= 0; %#ok<*VUNUS>
            %[ S + lambda*C,       zeros(size(S,1),1) ...
            %; zeros(1,size(S,2)), lambda - gamma ...
            %] >= 0;
            S + lambda*C >= 0;
            lambda - gamma >= 0;
            cvx_end
            
            % recover primal optimal values from dual
            [evec, eval] = eig(S + lambda*C);
            eval = diag(eval);
            [~,ix] = min(abs(eval));
            p = evec(:,ix);
        end
        
        % unnormalize
        p(:) = ...
            [ p(1)*sy*sy ...
            ; p(2)*sx*sy ...
            ; p(3)*sx*sx ...
            ; -2*p(1)*sy*sy*mx - p(2)*sx*sy*my + p(4)*sx*sy*sy ...
            ; -p(2)*sx*sy*mx - 2*p(3)*sx*sx*my + p(5)*sx*sx*sy ...
            ; p(1)*sy*sy*mx*mx + p(2)*sx*sy*mx*my + p(3)*sx*sx*my*my - p(4)*sx*sy*sy*mx - p(5)*sx*sx*sy*my + p(6)*sx*sx*sy*sy ...
            ];
        
        p = p ./ norm(p);
    end

    function p = ellipsefit_robust(R, Q)
        % Constrained ellipse fit by solving a modified eigenvalue problem.
        % The method is numerically stable.
        %
        % Input arguments:
        % R:
        %    positive semi-definite data covariance matrix
        % Q:
        %    constraint matrix in parameters x^2, xy, y^2, x, y and 1.
        %
        % Output arguments:
        % p:
        %    estimated parameters (taking constraints into account)
        
        % References:
        % Radim Halir and Jan Flusser, "Numerically stable direct least squares fitting of
        %    ellipses", 1998
        
        % Copyright 2012 Levente Hunyadi
        
        validateattributes(R, {'numeric'}, {'real','2d','size',[6,6]});
        validateattributes(Q, {'numeric'}, {'real','2d','size',[6,6]});
        
        % check that constraint matrix has all zeros except in upper left block
        assert( nnz(Q(4:6,:)) == 0 );
        assert( nnz(Q(:,4:6)) == 0 );
        
        S1 = R(1:3,1:3);     % quadratic part of the scatter matrix
        S2 = R(1:3,4:6);     % combined part of the scatter matrix
        S3 = R(4:6,4:6);     % linear part of the scatter matrix
        T = -(S3 \ S2');     % for getting a2 from a1
        M = S1 + S2 * T;     % reduced scatter matrix
        M = Q(1:3,1:3) \ M;  % premultiply by inv(C1), e.g. M = [M(3,:)./2 ; -M(2,:) ; M(1,:)./2] for an ellipse
        [evec,~] = eig(M);   % solve eigensystem
        
        % evaluate a'*C*a, e.g. cond = 4 * evec(1,:).*evec(3,:) - evec(2,:).^2 for an ellipse
        cond = zeros(1,size(evec,2));
        for k = 1 : numel(cond)
            cond(k) = evec(:,k)'*Q(1:3,1:3)*evec(:,k);
        end
        
        % eigenvector for minimum positive eigenvalue
        evec = evec(:,cond > 0);
        cond = cond(cond > 0);
        [~,ix] = min(cond);
        p1 = evec(:,ix);  % eigenvector for minimum positive eigenvalue
        
        % ellipse coefficients
        p = [p1 ; T * p1];
    end

    function varargout = ellipse_im2ex(varargin)
        % Cast ellipse defined with implicit parameter vector to explicit form.
        %
        % See also: ellipse_ex2im
        
        % Copyright 2011 Levente Hunyadi
        
        if nargin > 1
            narginchk(6,6);
            for k = 1 : 6
                validateattributes(varargin{k}, {'numeric'}, {'real','scalar'});
            end
            [c1,c2,a,b,phi] = ellipse_explicit(varargin{:});
        else
            narginchk(1,1);
            p = varargin{1};
            validateattributes(p, {'numeric'}, {'real','vector'});
            p = p(:);
            validateattributes(p, {'numeric'}, {'size',[6 1]});
            [c1,c2,a,b,phi] = ellipse_explicit(p(1), 0.5*p(2), p(3), 0.5*p(4), 0.5*p(5), p(6));
        end
        if nargout > 1
            varargout = num2cell([c1,c2,a,b,phi]);
        else
            varargout{1} = [c1,c2,a,b,phi];
        end
        
        function [c1,c2,semia,semib,phi] = ellipse_explicit(a,b,c,d,f,g)
            % Cast ellipse defined with explicit parameter vector to implicit form.
            
            % helper quantities
            N = 2*(a*f^2+c*d^2+g*b^2-2*b*d*f-a*c*g);
            D = b^2-a*c;
            S = realsqrt((a-c)^2+4*b^2);
            
            % semi-axes
            ap = realsqrt( N/(D*(S-(a+c))) );
            bp = realsqrt( N/(D*(-S-(a+c))) );
            semia = max(ap,bp);
            semib = min(ap,bp);
            
            % center
            c1 = (c*d-b*f)/D;
            c2 = (a*f-b*d)/D;
            
            % angle of tilt
            if b ~= 0
                if abs(a) < abs(c)
                    phi = 0.5*acot((a-c)/(2*b));
                else
                    phi = 0.5*pi+0.5*acot((a-c)/(2*b));
                end
            else
                if abs(a) < abs(c)
                    phi = 0;
                else  % a > c
                    phi = 0.5*pi;
                end
            end
        end
    end
end