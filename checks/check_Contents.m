function check_Contents()
%CHECK_CONTENTS checks the Contents.m files of matGeom.
%
%   check_Contents()
%   Checks if all m-files are listed in the Contents.m
%
%   See also 
%       Contents
%

% ------
% Author: oqilipo
% E-mail: N/A
% Created: 2023-10-27, using MATLAB 9.13.0.2080170 (R2022b) Update 1
% Copyright 2023

cd(strrep(mfilename('fullpath'),mfilename,''))

cFileName = 'Contents.m';
cFiles = dir(['../matGeom/**/' cFileName]);
cFiles(endsWith({cFiles.folder}', 'matGeom')) = [];

for c=1:length(cFiles)
    cFolder = cFiles(c).folder;

    mFiles = dir([cFolder '\*.m']);
    mFiles(contains({mFiles.name}', cFileName)) = [];
    mFileNames = {mFiles.name}';

    cFile = fullfile(cFolder, cFileName);
    % Read the Contents.m
    C = readlines(cFile);
    
    % Find the m-file in Contents.m
    isInC = cell(length(mFiles),1);
    for f=1:length(mFiles)
        isInC{f,1} = find(contains(C,['%   ' erase(mFileNames{f}, '.m') ' ']));
        if length(isInC{f,1})>1
            disp([mFileNames{f} ' appears more then once in ' ...
                fullfile(cFolder, cFiles(c).name)])
        end
    end
    
    disp(['Missing in ' fullfile(cFolder, cFiles(c).name) ':'])
    mFIdx = cellfun(@isempty, isInC);
    if any(mFIdx)
        disp(mFileNames(mFIdx))
    else
        disp({'none'})
    end
    clearvars isInC
end