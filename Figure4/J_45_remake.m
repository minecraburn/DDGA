function J = force_45(x,Jac_45_dim,kks,sm)
if(~exist('kks','var'))
    kks = 0;  % 如果未出现该变量，则对其进行赋值
end
if(~exist('sm','var'))
    sm=0.001;  % 如果未出现该变量，则对其进行赋值
end

GF = 0.5; Kagf = 0.1; kdap1 = 0.15; eps = 17; vsap1 = 1;
kde2f = 0.002; kde2fp = 1.1; kdprb = 0.01; kdpRBp = 0.06; kdpRBpp = 0.04;
kpc1 = 0.05; kpc2 = 0.5; kpc3 = 0.025; kpc4 = 0.5;
K1 = 0.1 ; K2 = 0.1 ; K3 = 0.1; K4 = 0.1 ;
V1 = 2.2; V2 = 2; V3 = 1; V4 = 2;
K1e2f = 5 ; K2e2f = 5 ; V1e2f = 4; V2e2f = 0.75 ; vse2f = 0.15 ;
vsprb = 0.8 ;
Cdk4tot = 1.5 ; Ki7 = 0.1 ; Ki8 = 2 ; kcd1 = 0.4 ; kcd2 = 0.005 ;
kdecom1 = 0.1 ; kcom1 = 0.175 ; kc1 = 0.15 ; kc2 = 0.05 ;
kddd = 0.005 ; Kdd = 0.1 ; K1d = 0.1 ; K2d = 0.1 ; Vdd = 5; Vm1d = 1;
Vm2d = 0.2;
ae = 0.25; Cdk2tot = 2; ib1 = 0.5; Ki9 = 0.1; Ki10 = 2; kce = 0.29;
kc3 = 0.2 ; kc4 = 0.1 ; kdecom2 = 0.1 ; kcom2 = 0.2 ; kdde = 0.005 ;
kddskp2 = 0.005 ;
kdpe = 0.075 ; kdpei = 0.15 ; Kde = 0.1 ; Kdceskp2 = 2 ; Kdskp2 = 0.5 ; Kcdh1 = 0.4 ;
K1e = 0.1 ; K2e = 0.1 ; K5e = 0.1 ; K6e = 0.1 ; Vde = 3 ; Vdskp2 = 1.1 ;
Vm1e = 2 ; Vm2e = 1.4 ; Vm5e = 5 ; V6e = 0.8 ; vspei = 0.13 ; vsskp2 = 0.15 ;
xe1 = 1; xe2 = 1;
aax = 0.2 ; ib2 = 0.5 ; Ki11 = 0.1 ; Ki12 = 2 ; Ki13 = 0.1 ; Ki14 = 2 ;
kca = 0.0375 ; kdecom3 = 0.1 ; kcom3 = 0.2 ;
kc5 = 0.15 ; kc6 = 0.125 ; kdda = 0.005 ; kddp27 = 0.06 ; kddp27p = 0.01 ;
kdcdh1a = 0.1 ; kdcdh1i = 0.2 ; kdpa = 0.075 ; kdpai = 0.15 ; Kda = 1.1 ; Kdp27p = 0.1 ;
Kdp27skp2 = 0.1 ; Kacdc20 = 2 ;
K1a = 0.1 ; K2a = 0.1 ; K1cdh1 = 0.01 ; K2cdh1 = 0.01 ;
K5a = 0.1 ; K6a = 0.1 ; K1p27 = 0.5 ; K2p27 = 0.5 ; Vdp27p = 5 ;
Vda = 2.5 ; Vm1a = 2 ; Vm2a = 1.85 ; Vm5a = 4 ; V6a = 1; vscdh1a = 0.11; vspai = 0.105 ;
vs1p27 = 0.8 ; vs2p27 = 0.1 ; V1cdh1 = 1.25 ; V2cdh1 = 8 ; V1p27 = 100 ; V2p27 = 0.1 ;
xa1 = 1; xa2 = 1;
ab = 0.11 ; Cdk1tot = 0.5 ;
ib = 0.75 ; ib3 = 0.5 ; kc7 = 0.12 ; kc8 = 0.2; kdecom4 = 0.1 ; kcom4 = 0.25 ;
kdcdc20a = 0.05 ; kdcdc20i = 0.14 ; kddb = 0.005 ; kdpb = 0.1 ; kdpbi = 0.2 ;
kdwee1 = 0.1 ; kdwee1p = 0.2 ; Kdb = 0.005 ; Kdbcdc20 = 0.2 ; Kdbcdh1 = 0.1;
ksw = 5 ; K1b = 0.1 ; K2b = 0.1 ; K3b = 0.1 ; K4b = 0.1 ; K5b = 0.1 ; K6b = 0.1 ; K7b = 0.1 ; K8b = 0.1 ; vcb = 0.05 ; Vdb = 0.06 ; Vm1b = 3.9 ; Vm2b = 2.1 ;
vscdc20i = 0.1 ; Vm3b = 8; Vm4b = 0.7 ; Vm5b = 5 ; V6b = 1 ; Vm7b = 1.2 ; Vm8b = 1 ; vspbi = 0.12 ; vswee1 = 0.06 ; xb1 = 1; xb2 = 1;
ATRtot = 0.5 ; Chk1tot = 0.5 ; Cdc45tot = 0.5 ;
kaatr = 0.022;
kdatr = 0.15 ; kdpol = 0.2 ;
kdprim = 0.15 ; kspol = 0.8 ; ksprim = 0.05 ; K1cdc45 = 0.02 ; K2cdc45 = 0.02 ;
K1chk = 0.5 ; K2chk = 0.5 ; Poltot = 0.5 ; V1cdc45 = 0.8 ; V2cdc45 = 0.12 ; V1chk = 4 ; V2chk = 0.1 ;

