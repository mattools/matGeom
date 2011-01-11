function kappa = surfaceCurvature(kappa1, kappa2, theta)
%SURFACECURVATURE compute curvature on a surface in a given direction 
%
%   usage :
%   KAPPA = surfaceCurvature(KAPPA1, KAPPA2, THETA)
%   return the curvature KAPPA of surface with respect to direction THETA.

%   KAPPA1 and KAPPA2 are the principal curvatures of the surface at the
%   considered point. THETA is angle of direction relative to angle of
%   first principal curvature KAPPA1.
%
%   Examples :
%   K = surfaceCurvature(KAPPA1, KAPPA2, 0) returns KAPPA1.
%   K = surfaceCurvature(KAPPA1, KAPPA2, pi/2) returns KAPPA2.
%
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 07/04/2004.
%

%   HISTORY
%   20/04/2004 : change name and add doc.
%   14/06/2004 : correct creation date

kappa = kappa1*(cos(theta).*cos(theta)) + kappa2*(sin(theta).*sin(theta));
