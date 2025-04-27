function [basin_frac,sinks,indeg]=brute_force_full(sA_list,savetag)

% function [basin_frac,sinks,indeg]=brute_force_full(sA_list,savetag)
%
% sA_list = cell array of sA adjacency matrices for DAGs
% savetag = data will be saved as brute_force_savetag.mat
%
% Last Updated Oct. 21 2024

iter=2500; % Number of initial conditions per DAG
n=size(sA_list{1},1);
t_end=50; % Length of simulation

%CTLN parameters
delta=0.5;
epsilon=0.25;
theta=1;
B=1.5*theta; % State space box size

for k=1:(length(sA_list))
    sA=sA_list{k};
    out_degree = sum(sA,1);
    in_degree = sum(sA,2)';

    sinklist=find(out_degree==0);
    sinks{k}=sinklist;

    id_sinks=in_degree(sinklist);
    indeg{k}=id_sinks;

    basins=zeros(iter,2);

    for i=1:iter
        %State Space Sampling of Initial Conditions
        x0=B*rand(n,1);

        %Simulate CTLN
        %[t_vec,X] = ode_sim(W,b,t_end,dt,x0);
        soln = sA2soln(sA,t_end,x0,epsilon,delta,theta);
        es=soln.X(end,:);
        fps=find(es>1e-4);
        basins(i,1)=fps;
    end

    h=histogram(basins(:,1));
    bf=h.Values;
    bf=bf/iter;
    bf=bf(find(bf>0));

    basin_frac_full{k}=bf;
    k
end

% save the results of computation
savename=['brute_force_full' savetag];


save(savename,"sA_list","sinks","indeg","basin_frac_full")