if kks == 1
    vsap1 = vsap1*(1 + sm);
end
if kks == 2
    vse2f = vse2f*(1 + sm);
end
if kks == 3
    vsprb = vsprb*(1 + sm);
end
if kks == 4
    vspei = vspei*(1 + sm);
end% (*cdc25,n*)
if kks == 5
    vsskp2 = vsskp2*(1 + sm);
end
if kks == 6
    vscdh1a = vscdh1a*(1 + sm);
end% (*cdh1*)
if kks == 7
    vspai = vspai*(1 + sm);
end % (*cdc25,n*)
if kks == 8
    vs1p27 = vs1p27*(1 + sm);
end
if kks == 9
    vs2p27 = vs2p27*(1 + sm);
end
if kks == 10
    vcb = vcb*(1 + sm);
end
if kks == 11
    vscdc20i = vscdc20i*(1 + sm);
end % (*cdc20*)
if kks == 12
    vspbi = vspbi*(1 + sm);
end% (*cdc25,n*)
if kks == 13
    vswee1 = vswee1*(1 + sm);
end% (**wee1,n*)

if kks == 14
    kcd1 = kcd1*(1 + sm);
end % (**CycD induced by AP1**)
if kks == 15
    kcd2 = kcd2*(1 + sm);
end % (**CycD induced by E2F**)
if kks == 16
    kcom1 = kcom1*(1 + sm);
end% (**CycD bind Cdk4,6**)
if kks == 17
    kc1 = kc1*(1 + sm);
end % (**CycD/Cdk4,6 bind p27**)
if kks == 18
    kce = kce*(1 + sm);
end% (**CycE synthesis induced by E2F**)
if kks == 19
    kc3 = kc3*(1 + sm);
end% (**CycE/Cdk2 bind p27**)
if kks == 20
    kcom2 = kcom2*(1 + sm);
end % (**CycE bind Cdk2**)
if kks == 21
    kcom3 = kcom3*(1 + sm);
end% (**CycA bind Cdk2**)
if kks == 22
    kc5 = kc5*(1 + sm);
