function test_suite = test_orientedBoxToPolygon(varargin) %#ok<STOUT>

initTestSuite;

function test_simple %#ok<*DEFNU>

obox = [0 0 40 20 0];
exp = [-20 -10 ; 20 -10 ; 20 10; -20 10];

poly = orientedBoxToPolygon(obox);
assertEqual(exp, poly);

function test_rotated90

obox = [0 0 40 20 90];
exp = [10 -20 ; 10 20 ; -10 20; -10 -20];

poly = orientedBoxToPolygon(obox);
assertEqual(exp, poly);

