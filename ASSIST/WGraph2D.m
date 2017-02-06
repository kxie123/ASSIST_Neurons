
function [hE]= WGraph2D(adjMat,coord3,l)

%plotting the graphs 
[row1,col1,eWt1]=find(adjMat);
labels=cellstr(num2str(l'));
minEWt=min(eWt1);
maxEWt=max(eWt1);
eWtRange=maxEWt-minEWt;
% Map edge weight to edge colormap
edgeMap = jet;
neColor=size(edgeMap,1);
eWt=ceil((neColor-1)*(eWt1-minEWt)/(maxEWt-minEWt)+1);

 plot(coord3(:,1),coord3(:,2),'ko','lineWidth',1)
 hold on
 
for p = 1:length(row1)
    x=[coord3(row1(p),1),coord3(row1(p),2)]';
    y=[coord3(col1(p),1),coord3(col1(p),2)]';
    %z=[coord3(row1(p),3),coord3(col1(p),3)]';
    %hE= plot(x(:),y(:),'color',edgeMap(eWt(p),:),'lineWidth',1);
    hE = arrow(x(:),y(:));
    hold on
end


text(coord3(:,1),coord3(:,2),labels, 'Color','black','FontSize',8,'FontWeight','bold','VerticalAlignment','bottom', 'HorizontalAlignment', 'right')
   