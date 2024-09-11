%% Codes for calculating Coherence and Flux Intloop
clear;close all;clc
% tic

%% Langevin Simulation (this may takes a long time, maybe 6~10h)
%  If you only want to see how the two indicators are calculated,
%  revise D an B to contains fewer elements (one group of (D,B) may take 2-5min).
dt = 0.01; % step time
steps = 1*1e7 + 1; % step number
t = dt * (1:steps);

D = 0.02:0.02:0.3; % noise
d_num = length(D);

a = 8;
B = [0.4:0.1:1 1.2:0.2:4]; % decay rate
b_num = length(B);

[B_axis,D_axis] = meshgrid(B,D);

Cohe = zeros(b_num,d_num); % Coherence

Flux_int = zeros(b_num,d_num); % Flux Integration
L_cycle = zeros(b_num,1);

period_osci = zeros(b_num,1);

for bnum = 1:b_num
b = B(bnum);

% Initial value
path = zeros(6,steps,d_num);
path(:,1,:) = repmat([1;0;1;0;1;0],[1,1,d_num])+0.1*rand(6,1,d_num);

Force = zeros(6,steps-1,d_num);

for dnum = 1:d_num
    for i = 1:steps-1
        F = force_limit6(0,path(:,i,dnum).',a,b);
        path(:,i+1,dnum)=path(:,i,dnum) + F*dt...
            +normrnd(0,sqrt(2*D(dnum)*dt),6,1);
        Force(:,i,dnum) = F;
    end
end

%%% Period
load 'momentdata.mat'

dt_flo = 0.01;
T_flo = 200;

% moment(7:end) = reshape(diag(diag(reshape(moment(7:end),6,6))),36,1);

% deterministic
% [~,x_c]=ode45(@(t,x) force_limit6(t,x,a,b),0:dt_flo:T_flo,moment(1:6));
%%% solve the moment equations
[~,x_c]=ode45(@(t,x) ode_cov(t,x,a,b),0:dt_flo:T_flo,moment);
x_var = x_c(:,7:end);
x_mu = x_c(:,1:6);

% calculate the period
tra_x = x_mu - x_mu(end,:);
dis_x1 = vecnorm(tra_x.').';


thres_force = max(vecnorm(reshape(Force,6,(steps-1)*d_num)),[],'all'); % threshold for force strength
Period_time = find(dis_x1 < 0.6*thres_force*dt_flo); % the end of one period
period_time = zeros(length(Period_time)-1,1);

for i = 1:length(Period_time)-1
    if Period_time(i+1) - Period_time(i) ~= 1
        period_time(i) = Period_time(i);
    end
end

period_time(period_time == 0) = [];
Period = mean(diff(period_time)) * dt_flo % the period
period_osci(bnum) = Period;

I = eye(6);
Flo_matrix = zeros(6,6);

T_end = Period;
Time_flo_deter = 0:dt_flo:T_end;

[~,x_deter_moments]=ode45(@(t,x) ode_cov(t,x,a,b), Time_flo_deter, x_c(end,:).');
x_deter = x_deter_moments(:,1:6); % expectation in one period
x_deter_var = x_deter_moments(:,7:end); % covariance in one period

%% Trajectory
obj1 = 1;
obj2 = 3; % the display dimensions
Tra1 = reshape(path(obj1, :, :), [steps, d_num]);
Tra2 = reshape(path(obj2, :, :), [steps, d_num]);

figure() % trajectory

t_start = 50000;
t_end = 55000;

dnum = 1;

plot(t(t_start:t_end),path(1, t_start:t_end, dnum),'b','LineWidth',1)
hold on
plot(t(t_start:t_end),path(2, t_start:t_end, dnum),'r','LineWidth',1)
hold on
plot(t(t_start:t_end),path(3, t_start:t_end, dnum),'y','LineWidth',1)
hold on
plot(t(t_start:t_end),path(4, t_start:t_end, dnum),'c','LineWidth',1)
hold on
plot(t(t_start:t_end),path(5, t_start:t_end, dnum),'g','LineWidth',1)
hold on
plot(t(t_start:t_end),path(6, t_start:t_end, dnum),'g','LineWidth',1)
hold off

xlabel('t','FontSize',18)
ylabel('Concentration','FontSize',18)
legend('LacI_m','LacI_p','TetR_m','TetR_p','CI_m','CI_p','FontSize',16,'Box','off')

box off
ax = gca;
ax.FontSize = 16;
ax.LineWidth = 1;

%% Coherence
ep = 0.5; % fine-tune the center
Tra1_central = Tra1 - repmat(mean(Tra1,1), [steps,1]) + ep;
Tra2_central = Tra2 - repmat(mean(Tra2,1), [steps,1]) + ep;
Tra_cohe = Tra1_central + Tra2_central * 1i;

gap = 1; % jumping parameter
gap_steps = steps / gap + 1;
Tra_cohe = Tra_cohe(1:gap:steps,:);

for dnum = 1:d_num
    angle_cohe = angle(Tra_cohe(2:end, dnum)) - angle(Tra_cohe(1:end-1, dnum));
    angle_cohe = mod(angle_cohe, 2*pi) - pi;

    angle_cohe_abs = abs(angle_cohe);
    angle_cohe(angle_cohe<0) = 0;
    Cohe(bnum,dnum) = 2 * sum(angle_cohe) / sum(angle_cohe_abs) - 1;
end

%% Landscape and Flux Intloop
size_land = 101;
start = 0.1; % calculate rate
land_LE = zeros(size_land,size_land,d_num);
land_Approx = zeros(size_land,size_land,d_num);

%%% the following calculation in this section is independent of the noise

% 2-dim Gaussian projection
Phi = ones(length(Time_flo_deter),1) / length(Time_flo_deter); % weighted summation

V = zeros(6,2); % dimension selection
V(obj1,1) = 1;
V(obj2,2) = 1;

Sigma = zeros(6,6,length(Time_flo_deter));
for i = 1:length(Time_flo_deter) 
    Sigma(:,:,i) = reshape(x_deter_var(i,:),6,6);
end

% Langevin lattice
min_land_x = min(x_deter(:,obj1),[],'all');
max_land_x = max(x_deter(:,obj1),[],'all');
range_x = max_land_x - min_land_x;
axis_x = linspace(min_land_x,max_land_x,size_land);

min_land_y = min(x_deter(:,obj2),[],'all');
max_land_y = max(x_deter(:,obj2),[],'all');
range_y = max_land_y - min_land_y;
axis_y = linspace(min_land_y,max_land_y,size_land);

Grid_x = floor( (x_deter(:,obj1)-min_land_x)/range_x * (size_land-1)) +1;
Grid_y = floor( (x_deter(:,obj2)-min_land_y)/range_y * (size_land-1)) +1;

% deterministic drift force and limit cycle for Flux_intloop's calculation
f_fint = force_limit6(0,x_deter(1:end-1,:),a,b);
F_fint = f_fint([obj1,obj2],:);
dl = x_deter(2:end,1:2) - x_deter(1:end-1,1:2);
L_cycle(bnum) = sum(vecnorm(dl.',2),'all');

% LE Landscape
for dnum = 1:d_num
    [land_LE_sub,~,~] = histcounts2(Tra1(int32(start*steps):steps,dnum),...
        Tra2(int32(start*steps):steps,dnum),...
        linspace(min_land_x,max_land_x,size_land+1),linspace(min_land_y,max_land_y,size_land+1));
    land_LE_sub = land_LE_sub / sum(land_LE_sub,'all') / (range_x * range_y / (size_land-1)^2);
    land_LE(:,:,dnum) = land_LE_sub;

% Approximating Landscape
    [land_Approx_sub,Xlim_Approx,Ylim_Approx,land_limit_Approx,~,~]...
        = gaussian_land_dim2(V, D(dnum)*Sigma, x_deter,...
        Phi, min_land_x, min_land_y, max_land_x, max_land_y, size_land);

    land_Approx_sub = land_Approx_sub / (range_x * range_y / (size_land-1)^2);
    % normalization
    land_Approx(:,:,dnum) = land_Approx_sub;

% Flux Intloop
    P_fint = diag(land_LE_sub(Grid_y,Grid_x));
    dFluxint = P_fint(1:end-1) .* diag(dl * F_fint);
    Flux_int(bnum,dnum) = sum(abs(dFluxint),'all');
end

end

%% Figure of multi-factors (Figures 2C,D,E)
% Figure of landscape
sample_D = d_num;
[X,Y]=meshgrid(axis_x,axis_y);

figure()
surf(X,Y,land_LE(:,:,sample_D))
shading interp;
hold on
scatter3(x_deter(:,obj1),x_deter(:,obj2),P_fint,3,'r','filled')

% xlim([0,15]);
% ylim([0,15]);
xlabel('LacI','FontSize',14)
ylabel('TetR','Fontsize',14)
zlabel('P','FontSize',14)
view(59,49)

% [X,Y]=meshgrid(linspace(0,8,101),linspace(0,8,101));
figure()
surf(X,Y,land_Approx(:,:,sample_D))
shading interp;
% xlim([0,8]);
% ylim([0,8]);
xlabel('LacI','FontSize',14)
ylabel('TetR','Fontsize',14)
zlabel('P','FontSize',14)
view(59,49)

figure() % trajectory

t_start = 50000;
t_end = 55000;

dnum = 1;

subplot(1,2,1)
plot(t(t_start:t_end),Tra1_central(t_start:t_end, dnum),'b','LineWidth',1)
hold on
plot(t(t_start:t_end),Tra2_central(t_start:t_end, dnum),'r','LineWidth',1)
hold off

xlabel('t','FontSize',18)
ylabel('Concentration','FontSize',18)
legend('LacI','TetR','FontSize',16,'Box','off')

subplot(1,2,2)
plot(Tra1(t_start:t_end, dnum),Tra2(t_start:t_end, dnum),'m','LineWidth',1)
hold on
plot(x_deter(:,obj1),x_deter(:,obj2),'color',[1,0.6,0],'LineStyle','-.','LineWidth',2.5)
hold on
scatter(mean(Tra1(:,dnum),1)-ep,mean(Tra2(:,dnum),1)-ep,15,'k','filled') % coherence 观测点
hold off
xlabel('LacI','FontSize',18)
ylabel('TetR','FontSize',18)
legend('Phase','Limit Cycle','FontSize',16,'Box','off')

box off
ax = gca;
ax.FontSize = 16;
ax.LineWidth = 1;

figure()
surf(D_axis, B_axis, Cohe.','FaceAlpha',1)
shading interp
colormap jet
cbar = colorbar;
cbar.Label.String = 'Coherence';
cbar.Label.FontSize = 16;

xlabel('Noise','FontSize',14);
ylabel('mRNA decay rate','FontSize',14);
zlabel('Coherence','FontSize',14);
xlim([min(D),max(D)]);
ylim([min(B),max(B)]);
zlim([0,1]);
view(0,90);

ax = gca;
ax.FontSize = 16;
ax.LineWidth = 1;
ax.XGrid = 'on';
ax.YGrid = 'on';
ax.ZGrid = 'on';

figure()
surf(D_axis, B_axis, Flux_int.','FaceAlpha',1)
shading interp
colormap jet
cbar = colorbar;
cbar.Label.String = 'Flux Intloop';
cbar.Label.FontSize = 16;

xlabel('Noise','FontSize',14);
ylabel('mRNA decay rate','FontSize',14);
zlabel('Flux Intloop','FontSize',14);
xlim([min(D),max(D)]);
ylim([min(B),max(B)]);
% zlim([0,1]);
view(0,90);

ax = gca;
ax.FontSize = 16;
ax.LineWidth = 1;
ax.XGrid = 'on';
ax.YGrid = 'on';
ax.ZGrid = 'on';

%% Figure of a single factor -- mRNA decay rate 
dnum = randi(d_num);
% cent1 = mean(Cohe(:,dnum));
% cent2 = mean(Flux_int(:,dnum));
cent1 = Cohe(2,dnum);
cent2 = Flux_int(2,dnum);
cen_Cohe = (Cohe(:,dnum)-cent1)./cent1;
cen_Flux = (Flux_int(:,dnum)-cent2)./cent2;
% cen_Cohe = Cohe(:,dnum);
% cen_Flux = Flux_int(:,dnum);

LS_axis = linspace(-1,1,1000);
LS = polyfit(cen_Cohe,cen_Flux,1); % least square
LS_val = polyval(LS,LS_axis);

figure()
subplot(2,2,1)
plot(B,Cohe(:,dnum),'bo-','LineWidth',1.5,'MarkerFaceColor','b','MarkerSize',4)
xlabel('mRNA decay rate')
ylabel('Coherence')

ax = gca;
ax.FontSize = 16;
ax.LineWidth = 1;
ax.XGrid = 'on';
ax.YGrid = 'on';
ax.XLim = [0,max(B,[],'all')];
% ax.YLim = [0,1];
ax.XTick = 0:max(B,[],'all')/4:max(B,[],'all');
% ax.YTick = 0:0.25:1;

subplot(2,2,2)
plot(B,Flux_int(:,dnum),'mo-','LineWidth',1.5,'MarkerFaceColor','m','MarkerSize',4)
xlabel('mRNA decay rate')
ylabel('Flux_{Intloop}')

ax = gca;
ax.FontSize = 16;
ax.LineWidth = 1;
ax.XGrid = 'on';
ax.YGrid = 'on';
ax.XLim = [0,max(B,[],'all')];
% ax.YLim = [0,1];
ax.XTick = 0:max(B,[],'all')/4:max(B,[],'all');
% ax.YTick = 0:0.25:1;

subplot(2,2,[3 4])
scatter(cen_Cohe,cen_Flux,40,[1 0.5 0])
hold on
plot(LS_axis,LS_val,'Color',[0.9 0 0],'LineWidth',1.5)
hold off
xlabel('\Delta Coherence','Interpreter','tex')
ylabel('\Delta Flux_{Intloop}','Interpreter','tex')

ax = gca;
ax.FontSize = 16;
ax.LineWidth = 1;
ax.XGrid = 'on';
ax.YGrid = 'on';

%% Function
function F = force_limit6(~,x,a,b) % force

    a0=1e-3*a;
    n=2;

    F=zeros(size(x,1),6);
    F(:,1) = -x(:,1)+a./(1+x(:,6).^n)+a0;
    F(:,2) = -b*(x(:,2)-x(:,1));
    F(:,3) = -x(:,3)+a./(1+x(:,2).^n)+a0;
    F(:,4) = -b*(x(:,4)-x(:,3));
    F(:,5) = -x(:,5)+a./(1+x(:,4).^n)+a0;
    F(:,6) = -b*(x(:,6)-x(:,5));

    F = F.'; % matrix with size: 6 * size(x,1)
    
end

function dx = ode_cov(~,x,a,b)
% expectation
x1 = x(1); x2 = x(2); x3 = x(3);
x4 = x(4); x5 = x(5); x6 = x(6);

n=2;
a0=1e-3*a;

dx(1) = -x1+a/(1+x6^n)+a0;
dx(2) = -b*(x2-x1);
dx(3) = -x3+a/(1+x2^n)+a0;
dx(4) = -b*(x4-x3);
dx(5) = -x5+a/(1+x4^n)+a0;
dx(6) = -b*(x6-x5);

A = [-1,0,0,0,0,-a*2*x6/(1+x6^n)^2;
    b,-b,0,0,0,0;
    0,-a*2*x2/(1+x2^n)^2,-1,0,0,0;
    0,0,b,-b,0,0;
    0,0,0,-a*2*x4/(1+x4^n)^2,-1,0;
    0,0,0,0,b,-b];

% covariance
x_sig = reshape(x(7:end), 6, 6);
weak=x_sig * A' + A * x_sig + 2*eye(6);

% weak correlation assumption

for i =1:6
    for j=1:6
        if i~=j
            weak(i,j)=0;
        end
    end
end

dx = [dx(:); reshape(weak, 36, 1)];
end
