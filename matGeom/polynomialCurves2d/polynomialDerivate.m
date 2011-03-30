function deriv = polynomialDerivate(poly)
%POLYNOMIALDERIVATE Derivate a polynomial
%
%   DERIV = polynomialDERIVATE(POLY)
%   POLY is a row vector of [n+1] coefficients, in the form:
%       [a0 a1 a2 ... an]
%   DERIV has the same format, with length n:
%       [a1 a2*2 ... an*n]
%
%
%   Example
%   T = polynomialDerivate([2 3 4])
%   returns:
%   T = [3 8]
%
%   See also
%   polynomialCurves2d
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2007-02-23
% Copyright 2007 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.


% create the derivation matrices
matrix = diag(0:length(poly)-1);

% compute coefficients of first derivative polynomials
deriv = circshift(poly*matrix, [0 -1]);


