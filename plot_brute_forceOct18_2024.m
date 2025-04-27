function plot_brute_forceOct18_2024(indeg,basin_frac,sA_list)

% function plot_brute_forceOct18_2024(indeg,basin_frac,sA_list)
%
% indeg = cell array of indegrees of sinks in the DAGs
% basin_frac = cell array of fraction of neighborhood of saddle point 
%               basins of attraction for each sink in the DAGs
% sA_list = cell array of DAG adjacency matrices
%
% Last updated 10/18/24 by Safaan Sadiq

N=length(indeg);

for i=1:N
    sA=sA_list{i};
    out_degree = sum(sA,1);
    in_degree2 = sum(sA^2,2)';

    sinklist=find(out_degree==0);

    indeg2{i}=in_degree2(sinklist);
end

id2gid1=[];
id2gid2=[];
id2gid3=[];
id2gid4=[];
id2gid5=[];
id2gid6=[];
id2gid7=[];
id2gid8=[];
id2gid9=[];
id2gid10=[];
id2gid11=[];
id2gid12=[];
id2gid13=[];

bfgid1=[];
bfgid2=[];
bfgid3=[];
bfgid4=[];
bfgid5=[];
bfgid6=[];
bfgid7=[];
bfgid8=[];
bfgid9=[];
bfgid10=[];
bfgid11=[];
bfgid12=[];
bfgid13=[];

numsinks=cellfun(@length,indeg);
idlist=[];
bflist=[];


for i=1:N
id=[];
id2=[];
bf=[];
    if  basin_frac{i}~=1 & numsinks(i)==2

        id=indeg{i};
        id=id/sum(id);
        id2=indeg2{i};
        id2=id2/sum(id2);
        bf=basin_frac{i};

        idlist=[idlist id];
        bflist=[bflist bf];

        id1list=find(id==0);
        id2list=find(id==1/2);
        id3list=find(id==1/3);
        id4list=find(id==1/4);
        id5list=find(id==1/5);
        id6list=find(id==2/3);
        id7list=find(id==2/5);
        id8list=find(id==3/4);
        id9list=find(id==3/5);
        id10list=find(id==3/7);
        id11list=find(id==4/5);
        id12list=find(id==4/7);
        id13list=find(id==1);


        id2gid1=[id2gid1 id2(id1list)];
        id2gid2=[id2gid2 id2(id2list)];
        id2gid3=[id2gid3 id2(id3list)];
        id2gid4=[id2gid4 id2(id4list)];
        id2gid5=[id2gid5 id2(id5list)];
        id2gid6=[id2gid6 id2(id6list)];
        id2gid7=[id2gid7 id2(id7list)];
        id2gid8=[id2gid8 id2(id8list)];
        id2gid9=[id2gid9 id2(id9list)];
        id2gid10=[id2gid10 id2(id10list)];
        id2gid11=[id2gid11 id2(id11list)];
        id2gid12=[id2gid12 id2(id12list)];
        id2gid13=[id2gid13 id2(id13list)];

        bfgid1=[bfgid1 bf(id1list)];
        bfgid2=[bfgid2 bf(id2list)];
        bfgid3=[bfgid3 bf(id3list)];
        bfgid4=[bfgid4 bf(id4list)];
        bfgid5=[bfgid5 bf(id5list)];
        bfgid6=[bfgid6 bf(id6list)];
        bfgid7=[bfgid7 bf(id7list)];
        bfgid8=[bfgid8 bf(id8list)];
        bfgid9=[bfgid9 bf(id9list)];
        bfgid10=[bfgid10 bf(id10list)];
        bfgid11=[bfgid11 bf(id11list)];
        bfgid12=[bfgid12 bf(id12list)];
        bfgid13=[bfgid13 bf(id13list)];
    end
end

pear=corrcoef(idlist,bflist);
pear=pear(1,2)

figure(1)
boxplot(bflist,idlist)
title('number of sinks = 3,4,5, corr='+ string(pear))
xlabel('indegree fraction of total sink indegree')
ylabel('basin fraction')

figure(4)
subplot(3,1,1)
boxplot(bfgid1,id2gid1)
title('number of sinks = 2, fixed indegree frac 0')
xlabel('number of paths of length 2')
ylabel('basin fraction')
hold on
plot(xlim,[0.5 0.5],'-g')

subplot(3,1,2)
boxplot(bfgid2,id2gid2)
title('number of sinks = 2, fixed indegree frac 1/2')
xlabel('number of paths of length 2')
ylabel('basin fraction')
hold on
plot(xlim,[0.5 0.5],'-g')

subplot(3,1,3)
boxplot(bfgid3,id2gid3)
title('number of sinks = 2, fixed indegree frac 1/3')
xlabel('number of paths of length 2')
ylabel('basin fraction')
hold on
plot(xlim,[0.5 0.5],'-g')

hold off


hist(numsinks)
end