clearvars; close all; clc; %function checkHeader
%CHECKHEADER Checks the header of the m-files of matGeom.
%
%   checkHeader()
%   At the moment only the beginning of the first header line is checked
%   and corrected. Additional checks could be added.
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
    % Make a backup of S
    S_BU = S;
    % File name of the m-file without the file extension
    mFileName = mFiles(f).name(1:end-2);
    % Length of the file name
    LoN = length(mFileName);

    % Assume that the header is invalid
    mFiles(f).validHeader = false;

    % If the 1st or 2nd line of the file is empty the header is not valid
    if isempty(S{1}) || isempty(S{2})
        continue
    end

    % Check if the 1st header line starts with the capitalized m-file name
    if startsWith(S{1}, 'function')
        H1_Idx = 2;
    else
        H1_Idx = 1;
    end
    % Try to correct the beginning of the 1st header line
    if ~strcmp(S{H1_Idx}(1:2+LoN),['%' upper(mFileName) ' '])
        if startsWith(S{H1_Idx}, '% ') && regexp(S{H1_Idx}, '% ') == 1
            S{H1_Idx} = strrep(S{H1_Idx}, '% ', ['%' upper(mFileName) ' ']);
        end
    end
    
    %% First line of the header's author section
    % Find the 1st line of the header's author section
    aSec1Idx = find(contains(S,'-----'));
    if isempty(aSec1Idx)
        continue
    elseif length(aSec1Idx) ~= 1
        continue
    end
    
    if ~strcmp(S(aSec1Idx),'% ------')
        % Remove more than six "-" 
        S(aSec1Idx) = regexprep(S(aSec1Idx),'% *-----+','% ------');
    end
    
    if regexp(S(aSec1Idx+1), '^% *$') == 1
        S(aSec1Idx+1) = [];
    end
    
    %% "Author" line
    % Fix the beginning of the author line
    if contains(S(aSec1Idx+1),'author') && ~contains(S(aSec1Idx+1),'Author')
        S(aSec1Idx+1) = regexprep(S(aSec1Idx+1),'% +author *:','% Author:');
        S(aSec1Idx+1) = regexprep(S(aSec1Idx+1),'% +authors *:','% Authors:');
    elseif contains(S(aSec1Idx+1),'  Author') && ~startsWith(S(aSec1Idx+1), '% Author')
        S(aSec1Idx+1) = regexprep(S(aSec1Idx+1),'% +','% ');
    end

    %% "E-mail" line
    if ~contains(S(aSec1Idx+2),'mail','IgnoreCase',1)
        if contains(S(aSec1Idx+2),'created','IgnoreCase',1)
            if contains(S(aSec1Idx+1),'David Legland')
                S = [S(1:aSec1Idx+1); "% e-mail: david.legland@inrae.fr"; S(aSec1Idx+2:end)];
            else
                S = [S(1:aSec1Idx+1); "% e-mail: N/A"; S(aSec1Idx+2:end)];
            end
        elseif contains(S(aSec1Idx+3),'created','IgnoreCase',1)
            coIdx = regexp(S(aSec1Idx+2), 'INRA');
            if any(coIdx)
                % Extract the year of creation for the copyright
                creationYear = regexp(S(aSec1Idx+3), '20\d\d','match');
                if isempty(creationYear); continue; end
                if regexp(S(aSec1Idx+4), '^% *$') == 1
                        S(aSec1Idx+4) = regexprep(S(aSec1Idx+2),'% +INRA','% Copyright ' + creationYear + ' INRA');
                elseif isempty(S{aSec1Idx+4})
                    S(aSec1Idx+4) = "% Copyright " + creationYear + " " + S{aSec1Idx+2}(coIdx:end);
                    S = [S(1:aSec1Idx+4); ''; S(aSec1Idx+5:end)];
                else
                    continue
                end
                if contains(S(aSec1Idx+1),'David Legland')
                    S(aSec1Idx+2) = "% e-mail: david.legland@inrae.fr";
                else
                    S(aSec1Idx+2) = "% e-mail: N/A";
                end
            else
                continue
            end
        end
    end
    
    % Move affiliation to the copyright line if necesarry
    if contains(S(aSec1Idx+3),'INRA') && contains(S(aSec1Idx+4),'created','IgnoreCase',1)
        coIdx = regexp(S(aSec1Idx+3), 'INRA');
        if contains(S(aSec1Idx+5), 'Copyright')
            S(aSec1Idx+5) = regexprep(S(aSec1Idx+5),'INRA.*',S{aSec1Idx+3}(coIdx:end));
            S(aSec1Idx+3) = [];
        elseif regexp(S(aSec1Idx+5), '^% *$') == 1
            creationYear = regexp(S(aSec1Idx+4), '20\d\d','match');
            if ~isempty(creationYear)
                S(aSec1Idx+5) = "% Copyright " + creationYear + " " + S{aSec1Idx+3}(coIdx:end);
                S(aSec1Idx+3) = [];
            else
                continue
            end
        end
    end

    %% "Created" line
    if contains(S(aSec1Idx+3),'created the') && ~contains(S(aSec1Idx+3),'Created')
        S(aSec1Idx+3) = regexprep(S(aSec1Idx+3),'% +created the +','% Created: ');
    elseif contains(S(aSec1Idx+3),'created')
        S(aSec1Idx+3) = regexprep(S(aSec1Idx+3),'% +created +','% Created: ');
    elseif contains(S(aSec1Idx+3),'  Created') && ~startsWith(S(aSec1Idx+3), '% Created')
        S(aSec1Idx+3) = regexprep(S(aSec1Idx+3),'% +','% ');
    elseif contains(S(aSec1Idx+3),' created:')
        S(aSec1Idx+3) = regexprep(S(aSec1Idx+3),'% +created:','% Created:');
    end

    % Standardize creation date
    dateIdxS = regexp(S(aSec1Idx+3),'% Created: ','end') + 1;
    if any(dateIdxS) && length(dateIdxS) == 1
        dateIdxE = regexp(S(aSec1Idx+3), '( from|, +using|\.$)') - 1;
        if isempty(dateIdxE)
            dateIdxE = length(S{aSec1Idx+3});
            if length(S{aSec1Idx+3}(dateIdxS:dateIdxE)) >= 10
                if regexp(S{aSec1Idx+3}(dateIdxS:dateIdxS+9),'\d\d\/\d\d\/\d{4}') == 1
                    dateStr = string(datetime(S{aSec1Idx+3}(dateIdxS:dateIdxE),...
                        'InputFormat','dd/MM/uuuu','format','uuuu-MM-dd'));
                else
                    dateStr = string(datetime(S{aSec1Idx+3}(dateIdxS:dateIdxE),'format','uuuu-MM-dd'));
                end
                S(aSec1Idx+3) = "% Created: " + dateStr;
            end
        else
            if length(dateIdxE)~=1; dateIdxE = dateIdxE(1); end
            if length(S{aSec1Idx+3}(dateIdxS:dateIdxE)) >= 10
                if regexp(S{aSec1Idx+3}(dateIdxS:dateIdxS+9),'\d\d\/\d\d\/\d{4}') == 1
                    dateStr = string(datetime(S{aSec1Idx+3}(dateIdxS:dateIdxE),...
                        'InputFormat','dd/MM/uuuu','format','uuuu-MM-dd'));
                else
                    dateStr = string(datetime(S{aSec1Idx+3}(dateIdxS:dateIdxE),'format','uuuu-MM-dd'));
                end
                S(aSec1Idx+3) = "% Created: " + dateStr + S{aSec1Idx+3}(dateIdxE+1:end);
            end
        end
    end

    %% "Copyright" line
    % Extract the year of creation for the copyright
    creationYear = regexp(S(aSec1Idx+3), '20\d\d','match');
    if isempty(S{aSec1Idx+4}) && ~isempty(creationYear)
        S = [S(1:aSec1Idx+3); "% Copyright " + creationYear; S(aSec1Idx+4:end)];
    elseif regexp(S(aSec1Idx+4), '^% *$') == 1
        S(aSec1Idx+4) = "% Copyright " + creationYear;
    end
    
    %% General checks
    containsHeaderWords = arrayfun(@(x,y) contains(x,y), ...
        S(aSec1Idx:aSec1Idx+4), ["% ------"; "Author"; "e-mail"; "Created"; "Copyright"]);
    if ~all(containsHeaderWords)
        continue
    end
    if any(contains(S(aSec1Idx:aSec1Idx+4), '%  '))
        % Remove leading spaces before the header words
        S(aSec1Idx:aSec1Idx+4) = arrayfun(@(x) regexprep(x,'% +','% '), S(aSec1Idx:aSec1Idx+4));
    end
    
    aSecLIs = [...
        startsWith(S(aSec1Idx-2), '%') ...
        isempty(S{aSec1Idx-1}) ...
        startsWith(S(aSec1Idx+1), '% Author') ...
        startsWith(S(aSec1Idx+2), '% e-mail: ') ...
        startsWith(S(aSec1Idx+3), '% Created: ')...
        startsWith(S(aSec1Idx+4), '% Copyright ')...
        isempty(S{aSec1Idx+5}) ...
        ];
    if all(aSecLIs)
        mFiles(f).validHeader = true;
    elseif all(aSecLIs == [1 0 1 1 1 1 1])
        S(aSec1Idx-1) = '';
        saveHeader = 1;
    elseif all(aSecLIs == [0 0 1 1 1 1 1])
        if isempty(S{aSec1Idx-2})
            S(aSec1Idx-2) = '%';
            S(aSec1Idx-1) = '';
        end
    elseif all(aSecLIs == [1 0 1 1 1 1 0])
        if regexp(S(aSec1Idx+5), '^% *$') == 1
            S([aSec1Idx-1, aSec1Idx+5]) = '';
        end
    else
        continue
    end
    
    if aSec1Idx+6 < length(S)
        while isempty(S{aSec1Idx+6})
            S(aSec1Idx+6) = [];
        end
    end
    
    if ~isequal(S, S_BU)
        writelines(S, mFile);
    end
end

% Display remaining invalid files
mFileNames = {mFiles.name}';
validHeaders = {mFiles.validHeader}';
invalidFiles = mFileNames(cellfun(@(x) ~isempty(x) && x==0,validHeaders));
NoIF = length(invalidFiles);
if isempty(invalidFiles)
    invalidFiles='none';
end
disp([num2str(NoIF) ' files with invalid header:'])
disp(invalidFiles)