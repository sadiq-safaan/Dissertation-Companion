function plotbasinfrac(indeg,basin_frac,sA_list)

% function plotbasinfrac(indeg,basin_frac,sA_list)
%
% indeg = cell array of indegrees of sinks in the DAGs
% basin_frac = cell array of fraction of neighborhood of saddle point 
%               basins of attraction for each sink in the DAGs
% sA_list = cell array of DAG adjacency matrices
%
% Last updated 4/27/25 by Safaan Sadiq

N=length(indeg); % Number of DAGs

for i=1:N
    sA=sA_list{i};
    out_degree = sum(sA,1);

    sinklist=find(out_degree==0);
end


idlist=[];
bflist=[];


% Combine fractional indegrees and basin fractions for each sink across all DAGs into two lists
for i=1:N

id=[];
bf=[];

    if  basin_frac{i}~=1 & numsinks(i)==2 % First condition omits the case of a single sink, the second restricts to two sinks and can be adjusted

        id=indeg{i};
        id=id/sum(id); % compute fractional indegrees
        bf=basin_frac{i};

        idlist=[idlist id];
        bflist=[bflist bf];

    end
end

% Calculate Correlation
pear=corrcoef(idlist,bflist);
pear=pear(1,2)

figure(1)
boxplot(bflist,idlist)
title('number of sinks = 3,4,5, corr='+ string(pear))
xlabel('indegree fraction of total sink indegree')
ylabel('basin fraction')

end
