function [basin_frac,sinks,indeg]=brute_force(sA_list,savetag)

% function [basin_frac,sinks,indeg]=brute_force(sA_list,savetag)
%
% sA_list = cell array of sA adjacency matrices for DAGs
% savetag = data will be saved as brute_force_savetag.mat
%
% Last Updated Sept. 19 2024

iter=2500; % number of initial conditions sampled per DAG
n=size(sA_list{1},1);
eta=0.01; % Maximum size of perturbation
t_end=50; % Length of simulation

%CTLN parameters
delta=0.5;
epsilon=0.25;
theta=1;

for k=1:length(sA_list)
    sA=sA_list{k};
    out_degree = sum(sA,1);
    in_degree = sum(sA,2)';

    sinklist=find(out_degree==0);
    sinks{k}=sinklist;

    id_sinks=in_degree(sinklist);
    indeg{k}=id_sinks;

    % Initialize full sink fp
    x0_orig=zeros(n,1);
    row_sum=1+(length(sinklist)-1)*(1+delta);
    fp_val=(theta/row_sum)*ones(length(sinklist),1);
    x0_orig(sinklist)=fp_val;
    pert_point{k}=x0_orig;

    basins=zeros(iter,2);
    except=[]; % Create list of cases were trajectory converges to saddle point
    for i=1:iter
        %Saddle Point Perturbation Initial Condition
        pert_v=rand(n,1);
        pert_v(sinklist)=-1+2*rand(length(sinklist),1);
        pert_v=eta*rand*pert_v/norm(pert_v);

        x0=pert_point{k}+pert_v;

        %Simulate CTLN
        soln = sA2soln(sA,t_end,x0,epsilon,delta,theta);
        es=soln.X(end,:);
        fps=find(es>1e-4);

        
        if length(fps)<2 % i.e. not a saddle point
            basins(i,1)=fps;
        end


        if length(fps)>=2
            except=[except i];
        end
    end

    h=histogram(basins(setdiff(1:iter,except),1));
    bf=h.Values;
    bf=bf/(iter-length(except));
    bf=bf(find(bf>0));
    

    basin_frac{k}=bf;
    k % Keep track of progress
end

% save the results of computation
savename=['brute_force_' savetag];


save(savename,"sA_list","sinks","indeg","basin_frac","pert_point")
