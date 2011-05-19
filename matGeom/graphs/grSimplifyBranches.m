function varargout = grSimplifyBranches(nodes, edges)
%GRSIMPLIFYBRANCHES Replace branches of a graph by single edges
%
%   [NODES2 EDGES2] = grSimplifyBranches(NODES, EDGES)
%   renvoie une version simplifiee d'un graphe, en ne gardant que les 
%   points multiples et les aretes reliant les points multiples.
%
%   -----
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 13/08/2003.
%

%   HISTORY :
%   10/02/2004 : doc
%   17/01/2006 : uses faster method to find neighbour edges
%   18/01/2006 : replace call to subfunctions by inlining -> faster

Mnodes = [];    % size Nn*2 -> nodes coordinates
Sedges = [];    % size Ne*2 -> indices of nodes
Mpoints = [];   % size Nn*1 -> indices of Multiple points 
                %     in nodes input array

branch = [];    % size Nb*2 (variable)

Nn = 0;
Ne = 0;
Nb = 0;

% look for the first multiple point
p = 1;
while length(find(edges(:,1) == p | edges(:,2) == p)) < 3
    p = p + 1;
end

Mpoints(1) = p;
Mnodes(1, 1:2) = nodes(p, 1:2);
Nn = Nn + 1;

% add the branches of the first multiple point
neighbours = find(edges(:,1)==p | edges(:,2)==p);
for b = 1:length(neighbours)
    Nb = Nb+1;
    edge = edges(neighbours(b),:);
    if edge(1) == p
        branch(Nb, 1:2) = [p edge(2)]; %#ok<AGROW>
    else
        branch(Nb, 1:2) = [p edge(1)]; %#ok<AGROW>
    end
end

% process each branch, until there is no more branch to process.
% b is index of current branch
b = 0;
while b < length(branch)
    b = b+1;
    
    % check if the branch is valid
    if branch(b, 1) == 0
        continue;
    end
    
    % initialize iteration
    pNode = branch(b, 1);
    node = branch(b,2);
    neighbours = find(edges(:,1) == node | edges(:,2) == node);
    
%     disp(sprintf('node %3d (%03d ; %03d) -> %3d (%03d ; %03d)', ... 
%         Mnode, nodes(Mnode, 1), nodes(Mnode, 2), ...
%         node, nodes(node, 1), nodes(node, 2)));
    
    while length(neighbours) < 3
        % look for the next point on the current branch
        next = 0;
        for n = 1:length(neighbours)
            edge = edges(neighbours(n), :);
            if edge(1)~= node && edge(1)~= pNode
                next = edge(1);
                break;
            end
            if edge(2)~= node && edge(2)~= pNode
                next = edge(2);
                break;
            end
        end
        
        pNode = node;
        node = next;
        neighbours = find(edges(:,1) == node | edges(:,2) == node);
    end
    
    % node is now  the next multiple point, and pNode contains the last
    % point of the branch.
    
    % check if the multiple point has already been processed
    index = find(Mpoints==node);
    if ~isempty(index)
        % find the branch starting with node, and with pNode has
        % second point, and set it to [0 0] to avoid it to be 
        % processed again
        %disp('remove branch');
        for b2 = 1:Nb
            if branch(b2, 1) == node && branch(b2, 2) == pNode
                %disp('find branch');
                branch(b2, 1:2) = 0; %#ok<AGROW>
                break;
            end
        end
        
    else
        % add the multiple point to the list of points
        %disp('add point');
        Nn = Nn+1;
        Mnodes(Nn, 1:2) = nodes(node, 1:2); %#ok<AGROW>
        index = Nn;
        Mpoints(Nn) = node; %#ok<AGROW>
        
        % add each neighbour of the new multiple point (but not
        % the neighbour containing pNode) to the list of branches
        for n = 1:length(neighbours)
            edge = edges(neighbours(n), :);
            if edge(1) ~= pNode && edge(2) ~= pNode
                %disp('add a branch');
                Nb = Nb + 1;
                if edge(1) == node
                    branch(Nb, 1:2) = [node edge(2)]; %#ok<AGROW>
                else
                    branch(Nb, 1:2) = [node edge(1)]; %#ok<AGROW>
                end
            end
        end
    end
    
    %disp('add new Edge');
    Ne = Ne + 1;
    Sedges(Ne, 1:2) = [find(Mpoints == branch(b,1)), index]; %#ok<AGROW>
end


% process output depending on how many arguments are needed
if nargout == 1
    out{1} = Mnodes;
    out{2} = Sedges;
    varargout{1} = out;
end

if nargout == 2
    varargout{1} = Mnodes;
    varargout{2} = Sedges;
end

return;

