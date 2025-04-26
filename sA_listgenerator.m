function [sA] = sA_listgenerator(iter,n)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
sA={};
for i=1:iter
    adj_mat = randi([0 1], n,n).*(ones(n)-eye(n));
    adj_mat = triu(adj_mat);
    adj_mat(1,2)=0;
    sA{i}=adj_mat;
end
end