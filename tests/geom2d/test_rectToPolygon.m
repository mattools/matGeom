function test_suite = test_rectToPolygon(varargin) %#ok<STOUT>

initTestSuite;

function test_simple %#ok<*DEFNU>

obox = [0 0 40 20 0];
exp = [0 0 ; 40 0; 40 20;0 20];

poly = rectToPolygon(obox);
assertEqual(exp, poly);


function test_rotated90

obox = [0 0 40 20 90];
exp = [0 0 ; 0 40; -20 40; -20 0];

poly = rectToPolygon(obox);
assertEqual(exp, poly);

