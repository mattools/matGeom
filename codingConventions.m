%CODINGCONVENTIONS specifies coding conventions for MatGeom files.
%
%   General
%
%   This file specifies coding conventions for new files. Files that were 
%   created before the coding conventions were introduced do not
%   necessarily comply with the requirements.
%
%   There are three levels of conventions:
%   MUST: an obligation for new files, and existing files not respecting
%     this convention should be changed to respect it.
%   SHOULD: it is better to do it, but not necessary.
%   MAY: it is optional, but commonly used by some developpers.
%
%   Name of functions
%
%   CamelCase convention for file names must be used:
%   * Each function name must be written in lower case, using english
%       denomination.
%   * For compound function names, the first letter of each component after
%       the first one is capitalized.
%       Ex: 'distancePointPlane'.
%
%   Other conventions should be used to avoid name conflicts:
%   * For functions which work on a complex data type, the name of the data
%       type should be used as a prefix of the function name. 
%       Ex: functions working on polygons have a prototype on the form
%       'polygonLength', 'polygonArea'...
%   * Functions working with geometrical primitives can use a suffix for
%       indicating the dimension of application. 
%       Ex: 'distancePointLine3d'.
%       This convention was not used at the beginning of the library
%       development, but new functions will try to conform to it.
%   * Conversion functions use 'To' between radicals. Ex:
%       ellipseToPolygon, edgeToLine, circleArcToPolyline...
%   * Some functions use a underscore to help identify between different
%       algorithms or formats: 'readMesh_ply', 'readMesh_off'...
%
%   Function header
%
%   * First line of documentation must contain the name of the function,
%   followed by a short description, and terminated by a dot. The name of
%   the function must be capitalized, without punctuation before the
%   description (to remain valid with matlab documentation tools). 
%   Ex: 
%   '%DISTANCEPOINTLINE Minimum distance between a point and a line.'
%
%   * Main part of header describes usage of function/script with various
%   parameters. Function name should be the real name. Variable names may
%   be capitalized. This does not follow MATLAB's standard, but allows to
%   copy-paste code snippets. 
%   Ex:
%     'RES = myBasicFunction(PARAM1, PARAM2, OPTION);'
%
%   * The description of each calling syntax should be written using
%   conjugated verbs.
%   
%   * The end of header should contain the name of the author, e-mail of  
%   the author, date of creation, MATLAB version used for creation, year 
%   of copyright, and affiliation. See below for the exact format. See also 
%   the function checkHeader.m (in 'checks' directory).
%
%   Function code
%
%   * Please comment the code! For algorithmic parts, as much comments as
%   code is a good start ...
%   * Indentation level should be marked by four space characters.
%
%
%   Tips & Tricks
%
%   * The use of '...' at the end of a line can cause compatibility
%   problems from Linux to Windows.
%   * MATLAB help uses the file 'Contents.m', not 'contents.m'!
%

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2005-03-23
% Copyright 2005-2024 INRA - TPV URPOI - MIA MathCell

help codingConventions;
