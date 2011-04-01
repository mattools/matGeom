function average = pointSetsAverage(pointSets, varargin)
%POINTSETSAVERAGE Compute the average of several point sets
%
%   AVERAGESET = pointSetsAverage(POINTSETS)
%   POINTSETS is a cell array containing several liste of points with the
%   same number of points. The function compute the average coordinate of
%   each vertex, and return the resulting average point set.
%
%   Example
%   pointSetsAverage
%
%   See also
%   
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-04-01,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

% check input
if ~iscell(pointSets)
    error('First argument must be a cell array');
end

% number of sets
nSets   = length(pointSets);

% get reference size of coordinates array
set1    = pointSets{1};
refSize = size(set1);

% allocate memory for result
average = zeros(refSize);

% iterate on point sets
for i = 1:nSets
    % get current point set, and check its size
    set = pointSets{i};
    if sum(size(set) ~= refSize) > 0
        error('All point sets must have the same size');
    end
    
    % cumulative sum of coordinates
    average = average + set;
end

% normalize by the number of sets
average = average / nSets;
