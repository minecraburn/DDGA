function [pland,pcycle] = get_DDGA_land(n0,dim,D,cycle,q0,orn0,Hx)
all_Sig2=zeros(n0+1,dim,dim);
for i=1:1:n0
    parF2=diag(diag(squeeze(Hx(i,:,:))));
    In=eye(dim);
    tempA=kron(In,parF2')+kron(parF2',In);
    vecb=reshape(-2*D*In,[],1);
    vecSig2=tempA\vecb;
    sig2=reshape(vecSig2,dim,dim);
    all_Sig2(i,:,:)=sig2;
end
q=zeros(n0,1);
for i=1:1:n0
    q(i)=q0(max(1,min(orn0,round(i/n0*orn0))));
end

nea=15;
neb=22;
xsidel=0;xsider=0.5;
ysidel=0;ysider=0.5;
step=0.001;
xla=[xsidel:step:xsider];
yla=[ysidel:step:ysider];
zla1=0*meshgrid(xla,yla);

[xla,yla]=meshgrid(xla,yla);

temp_use1=0;
for k=1:1:n0
    my_Sigma=squeeze(all_Sig2(k,[nea,neb],[nea,neb]));
    inv_Sigma=inv(my_Sigma);
    tpx=xla-cycle(k,nea);
    tpy=yla-cycle(k,neb);
    temp1=tpx.^2*inv_Sigma(1,1)+tpy.^2*inv_Sigma(2,2)+2*tpx.*tpy*inv_Sigma(1,2);
    temp2=exp(-temp1/2);
    temp_use1=temp_use1+1;
    
    temp3=temp2/sqrt(2*pi*det(my_Sigma));
    zla1=zla1+temp3*q(k);
end

p=zla1/sum(sum(zla1));
pland(:,:)=p;



xla2=cycle(:,15);
yla2=cycle(:,22);
zla21=0*xla2;

temp_use1=0;
for k=1:1:n0
    my_Sigma=squeeze(all_Sig2(k,[nea,neb],[nea,neb]));
    inv_Sigma=inv(my_Sigma);
    tpx=xla2-cycle(k,nea);
    tpy=yla2-cycle(k,neb);
    temp1=tpx.^2*inv_Sigma(1,1)+tpy.^2*inv_Sigma(2,2)+2*tpx.*tpy*inv_Sigma(1,2);
    temp2=exp(-temp1/2);
    temp_use1=temp_use1+1;
    temp3=temp2/sqrt(2*pi*det(my_Sigma));
    zla21=zla21+temp3*q(k);
end

pcycle=zeros(1,1000);
pcycle(1:n0+1)=zla21(1:n0+1);