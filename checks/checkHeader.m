function checkHeader
%CHECKHEADER checks the header of the m-files of matGeom.
%
%   checkHeader()
%   Checks and corrects:
%   - the beginning of the first header line 
%   - the "author" section is checked and corrected
%   - the "see also" section
%   Looks for:
%   - to-dos
%   Removes:
%   - the "history" section
%   Additional checks could be added.
%   
%   Todo
%       - Standardize E-mail adress to "david.legland@inrae.fr"?
%       - Add additional checks for the "See also" section: No
%       self-reference, references, indentations of the references.
%
%   See also 
%       codingConventions
%

% ------
% Author: oqilipo
% E-mail: N/A
% Created: 2022-11-08, using MATLAB 9.13.0.2080170 (R2022b) Update 1
% Copyright 2022

mFiles = dir('../matGeom/**/*.m');
% Exclude the Contents.m files
% mFiles(strcmp({mFiles.name}','Contents.m'))=[];

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
    
    %% First header line
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

    if ~endsWith(S(H1_Idx), '.')
        S(H1_Idx) = S{H1_Idx} + ".";
    end
    
    %% AUTHOR section
    % First line of the header's author section
    % Find the 1st line of the header's author section
    aSec1Idx = find(contains(S,'-----'));
    if isempty(aSec1Idx)
        continue
    elseif length(aSec1Idx) ~= 1
        display(['No line contains or multiple lines contain: ''-----'' in: ' mFileName])
        continue
    end
    
    if ~strcmp(S(aSec1Idx),'% ------')
        % Remove more than six "-" 
        S(aSec1Idx) = regexprep(S(aSec1Idx),'% *-----+','% ------');
    end
    
    if regexp(S(aSec1Idx+1), '^% *$') == 1
        S(aSec1Idx+1) = [];
    end
    
    % "Author" line
    % Fix the beginning of the author line
    if contains(S(aSec1Idx+1),'author') && ~contains(S(aSec1Idx+1),'Author')
        S(aSec1Idx+1) = regexprep(S(aSec1Idx+1),'% +author *:','% Author:');
        S(aSec1Idx+1) = regexprep(S(aSec1Idx+1),'% +authors *:','% Authors:');
    elseif contains(S(aSec1Idx+1),'  Author') && ~startsWith(S(aSec1Idx+1), '% Author')
        S(aSec1Idx+1) = regexprep(S(aSec1Idx+1),'% +','% ');
    end

    % "E-mail" line
    if ~contains(S(aSec1Idx+2),'mail','IgnoreCase',1)
        if contains(S(aSec1Idx+2),'created','IgnoreCase',1)
            if contains(S(aSec1Idx+1),'David Legland')
                S = [S(1:aSec1Idx+1); "% E-mail: david.legland@inrae.fr"; S(aSec1Idx+2:end)];
            else
                S = [S(1:aSec1Idx+1); "% E-mail: N/A"; S(aSec1Idx+2:end)];
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
                    S(aSec1Idx+2) = "% E-mail: david.legland@inrae.fr";
                else
                    S(aSec1Idx+2) = "% E-mail: N/A";
                end
            else
                continue
            end
        end
    end
    % Change e-mail to E-Mail
    S(aSec1Idx+2) = regexprep(S(aSec1Idx+2), '% e-mail:', '% E-mail:');
    
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
        elseif isempty(S{aSec1Idx+5})
            creationYear = regexp(S(aSec1Idx+4), '20\d\d','match');
            if ~isempty(creationYear)
                S(aSec1Idx+5) = "% Copyright " + creationYear + " " + S{aSec1Idx+3}(coIdx:end);
                S = [S(1:aSec1Idx+5); ''; S(aSec1Idx+6:end)];
                S(aSec1Idx+3) = [];
            else
                continue
            end
        end
    end

    % "Created" line
    if contains(S(aSec1Idx+3),'created the') && ~contains(S(aSec1Idx+3),'Created')
        S(aSec1Idx+3) = regexprep(S(aSec1Idx+3),'% +created the +','% Created: ');
    elseif contains(S(aSec1Idx+3),'created ')
        S(aSec1Idx+3) = regexprep(S(aSec1Idx+3),'% +created +','% Created: ');
    elseif contains(S(aSec1Idx+3),'  Created') && ~startsWith(S(aSec1Idx+3), '% Created')
        S(aSec1Idx+3) = regexprep(S(aSec1Idx+3),'% +','% ');
    elseif contains(S(aSec1Idx+3),' created:')
        S(aSec1Idx+3) = regexprep(S(aSec1Idx+3),'% +created:','% Created:');
    end

    % Standardize creation date
    dateIdxS = regexp(S(aSec1Idx+3),'% Created: ','end') + 1;
    if any(dateIdxS) && length(dateIdxS) == 1
        dateIdxE = regexp(S(aSec1Idx+3), '( by | from|, by |, from|, +using|\.$)') - 1;
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

    % "Copyright" line
    % Extract the year of creation for the copyright
    creationYear = regexp(S(aSec1Idx+3), '20\d\d','match');
    if ~isempty(creationYear)
        creationYear = creationYear(1);
    else
        continue
    end
    if isempty(S{aSec1Idx+4})
        S = [S(1:aSec1Idx+3); "% Copyright " + creationYear; S(aSec1Idx+4:end)];
    elseif regexp(S(aSec1Idx+4), '^% *$') == 1
        S(aSec1Idx+4) = "% Copyright " + creationYear;
    end

    % Add current year to the copyright or change it to the current year
    copyrightSYear = regexp(S(aSec1Idx+4), '20\d\d','match');
    copyrightSYear = copyrightSYear{1};
    % Created year and copyright year should be the same
    if ~isequal(copyrightSYear,creationYear{1})
        display(['Creation and copyright year are inconsistent in: ' mFileName])
        continue
    end
    currentYear = char(datetime('today','Format','yyyy'));
    if regexp(S(aSec1Idx+4), '% Copyright 20\d\d( |$)') == 1
        if ~isequal(copyrightSYear, currentYear)
            S(aSec1Idx+4) = regexprep(S(aSec1Idx+4), '% Copyright 20\d\d', ...
                ['% Copyright ' copyrightSYear '-' currentYear]);
        end
    elseif regexp(S(aSec1Idx+4), '% Copyright 20\d\d-20\d\d( |$)') == 1
        copyrightEYear = S{aSec1Idx+4}(18:21);
        if ~isequal(copyrightEYear, currentYear)
            S(aSec1Idx+4) = regexprep(S(aSec1Idx+4), '% Copyright 20\d\d-20\d\d', ...
                ['% Copyright ' copyrightSYear '-' currentYear]);
        end
    else 
        continue
    end
    
    % General checks
    containsHeaderWords = arrayfun(@(x,y) contains(x,y), ...
        S(aSec1Idx:aSec1Idx+4), ["% ------"; "Author"; "E-mail"; "Created"; "Copyright"]);
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
        startsWith(S(aSec1Idx+2), '% E-mail: ') ...
        startsWith(S(aSec1Idx+3), '% Created: ')...
        startsWith(S(aSec1Idx+4), '% Copyright ')...
        isempty(S{aSec1Idx+5}) ...
        ];
    if all(aSecLIs)
        mFiles(f).validHeader = true;
    elseif all(aSecLIs == [1 0 1 1 1 1 1])
        S(aSec1Idx-1) = '';
    elseif all(aSecLIs == [0 0 1 1 1 1 1])
        if isempty(S{aSec1Idx-2})
            S(aSec1Idx-2) = '%';
            S(aSec1Idx-1) = '';
        end
    elseif all(aSecLIs == [1 0 1 1 1 1 0]) || all(aSecLIs == [1 1 1 1 1 1 0])
        if regexp(S(aSec1Idx+5), '^% *$') == 1
            S([aSec1Idx-1, aSec1Idx+5]) = '';
        end
    else
        continue
    end

    % No dot after creation date
    if regexp(S(aSec1Idx+3), '% Created: 20\d\d\-\d\d\-\d\d\.','start') == 1
        S(aSec1Idx+3) = regexprep(S(aSec1Idx+3),'\. *$','');
    end
    % Remove multiple spaces after creation date
    S(aSec1Idx+3) = regexprep(S(aSec1Idx+3),' +',' ');
    % If text follows the creation date seperate it by a comma
    if regexp(S(aSec1Idx+3), '% Created: 20\d\d\-\d\d\-\d\d\ .','start') == 1
        S(aSec1Idx+3) = [S{aSec1Idx+3}(1:21) ',' S{aSec1Idx+3}(22:end)];
    end
    % Remove dots at the end of the Created and Copyright line
    if endsWith(S(aSec1Idx+3), '.')
        S(aSec1Idx+3) = S{aSec1Idx+3}(1:end-1);
    end
    if endsWith(S(aSec1Idx+4), '.')
        S(aSec1Idx+4) = S{aSec1Idx+4}(1:end-1);
    end
    
    if aSec1Idx+6 < length(S)
        while isempty(S{aSec1Idx+6})
            S(aSec1Idx+6) = [];
        end
    end

    %% SEE ALSO section
    if ~isempty(cell2mat(regexp(lower(S), '^% *see also')))
        saSIdx = find(contains(lower(S),'see also'));
        if length(saSIdx) ~=1
            display(['Multiple ''See also'' lines found in: ' mFileName])
            continue
        end
        S(saSIdx) = regexprep(S(saSIdx), '^% *[sS]ee [aA]lso *:* *', '%   See also ');
    end

    %% HISTORY section
    if ~isempty(cell2mat(regexp(lower(S), '^% *history')))
        histSIdx = find(contains(lower(S),'history'));
        if length(histSIdx) ~=1
            display(['Multiple ''History'' sections found in: ' mFileName])
            continue
        end
        histLines = 1;
        while startsWith(S(histSIdx+histLines),'% ')
            histLines = histLines+1;
        end
        S(histSIdx:histSIdx+histLines-1) = [];
    end
    if ~isempty(cell2mat(regexp(S([1:aSec1Idx,aSec1Idx+5:end]), '^%.*20\d\d.')))
        display(['Suspicous date found in: ' mFileName])
        continue
    end

    %% TODO section
    % There should not be a to-do section. To-dos should be adressed using
    % GitHub Issues.
    if ~isempty(cell2mat(regexp(lower(S), '^%.*(todo|to-do)')))
        display(['''To-do(s)'' found in: ' mFileName])
    end

    %% Save file if changes were performed
    if ~isequal(S, S_BU)
        writelines(S, mFile);
    end
end

% Display remaining invalid files
mFileNames = {mFiles.name}';
validHeaders = {mFiles.validHeader}';
invalidFilesIdx = cellfun(@(x) ~isempty(x) && x==0, validHeaders);
invalidFiles = mFileNames(invalidFilesIdx);
NoIF = length(invalidFiles);
if isempty(invalidFiles)
    invalidFiles='none';
end
disp([num2str(NoIF) ' files with invalid header:'])
disp([num2cell(find(invalidFilesIdx)), invalidFiles])
