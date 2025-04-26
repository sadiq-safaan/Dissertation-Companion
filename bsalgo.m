function [attractor] = bsalgo(sA)

% function [attractor] = bsalgo(sA)
%
% Inputs: DAG adjacency matrix
% Outputs: Balanced State attractor prediction
%
% Last modified 4/3/2025 by Safaan Sadiq

outdegree=sum(sA,1);
candidates=find(outdegree==0);

n=size(sA,1);
template=zeros(n);
attractor=0;

top_layer=ones(1,n);

for j=1:n
    B=sA^j;
    paths=sum(B,1);
    top_layer=top_layer+(paths>0);
end

stop=0;
layer=2;

while stop==0
    indices = find(top_layer<layer);
    red_sA=template;
    red_sA(indices,indices)=sA(indices,indices);
    filt_indegree=sum(red_sA,2)';
    filt_idc=filt_indegree(candidates);
    max_fid=max(filt_idc);
    candidates=candidates(find(filt_idc==max_fid));

    if length(candidates)==1
        attractor=candidates;
        stop=1;
    end

    if layer==(max(top_layer)+1)
        stop=1;
    end
    
    layer=layer+1;
end
end