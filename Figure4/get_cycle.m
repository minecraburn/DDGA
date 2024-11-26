function [period,periodnum,xall] = get_cycle(xini,n0,delt,parnum)
period=zeros(1,40);
dim=size(xini);
dim=dim(1);
xall=zeros(50000,dim);

x0=xini;
step_n=2*n0/delt;
x=zeros(step_n,dim);
for t=1:1:step_n
    dx=force_45_remake(x0,parnum);
    x0=max(x0+dx*delt,0);
    x(t,:)=x0;
end
i=0;
for t=101:100:step_n-102
    if x(t+100,15) < x(t,15) && x(t-100,15) < x(t,15)
        period(i+1)=t*delt;
        i=i+1;
    end
end
periodnum=i;

xall(1:period(i)/delt+50-period(i-1)/delt+1,:)=x(period(i-1)/delt:period(i)/delt+50,:);