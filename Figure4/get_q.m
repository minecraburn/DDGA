function q = get_q(n0,delT,D,cycle,fx,Hx)
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
q_coe1=gt.^2.*dg*(delT/2);
q_coe2=(delT/2*gt+D/4*dg);
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
tempA6=zeros(n0,n0);%% correspond to q_i-1
tempA7=zeros(n0,n0);%% correspond to q_i+1
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
% min(del_iter)
ind_iter=find(del_iter==min(del_iter));
q=iter_E(:,ind_iter);
q=abs(q);
q=q/sum(q);
q=q+3/n0;
q=q/sum(q);