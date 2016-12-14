function test_suite = test_rectToPolygon

test_suite = functiontests(localfunctions); 

function test_simple(testCase) %#ok<*DEFNU>

obox = [0 0 40 20 0];
exp = [0 0 ; 40 0; 40 20;0 20];

poly = rectToPolygon(obox);
testCase.assertEqual(exp, poly);


function test_rotated90(testCase)

obox = [0 0 40 20 90];
exp = [0 0 ; 0 40; -20 40; -20 0];

poly = rectToPolygon(obox);
testCase.assertEqual(exp, poly);

