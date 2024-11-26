% This codes will help you reproduce the figure 1 in our article: the KL
% divergence and relative distance. And the visulization of landscape by WSGA,
% DDGA and LE. Since results of EGA have been given in the previous work
% [Bian 2023 Chaos], we omit the part of EGA.

clear;close all;clc

load GA_limit3_Dchange_401new.mat

load LE_limit3_Dchange_401.mat

load DDGA_limit3_Dchange_401.mat

%%
epsilon = 1e-8;

GA_limit3_Dchange = landGA + epsilon; % normalization

DDGA_limit3_Dchange = landDDGA + epsilon; % normalization

LE_limit3_Dchange = land;
LE_limit3_Dchange = LE_limit3_Dchange+epsilon;

%% calculating KL and RD
step = 0.02;
D = [0.005,0.01,0.02,0.05,0.1];
KL1 = zeros(length(D),1); % WSGA
KL2 = zeros(length(D),1); % DDGA
RD1 = zeros(length(D),1);
RD2 = zeros(length(D),1);

for i = 1:length(D)
    KL1(i) = sum(sum(LE_limit3_Dchange(:,:,i).*log(LE_limit3_Dchange(:,:,i)./GA_limit3_Dchange(:,:,i)))); % WSGA||LE
    KL2(i) = sum(sum(LE_limit3_Dchange(:,:,i).*log(LE_limit3_Dchange(:,:,i)./DDGA_limit3_Dchange(:,:,i)))); % DDGA||LE
    
    RD1(i) = norm(GA_limit3_Dchange(:,:,i)-LE_limit3_Dchange(:,:,i),'fro')/norm(LE_limit3_Dchange(:,:,i),'fro');
    RD2(i) = norm(DDGA_limit3_Dchange(:,:,i)-LE_limit3_Dchange(:,:,i),'fro')/norm(LE_limit3_Dchange(:,:,i),'fro');
end

%% Display KL and RD (FIG 1F)

figure()

subplot(1,2,1)
plot(D,KL1,'o-','Color',[0.30,0.75,0.93],'LineWidth',2.5,'MarkerFaceColor','b')
hold on
plot(D,KL2,'o-','Color',[0.49,0.18,0.56],'LineWidth',2.5,'MarkerFaceColor','k')

legend('WSGA','DDGA','Box','off')
xlabel('D','FontSize',14);
ylabel('KL divergence','FontSize',14);
xlim([0, 0.11])
xticks(0:0.02:0.1);
ylim([0, 2.7])
yticks(0:0.9:2.7)
ax = gca;
ax.FontSize = 24;
% ax.Box = 'off';
ax.LineWidth = 2.5;

subplot(1,2,2)
plot(D,RD1,'s-','Color',[0.30,0.75,0.93],'LineWidth',2.5,'MarkerFaceColor','b')
hold on
plot(D,RD2,'s-','Color',[0.49,0.18,0.56],'LineWidth',2.5,'MarkerFaceColor','k')

legend('WSGA','DDGA','Box','off')
xlabel('D','FontSize',14);
ylabel('Relative distence','FontSize',14);
xlim([0, 0.11])
xticks(0:0.02:0.1);
ylim([0, 1.5])
yticks(0:0.5:1.5)
ax = gca;
ax.FontSize = 24;
% ax.Box = 'off';
ax.LineWidth = 2.5;

%% Display the landscape by WSGA, DDGA and LE (FIG 1B,C,E)

figure()
surf(0:step:8, 0:step:8, LE_limit3_Dchange(:,:,3))
shading interp
% xlabel('Lacl','FontSize',14);
% ylabel('TetR','FontSize',14);
% zlabel('P','FontSize',14);
xlim([0, 8])
ylim([0, 8])
xticks([])
yticks([])
view([0, 90]);
ax = gca;
ax.FontSize = 18;

figure()
surf(0:step:8, 0:step:8, GA_limit3_Dchange(:,:,3))
shading interp
% xlabel('Lacl','FontSize',14);
% ylabel('TetR','FontSize',14);
% zlabel('P','FontSize',14);
xlim([0, 8])
ylim([0, 8])
xticks([])
yticks([])
view([0, 90]);
ax = gca;
ax.FontSize = 18;

figure()
surf(0:step:8, 0:step:8, DDGA_limit3_Dchange(:,:,3))
shading interp
% xlabel('Lacl','FontSize',14);
% ylabel('TetR','FontSize',14);
% zlabel('P','FontSize',14);
xlim([0, 8])
ylim([0, 8])
xticks([])
yticks([])
view([0, 90]);
ax = gca;
ax.FontSize = 18;