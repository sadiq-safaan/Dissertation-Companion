function [sA] = sA_listgenerator(iter,n)

% function [sA] = sA_listgenerator(iter,n)
% 
% This function creates a cell array of DAG adjacency matrices with at least two sinks.
%
% Inputs: iter = number of DAGs to be generated, n = size of DAG
% Outputs: sA = cell array of DAG adjacency matrices
%
% Last Modified on 4/26/2025 by Safaan Sadiq

sA={};
for i=1:iter
    adj_mat = randi([0 1], n,n).*(ones(n)-eye(n)); % Random Adjacency matrix
    adj_mat = triu(adj_mat);  % Make DAG
    adj_mat(1,2)=0; % Ensure two sinks at least
    sA{i}=adj_mat;
end
end
