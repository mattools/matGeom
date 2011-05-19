function varargout = patchGraph(nodes, edges, faces) %#ok<INUSL>
%PATCHGRAPH Transform 3D graph (mesh) into a patch handle
%
%   [PX, PY, PZ] = PATCHGRAPH(NODES, EDGES, FACES)
%   Transform the graph defined as a set of nodes, edges and faces in a
%   patch which can be drawn usind matlab function 'patch'.
%   The result is a set of 3 array of size [NV*NF], with NV being the
%   number of vertices per face, and NF being the total number of faces.
%   each array contains one coordinate of vertices of each patch.
%
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 28/06/2004.
%

if iscell(faces)
    p = zeros(length(faces), 1);
    for i = 1:length(faces)
        p(i) = patch( ...
            'Faces', faces{i}, ...
            'Vertices', nodes, ...
            'FaceColor', 'r', ...
            'EdgeColor', 'none') ;
    end    
else    
    p = patch( ...
        'Faces', faces, ...
        'Vertices', nodes, ...
        'FaceColor', 'r', ...
        'EdgeColor', 'none') ;
end

if nargout>0
    varargout{1}=p;
end
