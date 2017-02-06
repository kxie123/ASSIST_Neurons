
function [hE]= WGraph3D(adjMat,coord3)

%plotting the graphs 
[row1,col1,eWt1]=find(adjMat);
labels=cellstr(num2str([1:19]'));
minEWt=min(eWt1);
maxEWt=max(eWt1);
eWtRange=maxEWt-minEWt;
% Map edge weight to edge colormap
edgeMap = jet;
neColor=size(edgeMap,1);
eWt=ceil((neColor-1)*(eWt1-minEWt)/(maxEWt-minEWt)+1);

figure
 plot3(coord3(:,1),coord3(:,2),coord3(:,3),'ko','lineWidth',2)
 hold on
 
 for p = 1:length(row1)
    x=[coord3(row1(p),1),coord3(col1(p),1)]';
    y=[coord3(row1(p),2),coord3(col1(p),2)]';
    z=[coord3(row1(p),3),coord3(col1(p),3)]';
    hE= plot3(x(:),y(:),z(:),'color',edgeMap(eWt(p),:),'lineWidth',2);
    hold on
end
 text(coord3(:,1),coord3(:,2),coord3(:,3),labels, 'Color','red','FontSize',8,'FontWeight','bold','VerticalAlignment','bottom', 'HorizontalAlignment', 'right')
   
