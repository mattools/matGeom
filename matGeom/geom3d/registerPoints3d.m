function [tfm, pts, varargout] = registerPoints3d(source, target, varargin)
%REGISTERPOINTS3D Computes a rigid transform between two 3D point sets.
%
%   TFM = registerPoints3d(SOURCE, TARGET)
%   Computes the 3D rigid transform (composed of a rotation and a
%   translation) that maps the the SOURCE points onto the TARGET points. 
%   Both SOURCE and TARGET are N-by-3 numeric arrays representing point
%   coordinates. SOURCE and TARGET do not necessarily need to have the same 
%   size. The result TFM is a 4-by-4 matrix representing the final affine 
%   transform.
%
%   Note: The deviation of the aligment of the two point sets should not be
%   too extreme. A proper pre-registration increases the chance of finding
%   the global minimum.
%
%   TFM = registerPoints3d(POINTS, TARGET, NITERS)
%   Specifies the number of iterations for the algorithm.
%   
%   [TFM, PTS] = registerPoints3d(...)
%   Additionally, returns the source points transformed by TFM.
%   
%   Different algorithms can be selected using a name-value pair with the 
%   name 'algorithm' and one of the following values:
%       'icp' - registerPoints3d_icp.m - iterative closest point algorithm
%           implemented by Kjer and Wilm. This is the default setting.
%       'affine' - registerPoints3dAffine.m - algorithm implemented by 
%           Legland.
%   Have a look in the respective m-file for further information on  
%   additional input arguments defined as name-value pairs for the specific
%   algorithm.
%
%   Example
%     % Load example data
%     b1k = readMesh('bunny_F1k.ply');
%     b5k = readMesh('bunny_F5k.ply');
%     % Create a random transformation
%     center = -10+20*rand(1,3);
%     phi = randi([-15,15]); theta = randi([-15,15]); psi = randi([-15,15]);
%     TFM = eulerAnglesToRotation3d(5, 10, 15, 'ZYX'); TFM(1:3,4) = center';
%     % Apply transform to source points
%     source = transformPoint3d(b1k.vertices, TFM);
%     % Register source to target
%     [tfm, b1k2b5k] = registerPoints3d(source, b5k.vertices, 100);
%     % Compare transforms that should be almost the same
%     inv(TFM)-tfm
%   
%   See also 
%   transforms3d, registerPoints3d_icp, registerPoints3d_affine

% ------
% Author: oqilipo
% E-mail: N/A
% Created: 2024-07-07, using Matlab 23.2.0.2515942 (R2023b) Update 7
% Copyright 2024

parser = inputParser;
parser.KeepUnmatched = true;
isPoints3d = @(x) validateattributes(x, {'numeric'},...
    {'size',[nan, 3],'nonempty','nonnan','real','finite'});
parser.addRequired('source', isPoints3d);
parser.addRequired('target', isPoints3d);
parser.addOptional('nIters', 10, @ (x) x > 0 && x < 10^5);
validStrings = {'icp','affine'};
parser.addParameter('algorithm','icp',@(x) any(validatestring(x, validStrings)))
parse(parser,source,target,varargin{:});
algorithm = parser.Results.algorithm;

switch algorithm
    case 'affine'
        [tfm, pts] = registerPoints3d_affine(source, target, varargin{:});
    case 'icp'
        [tfm, pts, err, tm] = registerPoints3d_icp(source, target, varargin{:});
        varargout{1} = err;
        varargout{2} = tm;
end