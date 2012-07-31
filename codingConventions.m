%CODINGCONVENTIONS specify coding conventions for MatGeom files
%
%   General
%
%   This file specifies coding convention for future files. Current files
%   do not necessarily follows the requirements, as they were created
%   before conventions.
%
%   There are three levels of conventions:
%   MUST: an obligation for new files, and existing files not respecting
%     this convention should be changed to respect it.
%   SHOULD: it is better to do it, but not necessary.
%   MAY: it is optional, but commonly used by some developpers.
%
%   Name of functions
%
%   Java convention for file names must be used:
%   * Each function name must be written in lower case, using english
%       denomination.
%   * For compound function names, the first letter of each component after
%       the first one is capitalized.
%       Ex: 'distancePointPlane'.
%
%   Other convention should be used to avoid name conflicts:
%   * For functions which work on a complex data type, the name of the data
%       type should be used as a prefix of the function name. 
%       Ex: functions working on polygons have a prototype on the form
%       'polygonLength', 'polygonArea'...
%   * Functions working with geometrical primitives can use a suffix for
%       indicating the dimension of application. 
%       Ex: 'distancePointLine3d'.
%       This convention was not used for the beginning of the library
%       development, but new functions will try to conform to it.
%   * Conversion functions use 'To' between radicals. Ex:
%       ellipseToPolygon, edgeToLine, circleArcToPolyline...
%
%   Function header
%
%   * First line of documentation must contain the name of the function,
%   followed by a short description. Name and function may be separated by
%   colon. Name must be capitalized, without punctuation before
%   description (to remain valid with matlab documentation tools). 
%   Ex:   'SLICER interactive visualization of 3D images'
%
%   * Main part of header describes usage of function/script with various
%   parameters. Function name should be the real name. Variable names
%   should be capitalized. This does not follow matlab's standard, but
%   allows to copy-paste pieces of code.
%   Ex: 'RES = myBasicFunction(PARAM1, PARAM2, OPTION);'
%
%   * The description of each calling syntax should be written using
%   conjugated verbs.
%   
%   * End of header should contain name of author, with date of creation.
%   It may also contains author affiliation (company ...), and date of last
%   revision.
%
%
%   Function code
%
%   * Please comment the code ! For algorithmic parts, as much comments as
%   code is a good start ...
%   * Indentation level should be marked by four space characters.
%
%
%   Tips & Tricks
%
%   * The use of '...' at the end of a line can cause compatibility
%   problems from Linux to Windows.
%   * matlab help uses the file 'Contents.m', not 'contents.m' !
%
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - MIA MathCell
%   created the 23/03/2005
%


%   HISTORY
%   2007-03-05 add convention for datatype prefix for function names, and
%       library organization
%   2011-01-11 update for matGeom project

help codingConventions;
