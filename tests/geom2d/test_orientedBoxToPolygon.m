function test_suite = test_orientedBoxToPolygon

test_suite = functiontests(localfunctions); 

function test_simple(testCase) %#ok<*DEFNU>

obox = [0 0 40 20 0];
exp = [-20 -10 ; 20 -10 ; 20 10; -20 10];

poly = orientedBoxToPolygon(obox);
testCase.assertEqual(exp, poly);

function test_rotated90(testCase)

obox = [0 0 40 20 90];
exp = [10 -20 ; 10 20 ; -10 20; -10 -20];

poly = orientedBoxToPolygon(obox);
testCase.assertEqual(exp, poly);

