%% Calculating the landscape by WSGA
clear;close all;clc
%% Solve the moment equations (this may take a long time, maybe 20min)
start = [0.01, 1, 0.25, 0.1, 0.01, 0.01, 0.1, 0.05, 0.01, 0.01, 0.01,...
    0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01,...
    0.01, 0.25, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01,...
    0.01, 0.01, 0.01, 0.01, 0.1, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01];
[t0,y_deter] = ode45(@(t,x) force_45_remake(x),[0 200],start);
[M,l] = findpeaks(y_deter(:,15));

l = l(M>0.4);
Temp = t0(l);
Temp = diff(Temp);
T1 = t0(l(end-2));
T2 = t0(l(end-1)); % find the period
T = T2 - T1;
dim = 44;
t = (0:0.03:T).';

tic
load ini_period.mat
[~,moment] = ode15s(@(t,x) [2 * Phi(x(dim+1:2*dim)).*x(1:dim) + 2 ; force_45_remake( x(dim+1:2*dim) )] , 0:0.03:T, ini_period);
%%% moment = [covariance;expectation]
toc

S1 = moment(:,1:dim); % covariance
S2 = moment(:,dim+1:2*dim); % trajectory/expectation

Sigma = zeros(dim,dim,length(t));
for i = 1:length(t)
    Sigma(:,:,i) = diag(S1(i,:));
end

phi = [diff(t);0];
phi = phi / sum(phi); % weighted function

%% landscape (display the landscape by WSGA, i.e. Figure 3C)
label1 = 15;
label2 = 22;

V = zeros(44,2); % dimension selection
V(label1,1) = 1;
V(label2,2) = 1;
u1 = 0; v1 = 0.6; u2 = 0; v2 = 0.6; 
D = 0.1; % noise strength

tic
[Land,Xlim,Ylim,Land_limit,Land_peaks,xgrid,ygrid] = gaussian_land_dim2(V, D*Sigma, S2, phi, u1, u2, v1, v2, 201);
toc
threshold = 13.65;
Land = min(Land,threshold);
Land_limit = min(Land_limit,threshold);

c1 = Land_peaks(1); % G2 checkpoint
c2 = Land_peaks(end); % G1 checkpoint
c3 = Land_peaks(2); % M phase
c4 = Land_peaks(end-1); %G0/G1 phase
[~,Land_peaks_lim] = findpeaks(-Land_limit);
c5 = Land_peaks_lim(end); % S/G2 phase

xgrid_trun = xgrid(1:10:end,1:10:end);
ygrid_trun = ygrid(1:10:end,1:10:end);
Land_trun = Land(1:10:end,1:10:end);

figure()

surf(xgrid,ygrid,Land); % landscape
shading interp
colormap("jet")
% colormap("parula")
% colormap("turbo")
xlim([u1,v1])
ylim([u2,v2])
zlim([6,14])
xticks(linspace(u1,v1,7))
yticks(linspace(u2,v2,7))
zticks(linspace(6,14,4))
% xticklabels({'0','','','','','','0.6'})
% yticklabels({'0','','','','','','0.6'})
% zticklabels({'3','','','9'})
xticklabels({})
yticklabels({})
zticklabels({})
view(-45,50)

hold on

ft_matrix = padarray(padarray(0.25*ones(17),[1,1],0.2),[1,1],0); % fine-tune

surf(xgrid_trun,ygrid_trun,Land_trun+ft_matrix,'FaceAlpha',0,'EdgeColor','k')

hold on

plot3(Xlim,Ylim,Land_limit+0.3,'m-','lineWidth',2) % fine-tune

hold on

scatter3(S2([c1,c2],:) * V(:,1), S2([c1,c2],:) * V(:,2), Land_limit([c1,c2])+0.3,100,[0.9290,0.1250,0.1250],'filled');

hold off

%% Function
function Derivate = Phi(x)
    load gx.mat gx
    Derivate = gx(x(2),x(4),x(6),x(7),x(8),x(9),x(10),x(11),x(12),x(13),x(14),x(15),x(16),x(17),x(18),x(19),x(20),x(21),x(22),x(23),x(24),x(25),x(26),x(27),x(28),x(29),x(30),x(31),x(32),x(33),x(34),x(35),x(36),x(37),x(38),x(39),x(40),x(41),x(42),x(43),x(44));
end
