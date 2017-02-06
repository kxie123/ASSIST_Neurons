% clc
% clear all
% close all

% Load Betti1 values
load Betti1W1Mountain2
load Betti1W2Mountain2
load Betti1W1Mountain4
load Betti1W2Mountain4

load BettiForestWindow1_mat
load BettiForestWindow2_mat
load BettiBuildingWindow1_mat
load BettiBuildingWindow2_mat
Betti1W1Forest_mat = BettiForestWindow1_mat;
Betti1W2Forest_mat = BettiForestWindow2_mat;
Betti1W1Building_mat = BettiBuildingWindow1_mat;
Betti1W2Building_mat = BettiBuildingWindow2_mat;

load PersIntvalsW1Mountain2
load PersIntvalsW2Mountain2
load PersIntvalsW1Mountain4
load PersIntvalsW2Mountain4

load PersInts1ForestW1All
load PersInts1ForestW2All
load PersInts1BuildingW1All
load PersInts1BuildingW2All

PersIntvalsW1Forest = PersInts1ForestW1All;
PersIntvalsW2Forest = PersInts1ForestW2All;
PersIntvalsW1Building = PersInts1BuildingW1All;
PersIntvalsW2Building = PersInts1BuildingW2All;

load edgeDensities

EdgeDensities=edgeDensities;
L=length(Betti1W1Mountain2{1});  %12424
% converting cells to matrices
Betti1W1Mountain2_mat=zeros(L,51);
Betti1W2Mountain2_mat=zeros(L,51);

Betti1W1Mountain4_mat=zeros(L,51);
Betti1W2Mountain4_mat=zeros(L,51);

for i=1:51
  Betti1W1Mountain2_mat(:,i)= Betti1W1Mountain2{i};
  Betti1W2Mountain2_mat(:,i)= Betti1W2Mountain2{i};
  
  Betti1W1Mountain4_mat(:,i)= Betti1W1Mountain4{i};
  Betti1W2Mountain4_mat(:,i)= Betti1W2Mountain4{i};
end

MeanBetti1W1Mountain2=mean(Betti1W1Mountain2_mat');
MeanBetti1W2Mountain2=mean(Betti1W2Mountain2_mat');

MeanBetti1W1Mountain4=mean(Betti1W1Mountain4_mat');
MeanBetti1W2Mountain4=mean(Betti1W2Mountain4_mat');

MeanBetti1W1Forest=mean(Betti1W1Forest_mat');
MeanBetti1W2Forest=mean(Betti1W2Forest_mat');

MeanBetti1W1Building=mean(Betti1W1Building_mat');
MeanBetti1W2Building=mean(Betti1W2Building_mat');


BettiAllW1=[MeanBetti1W1Mountain2; MeanBetti1W1Mountain4];
MeanAllWindow1 = mean(BettiAllW1);
BettiAllW2=[MeanBetti1W2Mountain2; MeanBetti1W2Mountain4];
MeanAllWindow2 = mean(BettiAllW2);

%% plots
figure
plot(EdgeDensities, MeanBetti1W2Mountain4,'k','linewidth',2)
hold on
plot(EdgeDensities, MeanBetti1W2Forest,'r','linewidth',2)
hold on
plot(EdgeDensities, MeanBetti1W2Building,'b','linewidth',2)
axis([0 0.3 0 12])
set(gca,'FontSize',15)
legend('Mountain','Forest','Building')

figure
plot(MeanBetti1W1Forest,'linewidth',2)
hold on
plot( MeanBetti1W2Forest,'linewidth',2)
hold on
plot(MeanBetti1W2Mountain4,'linewidth',2)
hold on
plot( MeanBetti1W2Building,'linewidth',2)
axis([0 5000 0 11])
set(gca,'FontSize',15)
legend('Rest', 'Forest','Mountain', 'Building')
ylabel('Betti 1')
xlabel('threshold index')
ylabel('\beta_1')

figure
plot(MeanBetti1W1Forest,'r','linewidth',2)
hold on
plot(MeanBetti1W2Building,'k','linewidth',2)
legend('Rest','Building')
axis([0 5000 0 11])
set(gca,'FontSize',15)

%% Significance test
% Bootstraping, 200 times
for p=1:200
y1 = randsample([1:51],10)
I0(p) = sum(mean(Betti1W1Forest_mat(:,y1)') );
I1(p) = sum(mean(Betti1W2Forest_mat(:,y1)') );
I2(p) = sum(mean(Betti1W2Mountain4_mat(:,y1)') );
I3(p) = sum(mean(Betti1W2Building_mat(:,y1)'));
end

[h,p] = ttest2(I1,I3)

[p,tbl] = anova1([I0' I1' I2' I3'])
