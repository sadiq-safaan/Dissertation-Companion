function traj_graph_gen(w1,w2,b1,b2,R)

% function traj_graph_gen(w1,w2,b1,b2,R)
%
% This function generates a trajectory graph for a two dimensional
% competitve TLN with parameters W_12, W_21, theta_1, and theta_2
%
% Inputs: w1=W_12, w2=W_21, b1=theta_1, b2=theta_2, R=window ([0 R]x[0 R])
%
% Last edited: 4/28/2025 by Safaan Sadiq

iter=500; % number of trajectories

hold on

% Simulate trajectories
for i=1:iter
    x0=R*rand(2,1);
    [t,x]=ode45(@bcm,[0 50],x0);
    plot(x(:,1),x(:,2),'Color',[1 0.7 0.7])
end

dW=-w1*w2;
m=sqrt(w1/w2);

x_stencil=0:0.001:R;
dummy=ones(length(x_stencil),1);

plot(x_stencil,(-b1/w1)*dummy,'b', 'LineWidth', 3) %H1

plot((-b2/w2)*dummy,x_stencil,'b', 'LineWidth', 3) %H2

plot(x_stencil,max(0,w2*x_stencil + b2),'g','LineWidth', 3) %N2
plot(max(0,w1*x_stencil + b1),x_stencil,'g','LineWidth', 3) %N1

% Plot M_1
if w2<(-b2/b1)
    m1_sten1=((w2*b1 + b2)/dW):0.001:(-b1/w1);
    M1=f1((-b2/w2),(w2*b1 + b2)/dW,m1_sten1); %R_1 segment
    plot(M1,m1_sten1,'m','LineWidth', 3)
    m1_sten2=(-b1/w1):0.001:R;
    M1c=(-w1/b1)*f1((-b2/w2),(w2*b1 + b2)/dW,(-b1/w1))*m1_sten2; %R0 segment
    plot(M1c,m1_sten2,'m','LineWidth', 3)
end

% Plot M_2
if w1<(-b1/b2)
    m2_sten1=((b1 + w1*b2)/dW):0.001:(-b2/w2);
    M2=f2(((b1 + w1*b2)/dW),-b1/w1,m2_sten1); %R2 segment
    plot(m2_sten1,M2,'m','LineWidth', 3)
    m2_sten2=(-b2/w2):0.001:R;
    M2c=(-w2/b2)*f2(((b1 + w1*b2)/dW),-b1/w1,-b2/w2)*m2_sten2; %R0 segment
    plot(m2_sten2,M2c,'m','LineWidth', 3)
end

% Plot diagonal
plot(0:0.001:-b2/w2,((b1*w2)/(b2*w1))*(0:0.001:-b2/w2),'Color','k','LineWidth', 3,'LineStyle','--')
plot(-b2/w2:0.001:R,((b1*w2)/(b2*w1))*(-b2/w2:0.001:R),'Color','k','LineWidth', 3,'LineStyle','-')

