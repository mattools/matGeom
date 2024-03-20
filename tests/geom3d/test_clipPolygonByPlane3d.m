function test_suite = test_clipPolygonByPlane3d
%TEST_CLIPPOLYGONBYPLANE3D Test case for the file clipPolygonByPlane3d
%
%   Test case for the file clipPolygonByPlane3d

%   Example
%   test_clipPolygonByPlane3d
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-08-17,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions); 

function test_Triangle_FirstVertexOutside(testCase) %#ok<*DEFNU>

poly = [...
    12.1519 14.0046 58.5201; ...
    12.0680 18.2066 37.4846; ...
    12.1988 17.9510 37.4621];
plane = createPlane([0 0 0], [deg2rad(-75) deg2rad(0)]);
clipped = clipPolygonByPlane3d(poly, plane) ;

testCase.assertEqual(4, size(clipped, 1));

poly = poly([1:end 1], :);
clipped = clipPolygonByPlane3d(poly, plane) ;
testCase.assertEqual(4, size(clipped, 1));


function test_Triangle_LastVertexOutside(testCase)

poly = [...
    12.0680 18.2066 37.4846; ...
    12.1988 17.9510 37.4621; ...
    12.1519 14.0046 58.5201 ];

plane = createPlane([0 0 0], [deg2rad(-75) deg2rad(0)]);
clipped = clipPolygonByPlane3d(poly, plane) ;

testCase.assertEqual(4, size(clipped, 1));

poly = poly([1:end 1], :);
clipped = clipPolygonByPlane3d(poly, plane) ;
testCase.assertEqual(4, size(clipped, 1));


function test_Triangle_MiddleVertexOutside(testCase)

poly = [...
    12.1988 17.9510 37.4621; ...
    12.1519 14.0046 58.5201; ...
    12.0680 18.2066 37.4846];

plane = createPlane([0 0 0], [deg2rad(-75) deg2rad(0)]);
clipped = clipPolygonByPlane3d(poly, plane) ;

testCase.assertEqual(4, size(clipped, 1));

poly = poly([1:end 1], :);
clipped = clipPolygonByPlane3d(poly, plane) ;
testCase.assertEqual(4, size(clipped, 1));


function test_Square_SecondVertexOutside(testCase)

poly = [...
    10 20 30; ...
    50 20 30; ...
    50 80 30; ...
    10 80 30; ...
    ];

plane = createPlane([30 60 30], [1 0 0]);

clipped = clipPolygonByPlane3d(poly, plane) ;
testCase.assertEqual(4, size(clipped, 1));


function test_Square_FirstVertexOutside(testCase)

poly = [...
    50 20 30; ...
    50 80 30; ...
    10 80 30; ...
    10 20 30; ...
    ];

plane = createPlane([30 60 30], [1 0 0]);

clipped = clipPolygonByPlane3d(poly, plane) ;
testCase.assertEqual(4, size(clipped, 1));


function test_Square_LastVertexOutside(testCase)

poly = [...
    10 80 30; ...
    10 20 30; ...
    50 20 30; ...
    50 80 30; ...
    ];

plane = createPlane([30 60 30], [1 0 0]);

clipped = clipPolygonByPlane3d(poly, plane) ;
testCase.assertEqual(4, size(clipped, 1));
