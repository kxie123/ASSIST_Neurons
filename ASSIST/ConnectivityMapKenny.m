%%%% Modified by Kenny, with additional comments. I have basically removed
%%%% stuff unnecessary for our purposes. 


% This code performs dimension estimation of delay embeddin and computes ADJ matrices for each time window 
clc
clear all
close all

load('trial_means.mat'); 
%the trial_means file is uploaded on my google drive. 
% See notepad documentation for more explanation. 
% It is a 12x1 cell array containing 12 99x105 matrices, representing each
% segment. 

NS=105;
NT=99;

d = 1;   %minimum lag
M = 20;  % max possible lag

ResultsArtificial=struct;
ADJArt=cell(length(trial_means),1);

% for each repetition ...
for ii=1:12
ii
T=trial_means{ii,1};

% z score normalizing
TrialZ=(zscore(T))';  % it should be NS by NT

% computing pairwise dimensions
tic
[DimAll, MinDimensions, DimValAll, SenIAll, DelayAll]=DimEmbed(TrialZ,M,d);
toc

TrialResults = struct;
TrialResults.DimAll=DimAll;
TrialResults.MinDimensions=MinDimensions;
TrialResults.DimValAll=DimValAll;
TrialResults.SenIAll=SenIAll;
TrialResults.DelayAll=DelayAll;

if (isempty(ResultsArtificial))
        ResultsArtificial = TrialResults;
    else
        ResultsArtificial(ii).DimAll = TrialResults.DimAll;
        ResultsArtificial(ii).MinDimensions = TrialResults.MinDimensions;
        ResultsArtificial(ii).DimValAll = TrialResults.DimValAll;
        ResultsArtificial(ii).SenIAll = TrialResults.SenIAll;
        ResultsArtificial(ii).DelayAll = TrialResults.DelayAll;
end

Adj = MinDimensions.^-1;
ADJArt{ii}=Adj;

end % ...for each experiment

%% saving
%%save('ResultsArtificial','ResultsArtificial')
%save('ADJArt','ADJArt')

