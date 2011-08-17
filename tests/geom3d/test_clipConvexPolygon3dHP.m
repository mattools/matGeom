function test_suite = test_clipConvexPolygon3dHP(varargin) %#ok<STOUT>
%TEST_clipConvexPolygon3dHP  Test case for the file clipConvexPolygon3dHP
%
%   Test case for the file clipConvexPolygon3dHP

%   Example
%   test_clipConvexPolygon3dHP
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-08-17,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

initTestSuite;

function test_Triangle_FirstVertexOutside %#ok<*DEFNU>

poly = [...
    12.1519 14.0046 58.5201; ...
    12.0680 18.2066 37.4846; ...
    12.1988 17.9510 37.4621];
plane = createPlane([0 0 0], [deg2rad(-75) deg2rad(0)]);
clipped = clipConvexPolygon3dHP(poly, plane) ;

assertEqual(4, size(clipped, 1));


poly = poly([1:end 1], :);
clipped = clipConvexPolygon3dHP(poly, plane) ;
assertEqual(4, size(clipped, 1));


function test_Triangle_LastVertexOutside

poly = [...
    12.0680 18.2066 37.4846; ...
    12.1988 17.9510 37.4621; ...
    12.1519 14.0046 58.5201 ];

plane = createPlane([0 0 0], [deg2rad(-75) deg2rad(0)]);
clipped = clipConvexPolygon3dHP(poly, plane) ;

assertEqual(4, size(clipped, 1));

poly = poly([1:end 1], :);
clipped = clipConvexPolygon3dHP(poly, plane) ;
assertEqual(4, size(clipped, 1));


function test_Triangle_MiddleVertexOutside

poly = [...
    12.1988 17.9510 37.4621; ...
    12.1519 14.0046 58.5201; ...
    12.0680 18.2066 37.4846];

plane = createPlane([0 0 0], [deg2rad(-75) deg2rad(0)]);
clipped = clipConvexPolygon3dHP(poly, plane) ;

assertEqual(4, size(clipped, 1));

poly = poly([1:end 1], :);
clipped = clipConvexPolygon3dHP(poly, plane) ;
assertEqual(4, size(clipped, 1));


function test_Square_SecondVertexOutside

poly = [...
    10 20 30; ...
    50 20 30; ...
    50 80 30; ...
    10 80 30; ...
    ];

plane = createPlane([30 60 30], [1 0 0]);

clipped = clipConvexPolygon3dHP(poly, plane) ;
assertEqual(4, size(clipped, 1));


function test_Square_FirstVertexOutside

poly = [...
    50 20 30; ...
    50 80 30; ...
    10 80 30; ...
    10 20 30; ...
    ];

plane = createPlane([30 60 30], [1 0 0]);

clipped = clipConvexPolygon3dHP(poly, plane) ;
assertEqual(4, size(clipped, 1));


function test_Square_LastVertexOutside

poly = [...
    10 80 30; ...
    10 20 30; ...
    50 20 30; ...
    50 80 30; ...
    ];

plane = createPlane([30 60 30], [1 0 0]);

clipped = clipConvexPolygon3dHP(poly, plane) ;
assertEqual(4, size(clipped, 1));
