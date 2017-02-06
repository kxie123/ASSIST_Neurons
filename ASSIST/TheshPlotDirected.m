%Thresholding / plot generation code
d=1.35;
run('thresholdDirMat.m');
run('neuPos.m'); %this is also on my drive
s=8; %change this value from 1-12 (denoting individual segment)

thresh=1/d; %change the denominator to change threshold (value between 1-2)




ADJI = zeros(105);


%this procedure makes the matrix symmetric by choosing the greatest value

for i = 1:105
    for j = 1:105
        if (ADJArt{s,1}(i,j)>thresh)
            ADJI(i,j)=ADJArt{s,1}(i,j);
        end
    end
end
ADJUT = triu(ADJI);
ADJLT = tril(ADJI)';

ADJHalf = zeros(105);

for i = 1:105
    for j = 1:105
        if (ADJUT(i,j) > ADJLT(i,j))
            ADJLT(i,j)=0;
        end
        if (ADJLT(i,j) > ADJUT(i,j))
            ADJUT(i,j)=0;
        end
    end
end

ADJDir = ADJUT+ADJLT; %final symmetric matrix



st=1; %start neuron
f=105; %end neuron

neuronzoom = neuronCenter(st:f,[2 1]);
ADJ10zoom = ADJDir(st:f,st:f);
% 
% D=digraph(ADJDir,cellstr(num2str([1:105]')));
% plot(D);


hfig= figure(1);
set(hfig,'Position',[100 100 700 650]);
WGraph2D(ADJ10zoom,neuronzoom,[st:f]);

title('threshold alpha < 1.27'); %change title corresponding to your threshold and segment
xlabel('Distance in \mum');
ylabel('Distance in \mum');

hold on

indShift=0; %this should only be modified if your start neuron above is not 1



transmatrix = zeros(105);

for i=1:105
    for j = 1:105
        if(ADJbinary{s,1}(i,j)==1)
            for k=1:105
                if (ADJbinary{s,1}(j,k)==1)
                    if (ADJbinary{s,1}(i,k)==1)
                        transmatrix(i,j)=1;
                        transmatrix(i,k)=1;
                        transmatrix(j,i)=1;
                        transmatrix(j,k)=1;
                        transmatrix(k,i)=1;
                        transmatrix(k,j)=1;
                    end
                end
            end
        end
    end
end
                        
                 
tri=SearchTriangles(transmatrix)+indShift;

for i=1:length(tri(:,1))
    h=fill(neuronCenter(tri(i,:),2), neuronCenter(tri(i,:),1),'green');
    set(h,'facealpha',.1);
end



% 
% 
% 
% % %%%Zoom in
% % %This is optional code to modify. Change s and f if you want to plot only a
% % %specfic range of neurons. Otherwies, leave s and f at 1 and 105 to plot
% % %all neurons.
% % 
% % s=1; %start neuron
% % f=105; %end neuron
% % 
% % neuronzoom = neuronCenter(s:f,[2 1]);
% % ADJ10zoom = ADJSym(s:f,s:f);
% % hfig= figure(1);
% % set(hfig,'Position',[100 100 700 650]);
% % WGraph2D(ADJ10zoom,neuronzoom,[s:f]);
% % 
% % title('threshold alpha < 1.27'); %change title corresponding to your threshold and segment
% % xlabel('Distance in \mum');
% % ylabel('Distance in \mum');
% % 
% % hold on
% % 
% % indShift=0; %this should only be modified if your start neuron above is not 1
% % tri=SearchTriangles(ADJ10zoom)+indShift;
% % 
% % for i=1:length(tri(:,1))
% %     h=fill(neuronCenter(tri(i,:),2), neuronCenter(tri(i,:),1),'green');
% %     set(h,'facealpha',.1);
% % end
% 
