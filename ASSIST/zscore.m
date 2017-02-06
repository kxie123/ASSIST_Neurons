function [ res ] = zscore( X )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

X=X-mean(X(:));
res=X/std(X(:));


end

