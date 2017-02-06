function [ tri ] = SearchTriangles( A )
%SearchTriangles: search for triangles in the graph
% inout:
%   A - adjacency matrix
% output: 
%   Tri - triangles

tri = [];
N = size(A,1);
C = diag(A^3); B = A^2;
for i = 1 : N
    if(C(i)>0)
        for j = i+1 : N
            if((A(i,j) > 0) && (B(j,i) > 0))
                t = A(i,:).*A(j,:);
                t = find(t>0);
                %remove vertices with index less than j
                commonVertices = t;
                for k = 1 : length(commonVertices)
                    if(commonVertices(k) < j) continue; end
                    tri = [tri;[i j commonVertices(k)]];
                end
            end
        end
    end
end
end

