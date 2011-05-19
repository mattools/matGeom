function [nodes, edges] = gcontour2d(img)
%GCONTOUR2D Creates contour graph of a 2D binary image.
%
%
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 25/06/2004.
%

nodes = zeros([0 2]);
edges = zeros([0 2]);

D1 = size(img, 1);
D2 = size(img, 2);

% first direction for image
for i=1:D1
    
    % find transitions between the two phases
    ind = find(img(i, 1:D2-1)~=img(i, 2:D2));
    
    % process each transition in direction 1
    for i2 = 1:length(ind)
        
        n1 = [i-.5 ind(i2)+.5];
        n2 = [i+.5 ind(i2)+.5];
        
        ind1 = find(ismember(nodes, n1, 'rows'));       
        ind2 = find(ismember(nodes, n2, 'rows'));
        if isempty(ind1)
            nodes = [nodes; n1];
            ind1 = size(nodes, 1);
        end
        if isempty(ind2)
            nodes = [nodes; n2];
            ind2 = size(nodes, 1);
        end
        
        edges(size(edges, 1)+1, 1:2) = [ind1(1) ind2(1)];
        
    end
end


% second direction for image
for i=1:D2
    
    % find transitions between the two phases
    ind = find(img(1:D1-1, i)~=img(2:D1, i));
    
    % process each transition in direction 1
    for i2 = 1:length(ind)
        
        n1 = [ind(i2)+.5 i-.5];
        n2 = [ind(i2)+.5 i+.5];
        
        ind1 = find(ismember(nodes, n1, 'rows'));       
        ind2 = find(ismember(nodes, n2, 'rows'));
        if isempty(ind1)
            nodes = [nodes; n1];
            ind1 = size(nodes, 1);
        end
        if isempty(ind2)
            nodes = [nodes; n2];
            ind2 = size(nodes, 1);
        end
        
        edges(size(edges, 1)+1, 1:2) = [ind1(1) ind2(1)];
        
    end
end