% Stable Manifold in single fp case
if (w1>(-b1/b2)) && (w2>(-b2/b1))

    %S1
    if w2<((b2/b1)^2)*w1
        %R12 Segment
        sten1=0:0.001:((w2-(m^(-1)))*(w2*b1+b2))/(w2*(1+dW));
        S11=(m*sten1)+(((1-m*w2)*b1 + (w1-m)*b2)/(1+dW));
        plot(S11,sten1,'Color','k','LineWidth', 3)

        %R1 Segment
        sten2=((w2-(m^(-1)))*(w2*b1+b2))/(w2*(1+dW)):0.001:(-b1/w1);
        S12=f1(-b2/w2,((w2-(m^(-1)))*(w2*b1+b2))/(w2*(1+dW)),sten2);
        plot(S12,sten2,'Color','c','LineWidth', 3)

        %R0 Segment
        sten3=(-b1/w1):0.001:R;
        S13=(-w1/b1)*f1(-b2/w2,((w2-(m^(-1)))*(w2*b1+b2))/(w2*(1+dW)),(-b1/w1))*sten3;
        plot(S13,sten3,'Color','r','LineWidth', 3)
    end

    %S2
    if w2>((b2/b1)^2)*w1
        %R12 Segment
        sten1=0:0.001:((w1-m)*(b1+w1*b2))/(w1*(1+dW));
        S21=((m^(-1))*sten1)+(((1-(m^(-1))*w1)*b2 + (w2-(m^(-1)))*b1)/(1+dW));
        plot(sten1,S21,'Color','k','LineWidth', 3)

        %R2 Segment
        sten2=((w1-m)*(b1+w1*b2))/(w1*(1+dW)):0.001:(-b2/w2);
        S22=f2(((w1-m)*(b1+w1*b2))/(w1*(1+dW)),-b1/w1,sten2);
        plot(sten2,S22,'Color','c','LineWidth',3)

        %R0 Segment
        sten3=(-b2/w2):0.001:R;
        S23=(-w2/b2)*f2(((w1-m)*(b1+w1*b2))/(w1*(1+dW)),-b1/w1,-b2/w2)*sten3;
        plot(sten3,S23,'Color','r','LineWidth',3)
    end
end

% Stable Manifold in bistable case
if (w1<(-b1/b2)) && (w2<(-b2/b1))

    %S2
    if w2<((b2/b1)^2)*w1
        %R12 Segment
        sten1=0:0.001:((w1-m)*(b1+w1*b2))/(w1*(1+dW));
        S21=((m^(-1))*sten1)+(((1-(m^(-1))*w1)*b2 + (w2-(m^(-1)))*b1)/(1+dW));
        plot(sten1,S21,'Color','k','LineWidth', 3)

        %R2 Segment
        sten2=((w1-m)*(b1+w1*b2))/(w1*(1+dW)):0.001:(-b2/w2);
        S22=f2(((w1-m)*(b1+w1*b2))/(w1*(1+dW)),-b1/w1,sten2);
        plot(sten2,S22,'Color','c','LineWidth',3)

        %R0 Segment
        sten3=(-b2/w2):0.001:R;
        S23=(-w2/b2)*f2(((w1-m)*(b1+w1*b2))/(w1*(1+dW)),-b1/w1,-b2/w2)*sten3;
        plot(sten3,S23,'Color','r','LineWidth',3)
    end

    %S1
    if w2>((b2/b1)^2)*w1
        %R12 Segment
        sten1=0:0.001:((w2-(m^(-1)))*(w2*b1+b2))/(w2*(1+dW));
        S11=(m*sten1)+(((1-m*w2)*b1 + (w1-m)*b2)/(1+dW));
        plot(S11,sten1,'Color','k','LineWidth', 3)

        %R1 Segment
        sten2=((w2-(m^(-1)))*(w2*b1+b2))/(w2*(1+dW)):0.001:(-b1/w1);
        S12=f1(-b2/w2,((w2-(m^(-1)))*(w2*b1+b2))/(w2*(1+dW)),sten2);
        plot(S12,sten2,'Color','c','LineWidth', 3)

        %R0 Segment
        sten3=(-b1/w1):0.001:R;
        S13=(-w1/b1)*f1(-b2/w2,((w2-(m^(-1)))*(w2*b1+b2))/(w2*(1+dW)),(-b1/w1))*sten3;
        plot(S13,sten3,'Color','r','LineWidth', 3)
    end
end




axis([0 R 0 R])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Auxiliary Functions

    function y=f1(a,b,x)
        y=((a-b1)/b)*x - (w1*x.*log(x/b)) +b1;
    end

    function y=f2(a,b,x)
        y=((b-b2)/a)*x - (w2*x.*log(x/a)) +b2;
    end

    function dxdt=bcm(t,x)
        dxdt=[-x(1)+max(0,w1*x(2)+b1);-x(2)+max(0,w2*x(1)+b2)];
    end


end