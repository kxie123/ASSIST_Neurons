load('dataset.mat');
load('roilocation.mat');
load('ADJArt10.mat');
syncarray=table2array(synctable);
data_array=[syncarray trace];
S = cell(20,10);
stimframe = data_array(:,2);
for i=1:20
    for j=1:12
        temp1 = find(stimframe==((j-1)*240+7200*(i-1)) | stimframe==((j-1)*240+7200*(i-1))+1 | stimframe==((j-1)*240+7200*(i-1))+2);
        if  (i==1 && j==1)
            start = temp1(end);
        elseif(mod(stimframe(temp1(1)),240)~=0)
            start= temp1(end);
        else
                
            start = temp1(1)+1;
        end
        temp2 = find(stimframe==(j*240+7200*(i-1)) | stimframe==(j*240+7200*(i-1))-1 | stimframe==(j*240+7200*(i-1))-2);
        if(mod(stimframe(temp2(1)),240)~=0)
            finish= temp2(end);
        else
            finish = temp2(1);
        end 
        S{i,j}=data_array(start:finish,:);
    end
end

control = data_array(1:147,:);
grey1 = S(:,1);
grey1_2 = S(:,2);
horz_BT = S(:,3);
diag_TRBL = S(:,4);
vert_LR = S(:,5);
diag_BRTL = S(:,6);
horz_TB = S(:,7);
diag_BLTR = S(:,8);
vert_RL = S(:,9);
diag_TLBR = S(:,10);
grey2 = S(:,11);
grey2_2 = S(:,12);

horz_BT_corr = zeros(105);

for i=4:108
    for j=4:108
       temp = corrcoef(vert_LR{1,1}(:,i),vert_LR{1,1}(1:100,j));
       horz_BT_corr(i-3,j-3) = temp(1,2);
    end
end

horz_BT_corr(1:106:end)=diag(1);
[r,c] = find((horz_BT_corr>0.5 | horz_BT_corr<-0.5) & horz_BT_corr~=1);
horz_BT_sig = [r,c,horz_BT_corr((horz_BT_corr>0.5 | horz_BT_corr<-0.5) & horz_BT_corr~=1)];

% figure;
% (plot(horz_BT{1}(:,4:end)));
% 
% m=mean(mean(horz_BT{1}(:,4:end)));
% two_std=2*std(mean(horz_BT{1}(:,4:end)));
% legend_names={};
% figure;
% hold on;

% j=1;
% for i=4:length(horz_BT{1}(1,:))
%     if (mean(horz_BT{1}(:,i))>(m+two_std)|| mean(horz_BT{1}(:,i))<(m-two_std))
%         plot(horz_BT{1}(:,i));
%         legend_names{j}=num2str(i-3);
%         j=j+1;
%     end
% end

% hold off;
% legend(legend_names{:});    

temp = zeros(20,1);
trial_means=cell(12,1);
trial_means(:)={zeros(99,105)};
for j = 1:12
    for l=4:108
        for k=1:99
            for i=1:20
                temp(i)= S{i,j}(k,l);
            end
            trial_means{j}(k,l-3)=mean(temp);
        end
    end
end

segments = cell(20,12);


for i = 1:12
    for j = 1:20
%         segments{j,i} = zeros(99,105);
%         for k=1:99
%         segments{j,i}(k,:)= S{j,i}(k,:);
         segments{j,i}=S{j,i}(1:99,4:105);

    end
end


segmeans = zeros(12,1);

for i = 1:12
    segmeans(i)=(mean(mean(trial_means{i})));
end


%%Connectivity Analysis

% adj10ext1 = ADJArt10([75 67 46 73 2 23 104 105],[75 67 46 73 2 23 104 105]);
% adj10ext1Pos = neuronCenter([75 67 46 73 2 23 104 105],:);
% adj10ext1Label = [75 67 46 73 2 23 104 105];
% 
% adj10ext2 = ADJArt10([76 12 48 9 51 27 89 24],[76 12 48 9 51 27 89 24]);
% adj10ext2Pos = neuronCenter([76 12 48 9 51 27 89 24],:);
% adj10ext2Label = [76 12 48 9 51 27 89 24];
%     

% m=zeros(12,1);
% two_std=zeros(12,1);




% m=mean(mean(trial_means{i}));
% two_std=2*std(mean(trial_means{i}));
% 
% legend_names=cell(12,50);
% figure;
% hold on;
% 
% j=1;
% for k=1:12
%     for i=1:105
%         if (mean(trial_means{1}(:,i))>(m+two_std)|| mean(horz_BT{1}(:,i))<(m-two_std))
%             plot(horz_BT{1}(:,i));
%             legend_names{j}=num2str(i-3);
%             j=j+1;
%         end
%     end
% end


%%plot(control(1,4:end));

save('trial_means','trial_means');

