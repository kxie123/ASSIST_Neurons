% plot A.mat matrix as a flag complex

load('A.mat');
[m,n] = size(A);
sprintf('Size of A: %d*%d', m,n)

% create adj matrix, it has to be a squre matrix
adj = A'*A;
adj = adj - diag(diag(adj));  
adj = adj./repmat(max(adj)- min(adj),n, 1); 

% threshold adjacency matrix
adj(adj<0.5) = 0; 
figure, spy(adj)

% choose graph plot mode: "force", "layered", "subspace", "auto", "circle"
% source: http://www.mathworks.com/help/matlab/ref/graph.plot.layout.html
% G = graph(A) creates a weighted graph using a square, symmetric adjacency matrix, A. 
% The location of each nonzero entry in A specifies an edge for the graph, 
% and the weight of the edge is equal to the value of the entry. 
% For example, if A(2,1) = 10, then G contains an edge between node 2 and node 1 with a weight of 10.

G = graph(adj+adj');
% Use a rescaled version of the edge weights to determine the width of each edge, such that the widest line has a width of 5.
LWidths = 5*G.Edges.Weight/max(G.Edges.Weight);

nlabels = {};
for i=1:n
    nlabels{i} = num2str(i); 
end
figure , graph_plot = plot( G, 'NodeLabel',nlabels, 'LineWidth',LWidths, 'LayOut', 'force'); 
%figure , graph_plot = plot( G,'EdgeLabel',G.Edges.Weight, 'LayOut', 'force','LineWidth',LWidths); 
%figure , graph_plot = plot( G,'EdgeLabel',G.Edges.Weight, 'LayOut', 'force','LineWidth',LWidths); 

title(sprintf('Size of adj: %d', n));

% fill in 2 simplex
hold on
% find triangles in the graph
tri = SearchTriangles(adj);
V = [graph_plot.XData; graph_plot.YData];
trisurf(tri, V(1,:), V(2,:), zeros(n,1), 'facealpha','0.1');
sprintf('Original graph: Triangle colored.')


%% plot figure with different color
%  The colors begin with dark blue, range through shades of
% blue, cyan, green, yellow and red, and end with dark red.
% WGraph2D(adj,V');





