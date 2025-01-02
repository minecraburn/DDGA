clear;close all;clc
%% Parameter settings
n0 = 100;
D = 0.1;

xini = [0.01; 1; 0.25; 0.1; 0.01; 0.01; 0.1; 0.05; 0.01; 0.01; 0.01;...
    0.01; 0.01; 0.01; 0.01; 0.01; 0.01; 0.01; 0.01; 0.01; 0.01; 0.01;...
    0.01; 0.25; 0.01; 0.01; 0.01; 0.01; 0.01; 0.01; 0.01; 0.01; 0.01;...
    0.01; 0.01; 0.01; 0.01; 0.1; 0.01; 0.01; 0.01; 0.01; 0.01; 0.01];

delt = 0.001;

dim = 44;
patry = 41;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% type the segment of parameters that you want to test the sensitivity
% if you want to test all the parameters, let left=1 and right=41
left = 1;
right = 41;

% if you want to test all the codes, choose "load_num=0"
% or use "load_num=1" to load the results of the codes from the 27-th row to the 108-th row.
load_num = 1;
% !!!! Warning: testing all the parameters by "load_num=0" will take a lot of time (2h~3h)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if load_num == 1
    load BH_data.mat;
    % each row: G0/G1 phase, S phase, G2 phase, M phase, G1 checkpoint, G2 checkpoint, M checkpoint
elseif load_num == 0
    % Calculating limit cycle
    period=zeros(patry+1,40);
    periodnum=zeros(patry+1,1);
    xall=zeros(patry+1,50000,dim);
    for parnum=left:right+1
        if parnum == right+1
            parnum = patry+1;
        end
        [period(parnum,:),periodnum(parnum,1),xall(parnum,:,:)]=get_cycle(xini,n0,delt,parnum);
    end
    % Loading expression for the Hessian matrix of cell-cycle systems
    load Jac_45_dim.mat
    
    % Preparations for calculating energy landscape
    pland = zeros(patry+1,501,501);
    pcycle =zeros(patry+1,1000);
    
    parnum=patry+1;
    seg_t=50;
    cycle=xall(parnum,1:seg_t:period(parnum,periodnum(parnum,1))/delt+50-period(parnum,periodnum(parnum,1)-1)/delt+1,:);
    cycle=squeeze(cycle);
    n0=size(cycle);
    n0=n0(1)-1;
    x0=cycle';
    fx=force_45_remake(x0,parnum)';
    Hx=J_45_remake(x0,Jac_45_dim,parnum);
    q0 = get_q(n0,delt*seg_t,D,cycle,fx,Hx);
    orn0=n0;
    % Calculating energy landscape
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % this step costs a lot of time
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for parnum=left:right+1
        if parnum == right+1
            parnum = patry+1;
        end
        seg_t=50;
        cycle=xall(parnum,1:seg_t:period(parnum,periodnum(parnum,1))/delt+50-period(parnum,periodnum(parnum,1)-1)/delt+1,:);
        cycle=squeeze(cycle);
        n0=size(cycle);
        n0=n0(1)-1;
        x0=cycle';
        fx=force_45_remake(x0,parnum)';
        Hx=J_45_remake(x0,Jac_45_dim,parnum);
        [pland(parnum,:,:),pcycle(parnum,:)]=get_DDGA_land(n0,dim,D,cycle,q0,orn0,Hx);
    end 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % type the number of parameters that you want to visualize the landscape after the perturbation
    % e.g. check_num = 35
    % make sure the number is between left and right
    % if you do not want to visualize it, just skip it
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % check_num=left;
    % nea=15;
    % neb=22;
    % xsidel=0;xsider=0.5;
    % ysidel=0;ysider=0.5;
    % step=0.001;
    % xla=xsidel:step:xsider;
    % yla=ysidel:step:ysider;
    % zla1=squeeze(pland(check_num,:,:));
    % zla=zla1/sum(sum(zla1));
    % zla=(-log(zla));
    % figure(check_num);
    % surf(xla,yla,zla,'DisplayName','');shading interp;
    
    % Calculating the barrier height
    for parnum=left:right+1
        if parnum == right+1
            parnum = patry+1;
        end
        seg_t=50;delt=0.001;
        cycle=xall(parnum,1:seg_t:period(parnum,periodnum(parnum,1))/delt+50-period(parnum,periodnum(parnum,1)-1)/delt+1,:);
        cycle=squeeze(cycle);
        BH_data(parnum,:) = get_barrier_height(pcycle(parnum,:),cycle);
    end

end
%% Ploting the figure
barG1 = BH_data(:,5) - BH_data(:,1); % G1 checkpoint - G0/G1 phase
barG2 = BH_data(:,6) - BH_data(:,2); % G2 checkpoint - S phase
barM = BH_data(:,7) - BH_data(:,3); % M checkpoint - G2 phase

figure()
delbarG1=(barG1-barG1(42))/barG1(42);
delbarG2=(barG2-barG2(42))/barG2(42);
delbarM=(barM-barM(42))/barM(42);
histdata=zeros(right-left+1,3);
histdata(:,1)=delbarG1(left:right);
histdata(:,2)=delbarG2(left:right);
histdata(:,3)=delbarM(left:right);
bar(histdata,1.2)
set(gca,'FontSize',16);
legend(["$\Delta Barrier_{G1}$","$\Delta Barrier_{G2}$","$\Delta Barrier_{M}$"],...
    'fontsize',16,"Interpreter","latex","Location","South","Orientation","horizontal","Box","off")
xlabel("Parameter labels",'fontsize',16)
ylabel("$\Delta Barrier(G1,G2,M)$",'fontsize',16,"Interpreter","latex")
set(gcf,"PaperSize",[30,20]);