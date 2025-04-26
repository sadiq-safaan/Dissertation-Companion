%adj_mat=[0 0 1; 0 0 0; 0 0 0];
%adj_mat=[0 1 0 0 0;0 0 0 1 0;0 0 0 1 1; 0 0 0 0 0;0 0 0 0 0];
%adj_mat= [0 0 0 1 0 1;0 0 1 0 0 1;0 0 0 1 0 0;0 0 0 0 1 1;0 0 0 0 0 1;0 0 0 0 0 0];
iter=1000;
n=8;
sA=sA_listgenerator(iter,n);
%adj_mat = randi([0 1], n,n).*(ones(n)-eye(n));
%adj_mat = triu(adj_mat);
b=ones(size(adj_mat,1),1);
%n=size(adj_mat,1);

delta_vec=0.1:0.1:3;
att_vec=0*delta_vec;

for i=1:length(delta_vec)
    delta=delta_vec(i);
    eps_vec=0.05:0.05:(delta/(1+delta));

    for j=1:length(eps_vec)
        eps=eps_vec(j);

        count_tot=0;
        count_acc=0;

        for k=1:iter
            adj_mat=sA{k};

            W=(-1-delta)*ones(n) + (1+delta)*eye(n) + (eps+delta)*adj_mat;
            xbs=-inv(W)*b;

            soln = sA2soln(adj_mat,50,xbs,eps,delta,1);
            fp=soln.X(end,:);
            fp_supp=soln.X(end,:)>1e-4;
            fp_supp;

            if sum(fp_supp)==1
                att_real=find(fp_supp>0);
            end

            att_predict=bsalgo(adj_mat);

            if att_predict~=0
                count_tot=count_tot+1;
            end
            
            if att_real==att_predict
                count_acc=count_acc+1;
            end
        end
        accuracy=count_acc/count_tot;

        figure(1)
        scatter(delta,eps,[],[accuracy, 0, 0],'filled')
        hold on
    end
end
hold off
