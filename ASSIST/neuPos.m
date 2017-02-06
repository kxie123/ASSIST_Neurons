% Compute the center and the distance matrix of all neurons
% 18/07/16 modified
%close all, clear all, clc;

% Import data
% load('roilocation.mat')
load('neuPositionCal.mat')


%% Compute the position of each neuron
neuronCenter = [];      % row: no. of neuron, col: coordinate (x,y)
nStart = 1;
nEnd = 105;
for iNeuron = nStart: nEnd
    currentNeuron = neuPositionCal(:,:,iNeuron);
    horPixels = mean(currentNeuron);
    verPixels = mean(currentNeuron');
    horIndex = find(horPixels ~= 0);
    verIndex = find(verPixels ~= 0);
    neuronCenter(iNeuron,:) = [mean(verIndex), mean(horIndex)];
end

% Euclidean distance between neurons
%neuDistMatrixCal = squareform(pdist(neuronCenter,'euclidean'));





