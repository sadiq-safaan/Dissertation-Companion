
iter=1000; % Number of DAGs
n=8; % Size of DAGs
sA=sA_listgenerator(iter,n); % Generate cell array of DAGs
b=ones(size(adj_mat,1),1); % Initialize drive vector

delta_vec=0.1:0.1:3; % Initialize possible delta

for i=1:length(delta_vec)
    delta=delta_vec(i); % Fix delta
    eps_vec=0.05:0.05:(delta/(1+delta)); % Initialize possible epsilon

    for j=1:length(eps_vec)
        eps=eps_vec(j); % Fix epsilon

        count_tot=0; % Counts total number of conclusive predictions
        count_acc=0; % Counts number of accurate predictions

        for k=1:iter
            adj_mat=sA{k}; % Fix DAG

            W=(-1-delta)*ones(n) + (1+delta)*eye(n) + (eps+delta)*adj_mat; % Initialize W matrix
            xbs=-inv(W)*b; % Find balanced state

            
            % Numerical Simulation of balanced state trajectory
            soln = sA2soln(adj_mat,50,xbs,eps,delta,1);
            fp=soln.X(end,:);
            fp_supp=soln.X(end,:)>1e-4;
            fp_supp;

            if sum(fp_supp)==1
                att_real=find(fp_supp>0);
            end

            % Algorithm prediction
            att_predict=bsalgo(adj_mat);

            if att_predict~=0
                count_tot=count_tot+1;
            end
            
            if att_real==att_predict
                count_acc=count_acc+1;
            end
        end
        accuracy=count_acc/count_tot; % Compute accuracy by dividing correct predictions over total predictions

        figure(1)
        scatter(delta,eps,[],[accuracy, 0, 0],'filled')
        hold on
    end
end
hold off
