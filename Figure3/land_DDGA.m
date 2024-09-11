%% This is an example of the application of our methods in an 45-dimensional mammalian cell cycle network systems.
clear;close all;clc

%% Default settings
dim=2;
n0=100;
q=zeros(n0,1);
sigma=zeros(n0,dim,dim);
cycle=zeros(n0,dim);
fx=zeros(n0,dim);
Hx=zeros(n0,dim,dim);
recoe=0.1;
recoe2=1;
method=2;
crossmethod=1;
recoe=1;
recoe2=0.001;
D=0.1;
smooth_type=1;
smn=200;

load Jac_45_dim.mat % the `sym_deri' is needed to run

% y=[0.05   44    1     0.29  0.022  0.1     0.15   17     1      0.002,... %1-10
%    1.1    0.01  0.06  0.04  0.05   0.5     0.025  0.5    0.1    0.1,...   %11-20
%    0.1    0.1   2.2   2     1      2       5      5      4      0.75,...  %21-30
%    0.15   0.8   1.5   0.1   2      0.4     0.005  0.1    0.175  0.15,...  %31-40
%    0.05   0.005 0.1   0.1   0.1    5       1      0.2    0.25   2,...     %41-50
%    0.5    0.1   2     0.2   0.1    0.1     0.2    0.005  0.005  0.075,... %51-60 
%    0.15   0.1   2     0.5   0.4    0.1     0.1    0.1    0.1    3,...     %61-70 
%    1.1    2     1.4   5     0.8    0.13    0.15   1      1      0.2,...   %71-80
%    0.5    0.1   2     0.1   2      0.0375  0.1    0.2    0.15   0.125,... %81-90 
%    0.005  0.06  0.01  0.1   0.2    0.075   0.15   1.1    0.1    0.1,...   %91-100
%    2      0.1   0.1   0.01  0.01   0.1     0.1    0.5    0.5    5 ,...    %101-110
%    2.5    2     1.85  4     1      0.11    0.105  0.8    0.1    1.25,...  %111-120 
%    8      100   0.1   1     1      0.11    0.5    0.75   0.5    0.12,...  %121-130 
%    0.2    0.1   0.25  0.05  0.14   0.005   0.1    0.2    0.1    0.2,...   %131-140 
%    0.005  0.2   0.1   5     0.1    0.1     0.1    0.1    0.1    0.1,...   %141-150 
%    0.1    0.1   0.05  0.06  3.9    2.1     0.1    8      0.7    5,...     %151-160 
%    1      1.2   1     0.12  0.06   1       1      0.5    0.5    0.5,...   %161-170
%    0.15   0.2   0.15  0.8   0.05   0.02    0.02   0.5    0.5    0.5,...   %171-180
%    0.8    0.12  4     0.1   0.5    1       4      0.5    0         ,...   %181-189         
%    ];
%%% y(3) = GF is an important parameter for genetic regulation

xini = [0.01; 1; 0.25; 0.1; 0.01; 0.01; 0.1; 0.05; 0.01; 0.01; 0.01;...
   0.01; 0.01; 0.01; 0.01; 0.01; 0.01; 0.01; 0.01; 0.01; 0.01; 0.01;... 
   0.01; 0.25; 0.01; 0.01; 0.01; 0.01; 0.01; 0.01; 0.01; 0.01; 0.01;... 
   0.01; 0.01; 0.01; 0.01; 0.1; 0.01; 0.01; 0.01; 0.01; 0.01; 0.01];

% method3
delt=0.001;

dim=44;
x0=xini;
x=zeros(2*n0/delt,dim);
for t=1:1:2*n0/delt
    dx=force_45_remake(x0);
    x0=max(x0+dx*delt,0);
    x(t,:)=x0;
end
%% recognizing the limit cycle
left=120000;
le_bound=130000;
olddel=0;
old2del=-1;
del=0;
times=0;
for t=left:1:2000*n0
    del = 0;
    for s = 1:44
        del=del+(x(t,s)-x(left,s))^2;
    end
    if t>le_bound && olddel<old2del && olddel<del && olddel<1e-4
        olddel 
        t-1
        times=times+1;
        if times>25
            break
        end
    end
    old2del=olddel;
    olddel=del;
end
right =148776;
%%
%J_45(x0,y,Jac_45_dim)

%% calculating information of limit cycle

seg_t=50;
left=120000;right =148776;
cycle=x(left:seg_t:right+1,:);
n0=size(cycle);
n0=n0(1)-1;
% fx=zeros(n0+1,dim);
% Hx=zeros(n0+1,dim,dim);
x0=cycle';
fx=force_45_remake(x0)';
Hx=J_45_remake(x0,Jac_45_dim);
%% calculating \Sigma in our formula, this code costs some times (about 1min), so we use load instead
% % % xiuz=zeros(n0+1,1);
% % % all_Sig1=zeros(n0+1,dim,dim);
% % % all_Sig2=zeros(n0+1,dim,dim);
% % % for i=1:1:n0
% % %     temp1=squeeze(fx(i,:));
% % %     temp1=temp1/sqrt(temp1*temp1');
% % %     ok=0;
% % %     while ok==0
% % %         temp2=rand(dim-1,dim);
% % %         temp2=temp2-temp2*temp1'*temp1;
% % %         temp2=orth(temp2')';
% % %         tempn=size(temp2);
% % %         if tempn(1)==dim-1
% % %             ok=1;
% % %         end
% % %     end
% % %     parF=squeeze(Hx(i,:,:));
% % %     parF=temp2*parF*temp2';
% % %     try_cor_num=0;
% % % %     while det(-parF)<0
% % % %         parF=parF-recoe*temp2*temp2';
% % % %         xiuz(i)=1;
% % % %         try_cor_num=try_cor_num+1;
% % % %         if try_cor_num>10
% % % %             break
% % % %         end
% % % %     end
% % %     Inmins1=eye(dim-1);
% % %     tempA=kron(Inmins1,parF')+kron(parF',Inmins1);
% % %     % [tempL,tempU]=lu(tempA);
% % %     vecb=reshape(-2*D*Inmins1,[],1);
% % %     % vecSig=tempU\(tempL\vecb);
% % %     vecSig = tempA\vecb;
% % %     sigless=reshape(vecSig,dim-1,dim-1);
% % %     %     res=parF'*sigless+sigless*parF+2*D*Inmins1;
% % %     sig=temp2'*sigless*temp2;
% % %     parF2=diag(diag(squeeze(Hx(i,:,:))));
% % % %     parF2=temp2*parF2*temp2';
% % % %     while det(-parF2)<0
% % % %         parF=parF-recoe*temp2*temp2';
% % % %         xiuz(i)=1;
% % % %     end
% % %     Inmins1=eye(dim-1);In=eye(dim);
% % %     tempA=kron(In,parF2')+kron(parF2',In);
% % %     % [tempL,tempU]=lu(tempA);
% % %     vecb=reshape(-2*D*In,[],1);
% % %     % vecSig2=tempU\(tempL\vecb);
% % %     vecSig2=tempA\vecb;
% % % %     sigless2=reshape(vecSig2,dim-1,dim-1);
% % %     sig2=reshape(vecSig2,dim,dim);
% % %     %     res=parF'*sigless+sigless*parF+2*D*Inmins1;
% % % %     sig2=temp2'*sigless2*temp2;
% % %     if crossmethod<1.5
% % %     all_Sig1(i,:,:)=sig+recoe2*D*temp1'*temp1;
% % % %     all_Sig2(i,:,:)=sig2+recoe2*D*temp1'*temp1;
% % %     all_Sig2(i,:,:)=sig2;
% % %     else
% % %     all_Sig1(i,:,:)=sig+5*norm(cycle(i+1,:)-cycle(i,:))*temp1'*temp1;
% % %     all_Sig2(i,:,:)=sig2+5*norm(cycle(i+1,:)-cycle(i,:))*temp1'*temp1;
% % %     end
% % % end

load All_Sigma.mat
%% This part calculating the weight q in our formula
% In the real case, some numerical issue may occur (such as 1e-400 = 0 and
% 1+1e-16=1), we provide other approach (method = 2,3,4) for calculating an
% approximation of q. 
method=4;
if method <1.5
    gt=zeros(n0,1);
    intgt2=zeros(n0,1);
    intexp=zeros(n0,1);
    intwhole=zeros(n0,1);
    for i=1:1:n0
        temp1=squeeze(fx(i,:));
        gt(i)=sqrt(temp1*temp1');
        intgt2(i:n0)=intgt2(i:n0)+gt(i)*gt(i)/n0;
        intexp(i)=exp(-intgt2(i)/D);
        intwhole(i:n0)=intwhole(i:n0)+gt(i)*intexp(i)/D/n0;
    end
    C0=(1-intexp(n0))/intwhole(n0);
    q=1./intexp.*(1-C0*intwhole);
    q=q/sum(q);
elseif method < 2.5
    q=zeros(n0,1);
    q(1)=1;
    seg=200;
    segment_t=1:ceil(n0/seg):n0-1;
    seg=size(segment_t);
    seg=seg(2);
    segment_t(seg+1)=n0;
    q_rate=0*segment_t;
    q_rate(1)=1;
    for j=1:seg
        gt=zeros(n0,1);
        intgt2=zeros(n0,1);
        intexp=zeros(n0,1);
        intwhole=zeros(n0,1);
        for i=1:1:n0
            if i>n0-segment_t(j)+1
                temp1=squeeze(fx(i+segment_t(j)-1-n0,:));
            else
                temp1=squeeze(fx(i+segment_t(j)-1,:));
            end
            gt(i)=sqrt(temp1*temp1');
            intgt2(i:n0)=intgt2(i:n0)+gt(i)*gt(i)/n0;
            intexp(i)=exp(-intgt2(i)/D);
            intwhole(i:n0)=intwhole(i:n0)+gt(i)*intexp(i)/D/n0;
        end
        C0=(1-intexp(n0))/intwhole(n0);
        q(segment_t(j):segment_t(j+1))=q(segment_t(j))./intexp(1:segment_t(j+1)-segment_t(j)+1).*(1-C0*intwhole(1:segment_t(j+1)-segment_t(j)+1));
        q=q/sum(q);
    end
elseif method<3.5
    gt=zeros(n0,1);
    for i=1:1:n0
        temp1=squeeze(fx(i,:));
        gt(i)=sqrt(temp1*temp1');
%         q(i)=gt(i);
        q(i)=1;
    end
    q=q/sum(q);
else
    gt=zeros(n0,1);
    dg=zeros(n0,1);
    q_coe1=zeros(n0,1);
    q_coe2=zeros(n0,1);
    for i=1:1:n0
        temp1=squeeze(fx(i,:));
        gt(i)=sqrt(temp1*temp1');
    end
    for i=2:1:n0-1
        dg(i)=gt(i+1)-gt(i-1);
    end
    dg(1)=gt(2)-gt(n0);
    dg(n0)=gt(1)-gt(n0-1);
    q_coe1=gt.^2.*dg*(delt*seg_t/2);
    q_coe2=(delt*seg_t/2*gt+D/4*dg);
    q_coe3=D*gt;
    tempA1=diag(q_coe3);
    tempA2=zeros(n0,n0);
    tempA3=zeros(n0,n0);
    tempA2(2:n0,:)=tempA1(1:n0-1,:);
    tempA2(1,:)=tempA1(n0,:);
    tempA3(:,2:n0)=tempA1(:,1:n0-1);
    tempA3(:,1)=tempA1(:,n0);
    tempA4=diag(q_coe1);
    tempA5=diag(q_coe2);
    tempA6=zeros(n0,n0);%% q_i-1
    tempA7=zeros(n0,n0);%% q_i+1
    tempA6(2:n0,:)=tempA5(1:n0-1,:);
    tempA6(1,:)=tempA5(n0,:);
    tempA7(:,2:n0)=tempA5(:,1:n0-1);
    tempA7(:,1)=tempA5(:,n0);    
%     Left_A=tempA2+tempA3-2*tempA1;
%     Right_A=tempA4+tempA7-tempA6;
    Left_A=tempA2+tempA3-2*tempA1;
    Right_A=tempA4+tempA7-tempA6;
    q=ones(n0,1);
    A_iter=Right_A/Left_A;
    [iter_E,iter_D]=eig(A_iter);
    iter_D=diag(iter_D);
    del_iter=(iter_D-1).*conj(iter_D-1);
    min(del_iter)
    ind_iter=find(del_iter==min(del_iter));
    q=iter_E(:,ind_iter);
    q=abs(q);
    q=q/sum(q);
    q=q+3/n0;
    q=q/sum(q);
end


%% display the landscape by DDGA, i.e. Figure 3D in the paper.

nea=15;
neb=22;
xsidel=0;xsider=0.6;
ysidel=0;ysider=0.6;
num = 201;
xla = linspace(xsidel,xsider,num);
yla = linspace(ysidel,ysider,num);
zla1 = zeros(num);

[xla,yla]=meshgrid(xla,yla);
% xla=cycle(:,nea);
% yla=cycle(:,neb);
% zla1=0*xla;

temp_use1=0;
bad=0;
use_GA=0;
check=zeros(n0,1);
check2=zeros(n0,1);
check3=zeros(n0,3);
for k=1:1:n0
    my_Sigma=squeeze(all_Sig1(k,[nea,neb],[nea,neb]));
%     my_Sigma=[0.001,0;0,0.001];
%     check(k)=det(my_Sigma);
%     check3(k,1)=my_Sigma(1,1);
%     check3(k,2)=my_Sigma(2,1);
%     check3(k,3)=my_Sigma(2,2);
%     if det(my_Sigma)<0  ||my_Sigma(1,1)<0 %|| det(my_Sigma)>1e-6%|| det(my_Sigma)/my_Sigma(1,1)/my_Sigma(1,1) < 2e-2 || det(my_Sigma)/my_Sigma(1,1)/my_Sigma(1,1) > 5e1
%         cor_ok=0;
% %         for try_n=1:1:14
% %              my_Sigma=my_Sigma+0.1*eye(2);
% %              if det(my_Sigma)>0  && my_Sigma(1,1)>0
% %                  cor_ok=1;
% %                  break
% %              end
% %         end
%         check(k)=det(my_Sigma);
%         check3(k,1)=my_Sigma(1,1);
%         check3(k,2)=my_Sigma(2,1);
%         check3(k,3)=my_Sigma(2,2);
%         if cor_ok==0
%             k
%             bad=bad+1;
%             continue;
%         end
% %        while det(my_Sigma)<0  ||my_Sigma(1,1)<0
% %            my_Sigma=my_Sigma+0.1*eye(2);
% %        end
%     end

%     if check(k)>1e-1 || check(k)<1e-9
%         my_Sigma=my_Sigma/sqrt(check(k))/1e2;
%     end
%     check2(k)=det(my_Sigma);
    %if det(my_Sigma)<0  ||my_Sigma(1,1)<0 || det(my_Sigma)/my_Sigma(1,1)/my_Sigma(1,1) < 5e-2 || det(my_Sigma)/my_Sigma(1,1)/my_Sigma(1,1) > 20 %0.05
    if det(my_Sigma)<0  ||my_Sigma(1,1)<0 || det(my_Sigma)/my_Sigma(1,1)/my_Sigma(1,1) < 5e-2 || det(my_Sigma)/my_Sigma(1,1)/my_Sigma(1,1) > 40 %0.1
        my_Sigma=squeeze(all_Sig2(k,[nea,neb],[nea,neb]));
        use_GA=use_GA+1;
    end
    inv_Sigma=inv(my_Sigma);
    tpx=xla-cycle(k,nea);
    tpy=yla-cycle(k,neb);
    temp1=tpx.^2*inv_Sigma(1,1)+tpy.^2*inv_Sigma(2,2)+2*tpx.*tpy*inv_Sigma(1,2);
    temp2=exp(-temp1/2);
    temp_use1=temp_use1+1;
    temp3=temp2;
    temp3=temp2/sqrt(2*pi*det(my_Sigma));
%     temp3=temp3/norm(cycle(k+1,:)-cycle(k,:));
    zla1=zla1+temp3*q(k);
end
% zla1=zla1/temp_use1;

sumzla1 = sum(zla1,'all'); % cycle normalization
zla1 = zla1 / sumzla1;
zla = min(-log(zla1),13.7);
% zla=zla1/sum(sum(zla1));

% plot3(xla,yla,zla1);
% hold on
% use_GA
% bad
% plot3(cycle(:,nea),cycle(:,neb),0*cycle(:,nea)+400);
% scatter3(cycle(250,nea),cycle(250,neb),100);
% plot3(cycle(:,nea),cycle(:,neb),cycle(:,25));
% plot3(cycle(:,nea),cycle(:,neb),0*cycle(:,neb)+10);
% % hold on
% plot3(cycle(92:234,nea),cycle(92:234,neb),0*cycle(92:234,neb)+10);
% xlabel("x1");
% ylabel("x2");
% figure(10);
% figure(10)
% check=zeros(n0,1);
% for i=1:1:n0
%     check(i)=norm(cycle(i+1,:)-cycle(i,:));
% end
% plot([1:n0],check);
p=zla1/sum(sum(zla1));
la=zla/sum(sum(zla));

%%
temp_use1=0;
xla2=cycle(:,15);
yla2=cycle(:,22);
zla22=0*xla2;
for k=1:1:n0
    my_Sigma=squeeze(all_Sig1(k,[nea,neb],[nea,neb]));
    %if det(my_Sigma)<0  ||my_Sigma(1,1)<0 || det(my_Sigma)/my_Sigma(1,1)/my_Sigma(1,1) < 5e-2 || det(my_Sigma)/my_Sigma(1,1)/my_Sigma(1,1) > 20 %0.05
    if det(my_Sigma)<0  ||my_Sigma(1,1)<0 || det(my_Sigma)/my_Sigma(1,1)/my_Sigma(1,1) < 5e-2 || det(my_Sigma)/my_Sigma(1,1)/my_Sigma(1,1) > 40 %0.1
        my_Sigma=squeeze(all_Sig2(k,[nea,neb],[nea,neb]));
    end
    inv_Sigma=inv(my_Sigma);
    tpx2=xla2-cycle(k,nea);
    tpy2=yla2-cycle(k,neb);
    temp12=tpx2.^2*inv_Sigma(1,1)+tpy2.^2*inv_Sigma(2,2)+2*tpx2.*tpy2*inv_Sigma(1,2);
    temp22=exp(-temp12/2);
    temp32=temp22;
    temp32=temp22/sqrt(2*pi*det(my_Sigma));
%     temp3=temp3/norm(cycle(k+1,:)-cycle(k,:));
    zla22=zla22+temp32*q(k);
end

zla22 = zla22 / sumzla1;
zla2=-log(zla22);


%% truncation

x_trun = xla(1:10:end,1:10:end);
y_trun = yla(1:10:end,1:10:end);
z_trun = zla(1:10:end,1:10:end);
%%

figure()

surf(xla,yla,zla)
shading interp
colormap('jet')
zlim([6,14])
xticks(linspace(0,0.6,7))
yticks(linspace(0,0.6,7))
zticks(linspace(6,14,4))
xticklabels({})
yticklabels({})
zticklabels({})
view(-45,50)

hold on

ft_matrix = padarray(padarray(0.3*ones(17),[1,1],0.2),[1,1],0); % fine-tune

surf(x_trun,y_trun,z_trun+ft_matrix,'FaceAlpha',0,'EdgeColor','k')

hold on

plot3(xla2,yla2,zla2+0.4,'m-','LineWidth',2);
for i=1:1:574
    if zla2(i+1)>zla2(i) && zla2(i+1)>zla2(i+2)
        i
    end
end
[74,225,454,508]; %0.05
[78,227,454,498]; %0.1
% scatter3(xla2([30,160,300,465]),yla2([30,160,300,465]),zla2([30,160,300,465])+0.2,100,[1,0.8,0],'filled');
scatter3(xla2([227,454,498])-0.004,yla2([227,454,498])-0.004,zla2([227,454,498])+[0.4;0.4;0.4],100,[1,0.8,0],'filled');

zla2([78,227,454,498])