end% (**CycA/Cdk2 bind p27**)
if kks == 23
    kc7 = kc7*(1 + sm);
end% (**CycB/Cdk1 bind p27**)
if kks == 24
    kcom4 = kcom4*(1 + sm);
end% (**CycB bind Cdk1**)

if kks == 25
    Ki7 = Ki7*(1 + sm);
end% (**CycD inhibited by pRB**)
if kks == 26
    Ki9 = Ki9*(1 + sm);
end% (**CycE inhibited by pRB**)
if kks == 27
    Ki11 = Ki11*(1 + sm);
end% (**CycA inhibited by pRB**)
if kks == 28
    Ki13 = Ki13*(1 + sm);
end% (**p27 inhibited by pRB**)
if kks == 29
    Vm1a = Vm1a*(1 + sm);
end% (**Cdc25 activate CycA/Cdk2**)
if kks == 30
    Vm2a = Vm2a*(1 + sm);
end% (**Wee1 inhibit CycA/Cdk2**)
if kks == 31
    Vm5a = Vm5a*(1 + sm);
end% (**CycA/Cdk2 activat Pa Cdc25**)
if kks == 32
    V2cdh1 = V2cdh1*(1 + sm);
end% (**CycA/Cdk2 and CycB/Cdk1 inhibit Cdh1**)
if kks == 33
    V1p27 = V1p27*(1 + sm);
end% (**CycE/Cdk2 inhibit p27**)
if kks == 34
    Vm1b = Vm1b*(1 + sm);
end% (**Cdc25 activate CycB/Cdk1**)
if kks == 35
    Vm2b = Vm2b*(1 + sm);
end% (**Wee1 inhibit CycB/Cdk1**)
if kks == 36
    vscdc20i = vscdc20i*(1 + sm);
end% (**Cdc20(i)**)
if kks == 37
    Vm3b = Vm3b*(1 + sm);
end% (**CycB/Cdk1 activate Cdc20**)
if kks == 38
    Vm5b = Vm5b*(1 + sm);
end% (**CycB/Cdk1 activate Cdc25**)
if kks == 39
    Vm7b = Vm7b*(1 + sm);
end% (**CycB/Cdk1 inhibit wee1**)
if kks == 40
    V1cdc45 = V1cdc45*(1 + sm);
end% (**CycE/Cdk2 activate Cdc45**)
if kks == 41
    V1chk = V1chk*(1 + sm);
end% (**ATR activate Chk1**)

AP1 = x(1,:);
pRB = x(2,:);
pRBc1 = x(3,:);
pRBp = x(4,:);
pRBc2 = x(5,:);
pRBpp = x(6,:);
E2F = x(7,:);
E2Fp = x(8,:);
Cd = x(9,:);
Mdi = x(10,:);
Md = x(11,:);
Mdp27 = x(12,:);
Ce = x(13,:);
Mei = x(14,:);
Me = x(15,:);
Skp2 = x(16,:);
Mep27 = x(17,:);
Pei = x(18,:);
Pe = x(19,:);
Ca = x(20,:);
Mai = x(21,:);
Ma = x(22,:);
Map27 = x(23,:);
p27 = x(24,:);
p27p = x(25,:);
Cdh1i = x(26,:);
Cdh1a = x(27,:);
Pai = x(28,:);
Pa = x(29,:);
Cb = x(30,:);
Mbi = x(31,:);
Mb = x(32,:);
Mbp27 = x(33,:);
Cdc20i = x(34,:);
Cdc20a = x(35,:);
Pbi = x(36,:);
Pb = x(37,:);
Wee1= x(38,:);
Wee1p = x(39,:);
Cdc45 = x(40,:);
Pol = x(41,:);
Primer = x(42,:);
ATR = x(43,:);
Chk1 = x(44,:);
Mw = 0;

num_x=size(x);
num_x=num_x(2);
J=zeros(num_x,44,44);
%***********************************)
for i=1:44
    for j=1:44
        J(:,i,j)=eval(Jac_45_dim(i,j));
    end
end
end

