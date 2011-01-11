function triangulateFacesDemo(varargin)
%TRIANGULATEFACESDEMO  One-line description here, please.
%   output = triangulateFacesDemo(input)
%
%   Example
%   triangulateFacesDemo
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% Created: 2008-10-16,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2008 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.
% Licensed under the terms of the LGPL, see the file "license.txt"

% cree une figure simple (?) sous forme de sommets + aretes + faces
[n e f] = createCubeOctahedron; %#ok<ASGLU>

% affiche avec une fonction a la David
figure(1); clf;
drawPolyhedron(n, f);

% convertit en triangulation, et affiche
tri = triangulateFaces(f);
figure(2); clf;
patch('vertices', n, 'faces', tri, 'facecolor', 'r');