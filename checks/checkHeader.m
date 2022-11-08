function checkHeader
%CHECKHEADER Checks the header of the m-files of matGeom.
%
%   checkHeader()
%   At the moment only the beginning of the first header line is checked
%   and corrected. Additonal checks could be added.
%
%   See also
%     codingConventions
%

% ------
% Author: oqilipo
% e-mail: N/A
% Created: 2022-11-08, using MATLAB 9.13.0.2080170 (R2022b) Update 1
% Copyright 2022

mFiles = dir('../matGeom/**/*.m');
% Exclude the Contents.m files
mFiles(strcmp({mFiles.name}','Contents.m'))=[];

for f=1:length(mFiles)
    % Full path of the m-file
    mFile = fullfile(mFiles(f).folder, mFiles(f).name);
    % Read the content of the m-file
    S = readlines(mFile);
    % File name of the m-file without the file extension
    mFileName = mFiles(f).name(1:end-2);
    % Length of the file name
    LoN = length(mFileName);
    % If the 1st or 2nd line of the file is empty the header is not valid
    if isempty(S{1}) || isempty(S{2})
        mFiles(f).validHeader = false;
        continue
    end
    
    % Assume that the header is invalid
    mFiles(f).validHeader = 0;
    % Check if the 1st header line starts with the capitalized m-file name
    if startsWith(S{1}, 'function')
        H1_Idx = 2;
    else
        H1_Idx = 1;
    end
    mFiles(f).validHeader = strcmp(S{H1_Idx}(1:2+LoN),['%' upper(mFileName) ' ']);
    % Try to correct the beginning of the 1st header line
    if ~mFiles(f).validHeader
        if startsWith(S{H1_Idx}, '% ') && regexp(S{H1_Idx}, '% ') == 1
            S{H1_Idx} = strrep(S{H1_Idx}, '% ', ['%' upper(mFileName) ' ']);
            writelines(S, mFile);
            mFiles(f).validHeader = true;
        end
    end
end

% Display remaining invalid files
mFileNames = {mFiles.name}';
validHeaders = {mFiles.validHeader}';
invalidFiles = mFileNames(cellfun(@(x) ~isempty(x) && x==0,validHeaders));
if isempty(invalidFiles)
    invalidFiles='none';
end
disp('Files with invalid beginning of the 1st header line:')
disp(invalidFiles)
