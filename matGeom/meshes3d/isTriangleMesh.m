function ITM = isTriangleMesh(v,f)
%ISTRIANGLEMESH checks if input is a triangle mesh

ITM = true;
try
    if isstruct(v)
        assert(all(ismember(fieldnames(v),{'vertices','faces'})))
        [v, f] = parseMeshData(v);
    end
    validateattributes(v, {'numeric'}, {'ncols',3,'real','finite','nonnan'})
    validateattributes(f, {'numeric'}, {'ncols',3,'integer','>',0,'<=',size(v,1)})
catch
    ITM = false;
end

end