

%% Finding Adjacency matrices
NReps=1;
LR=1;
Thr=1.27;

tic

DimsTh1=cell(105,LR);  % DimsTh1{i,j} dimesnions less than threshold for sensor i in experiment j in window 1
SenIThr1=cell(105,LR); % SenIThr1{i,j} sensors with dimesnions less than threshold for sensor i in experiment j in window 1
% DimsTh2=cell(204,LR);  % DimsTh1{i,j} dimesnions less than threshold for sensor i in experiment j in window 2
% SenIThr2=cell(204,LR); % SenIThr2{i,j} sensors with dimesnions less than threshold for sensor i in experiment j in window 2
% DimsTh3=cell(204,LR);SenIThr3=cell(204,LR);
% DimsTh4=cell(204,LR);SenIThr4=cell(204,LR);
% DimsTh5=cell(204,LR);SenIThr5=cell(204,LR);
% DimsTh6=cell(204,LR);SenIThr6=cell(204,LR);

for j=1:LR
    
    MinDims1 =  ADJArt{LR,1}.^-1; 

for i=1:105
   DimsTh1{i,j}= MinDims1(i,MinDims1(i,:)<Thr);   
   SenIThr1{i,j}=find(MinDims1(i,:)<Thr);
   
%    DimsTh2{i,j}= MinDims2(i,MinDims2(i,:)<Thr);
%    SenIThr2{i,j}=find(MinDims2(i,:)<Thr);
%    
%    DimsTh3{i,j}= MinDims3(i,MinDims3(i,:)<Thr);
%    SenIThr3{i,j}=find(MinDims3(i,:)<Thr);
%    
%    DimsTh4{i,j}= MinDims4(i,MinDims4(i,:)<Thr);
%    SenIThr4{i,j}=find(MinDims4(i,:)<Thr);
%    
%    DimsTh5{i,j}= MinDims5(i,MinDims5(i,:)<Thr);
%    SenIThr5{i,j}=find(MinDims5(i,:)<Thr);
%    
%    DimsTh6{i,j}= MinDims6(i,MinDims6(i,:)<Thr);
%    SenIThr6{i,j}=find(MinDims6(i,:)<Thr);
end
end

% window1: -60 to 0
ADJW1=cell(LR,1);
for p=1:LR
Adj1=zeros(105,105);
for k=1:105
    Adj1(k,SenIThr1{k,p}(:)) = 1./DimsTh1{k,p}(:);
end
ADJW1{p,1}=Adj1;
end
% 
% % window2: 0 to 60
% ADJW2=cell(LR,1);
% for p=1:LR
% Adj2=zeros(N,N);
% for k=1:204
%     Adj2(k,SenIThr2{k,p}(:)) = 1./DimsTh2{k,p}(:);
% end
% ADJW2{p,1}=Adj2;
% end
% 
% % window3: 60 to 120
% ADJW3=cell(LR,1);
% for p=1:LR
% Adj3=zeros(N,N);
% for k=1:204
%     Adj3(k,SenIThr3{k,p}(:)) = 1./DimsTh3{k,p}(:);
% end
% ADJW3{p,1}=Adj3;
% end
% 
% % window4: 120 to 180
% ADJW4=cell(LR,1);
% for p=1:LR
% Adj4=zeros(N,N);
% for k=1:204
%     Adj4(k,SenIThr4{k,p}(:)) = 1./DimsTh4{k,p}(:);
% end
% ADJW4{p,1}=Adj4;
% end
% 
% % window5: 180 to 240
% ADJW5=cell(LR,1);
% for p=1:LR
% Adj5=zeros(N,N);
% for k=1:204
%     Adj5(k,SenIThr5{k,p}(:)) = 1./DimsTh5{k,p}(:);
% end
% ADJW5{p,1}=Adj5;
% end
% 
% % window6: 240 to 300
% ADJW6=cell(LR,1);
% for p=1:LR
% Adj6=zeros(N,N);
% for k=1:204
%     Adj6(k,SenIThr6{k,p}(:)) = 1./DimsTh6{k,p}(:);
% end
% ADJW6{p,1}=Adj6;
% end

ADJAll=struct;
ADJAll.ADJW1=ADJW1;
% ADJAll.ADJW2=ADJW2;
% ADJAll.ADJW3=ADJW3;
% ADJAll.ADJW4=ADJW4;
% ADJAll.ADJW5=ADJW5;
% ADJAll.ADJW6=ADJW6;

%% saving
% ADJMountain2=ADJAll;
% save('ADJMountain2','ADJMountain2')
% %% Calculating Betti values
% % Betti 1 only
% 
% Betti1W1=cell(1,1);
% %Betti1W2=cell(NReps,1);
% PersIntvalsW1 = cell(1,1);
% %PersIntvalsW2 = cell(NReps,1);
% 
% for EN=1:NReps
% EN
% 
% % -60 to 0 
% % make it undirected 
% ADJW1=ADJAll.ADJW1;
% ADJW1UT = triu(ADJW1{EN,1});
% ADJW1LT = ADJW1UT';
% % make it symmetric
% ADJW1Sym = ADJW1UT + ADJW1LT;
% %finding Betti_1 curves
% [bettiCurvesW1, edgeDensities, persistenceIntervalsW1,unboundedIntervalsW1] = compute_clique_topology (ADJW1Sym , 'MaxBettiNumber',1,'ReportProgress',true);
% Betti1W1{EN} = bettiCurvesW1;
% PersIntvalsW1{EN} = persistenceIntervalsW1;
% % % 0 to 60 
% % %make it undirected 
% % ADJW2=ADJAll.ADJW2;
% % ADJW2UT = triu(ADJW2{EN,1});
% % ADJW2LT = ADJW2UT';
% % % make it symmetric
% % ADJW2Sym = ADJW2UT + ADJW2LT;
% % %finding Betti_1 curves
% % [bettiCurvesW2, edgeDensities, persistenceIntervalsW2,unboundedIntervalsW2] = compute_clique_topology (ADJW2Sym , 'MaxBettiNumber',1,'ReportProgress',true);
% % Betti1W2{EN} = bettiCurvesW2;
% % PersIntvalsW2{EN} = persistenceIntervalsW2;
% end
% 
% save('EdgeDensities','EdgeDensities')
% %% saving
% Betti1W1Mountain2 = Betti1W1;
% %Betti1W2Mountain2 = Betti1W2;
% PersIntvalsW1Mountain2=PersIntvalsW1;
% %PersIntvalsW2Mountain2=PersIntvalsW2;
% save('Betti1W1Mountain2','Betti1W1Mountain2')
% %save('Betti1W2Mountain2','Betti1W2Mountain2')
% save('PersIntvalsW1Mountain2','PersIntvalsW1Mountain2')
% %save('PersIntvalsW2Mountain2','PersIntvalsW2Mountain2')
% %%
% 



