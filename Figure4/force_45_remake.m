function F = force_45_remake(x,kks,sm)
if(~exist('kks','var'))
    kks = 0;  % 如果未出现该变量，则对其进行赋值
end
if(~exist('sm','var'))
    sm=0.001;  % 如果未出现该变量，则对其进行赋值
end


n0=size(x);
n0=n0(2);
F = zeros(44,n0);

%     dddd = y(1);
%     nnnn = y(2);
%     GF = y(3);
%     kce = y(4);
%     kaatr = y(5);
%     Kagf = y(6);
%     kdap1 = y(7);
%     eps = y(8);
%     vsap1 = y(9);
%     kde2f = y(10);
%     kde2fp = y(11);
%     kdprb = y(12);
%     kdpRBp = y(13);
%     kdpRBpp = y(14);
%     kpc1 = y(15);
%     kpc2 = y(16);
%     kpc3 = y(17);
%     kpc4 = y(18);
%     K1 = y(19);
%     K2 = y(20);
%     K3 = y(21);
%     K4 = y(22);
%     V1 = y(23);
%     V2 = y(24);
%     V3 = y(25);
%     V4 = y(26);
%     K1e2f = y(27);
%     K2e2f = y(28);
%     V1e2f = y(29);
%     V2e2f = y(30);
%     vse2f = y(31);
%     vsprb = y(32);
%     Cdk4tot = y(33);
%     Ki7 = y(34);
%     Ki8 = y(35);
%     kcd1 = y(36);
%     kcd2 = y(37);
%     kdecom1 = y(38);
%     kcom1 = y(39);
%     kc1 = y(40);
%     kc2 = y(41);
%     kddd = y(42);
%     Kdd = y(43);
%     K1d = y(44);
%     K2d = y(45);
%     Vdd = y(46);
%     Vm1d = y(47);
%     Vm2d = y(48);
%     ae = y(49);
%     Cdk2tot = y(50);
%     ib1 = y(51);
%     Ki9 = y(52);
%     Ki10 = y(53);
%     kc3 = y(54);
%     kc4 = y(55);
%     kdecom2 = y(56);
%     kcom2 = y(57);
%     kdde = y(58);
%     kddskp2 = y(59);
%     kdpe = y(60);
%     kdpei = y(61);
%     Kde = y(62);
%     Kdceskp2 = y(63);
%     Kdskp2 = y(64);
%     Kcdh1 = y(65);
%     K1e = y(66);
%     K2e = y(67);
%     K5e = y(68);
%     K6e = y(69);
%     Vde = y(70);
%     Vdskp2 = y(71);
%     Vm1e = y(72);
%     Vm2e = y(73);
%     Vm5e = y(74);
%     V6e = y(75);
%     vspei = y(76);
%     vsskp2= y(77);
%     xe1 = y(78);
%     xe2 = y(79);
%     aax = y(80);
%     ib2 = y(81);
%     Ki11 = y(82);
%     Ki12 = y(83);
%     Ki13 = y(84);
%     Ki14 = y(85);
%     kca = y(86);
%     kdecom3 = y(87);
%     kcom3 = y(88);
%     kc5 = y(89);
%     kc6 = y(90);
%     kdda = y(91);
%     kddp27 = y(92);
%     kddp27p = y(93);
%     kdcdh1a = y(94);
%     kdcdh1i = y(95);
%     kdpa = y(96);
%     kdpai = y(97);
%     Kda = y(98);
%     Kdp27p = y(99);
%     Kdp27skp2 = y(100);
%     Kacdc20 = y(101);
%     K1a = y(102);
%     K2a = y(103);
%     K1cdh1 = y(104);
%     K2cdh1 = y(105);
%     K5a = y(106);
%     K6a = y(107);
%     K1p27 = y(108);
%     K2p27 = y(109);
%     Vdp27p = y(110);
%     Vda = y(111);
%     Vm1a = y(112);
%     Vm2a = y(113);
%     Vm5a = y(114);
%     V6a = y(115);
%     vscdh1a = y(116);
%     vspai = y(117);
%     vs1p27 = y(118);
%     vs2p27 = y(119);
%     V1cdh1 = y(120);
%     V2cdh1 = y(121);
%     V1p27 = y(122);
%     V2p27 = y(123);
%     xa1 = y(124);
%     xa2 = y(125);
%     ab = y(126);
%     Cdk1tot = y(127);
%     ib = y(128);
%     ib3 = y(129);
%     kc7 = y(130);
%     kc8 = y(131);
%     kdecom4 = y(132);
%     kcom4 = y(133);
%     kdcdc20a = y(134);
%     kdcdc20i = y(135);
%     kddb = y(136);
%     kdpb = y(137);
%     kdpbi = y(138);
%     kdwee1 = y(139);
%     kdwee1p = y(140);
%     Kdb = y(141);
%     Kdbcdc20 = y(142);
%     Kdbcdh1 = y(143);
%     ksw = y(144);
%     K1b = y(145);
%     K2b = y(146);
%     K3b = y(147);
%     K4b = y(148);
%     K5b = y(149);
%     K6b = y(150);
%     K7b = y(151);
%     K8b = y(152);
%     vcb = y(153);
%     Vdb = y(154);
%     Vm1b = y(155);
%     Vm2b = y(156);
%     vscdc20i = y(157);
%     Vm3b = y(158);
%     Vm4b = y(159);
%     Vm5b = y(160);
%     V6b = y(161);
%     Vm7b = y(162);
%     Vm8b = y(163);
%     vspbi = y(164);
%     vswee1 = y(165);
%     xb1 = y(166);
%     xb2 = y(167);
%     ATRtot = y(168);
%     Chk1tot = y(169);
%     Cdc45tot = y(170);
%     kdatr = y(171);
%     kdpol = y(172);
%     kdprim = y(173);
%     kspol = y(174);
%     ksprim = y(175);
%     K1cdc45 = y(176);
%     K2cdc45 = y(177);
%     K1chk = y(178);
%     K2chk = y(179);
%     Poltot = y(180);
%     V1cdc45 = y(181);
%     V2cdc45 = y(182);
%     V1chk = y(183);
%     V2chk = y(184);
%     Kdw = y(185);
%     Kiw = y(186);
%     nc = y(187);
%     vdw = y(188);
%     vsw = y(189);

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

F(1,:) = (vsap1.* (GF./(Kagf + GF)) - kdap1 .*AP1) .* eps;
F(2,:) = (vsprb - kpc1 .* pRB.* E2F + kpc2 .* pRBc1 - V1 .* (pRB./( K1 + pRB)) .* (Md + Mdp27) + V2.*(pRBp./( K2 + pRBp)) - kdprb .* pRB) .* eps;
F(3,:) = (kpc1.*pRB.*E2F - kpc2.*pRBc1).*eps;
F(4,:) = (V1 .*(pRB./(K1 + pRB)) .* (Md + Mdp27) - V2 .* (pRBp./(K2 + pRBp)) - V3 .* (pRBp./( K3 + pRBp)) .* Me + V4 .* (pRBpp./( K4 + pRBpp)) - kpc3 .* pRBp.* E2F + kpc4 .* pRBc2 - kdpRBp .* pRBp) .* eps;
F(5,:) = (kpc3 .* pRBp.* E2F - kpc4 .* pRBc2) .* eps;
F(6,:) = (V3 .* (pRBp./(K3 + pRBp)) .* Me - V4 .* (pRBpp./(K4 + pRBpp)) - kdpRBpp .* pRBpp).*eps;
F(7,:) = (vse2f - kpc1 .* pRB.* E2F + kpc2 .* pRBc1 - kpc3 .* pRBp.* E2F + kpc4 .* pRBc2- V1e2f .* Ma.* (E2F./( K1e2f + E2F)) + V2e2f .* (E2Fp./( K2e2f + E2Fp)) - kde2f .* E2F) .* eps;
F(8,:) = (V1e2f .* Ma.* (E2F./(K1e2f + E2F)) -  V2e2f .* (E2Fp./( K2e2f + E2Fp)) - kde2fp .* E2Fp) .* eps;
F(9,:) = (kcd1 .* AP1 +  kcd2 .* E2F .* (Ki7./(Ki7 + pRB)) .* (Ki8./( Ki8 + pRBp)) -  kcom1 .* Cd .* (Cdk4tot - (Mdi + Md + Mdp27)) + kdecom1 .* Mdi - Vdd .* (Cd./( Kdd + Cd)) - kddd .* Cd) .* eps;
F(10,:) = (kcom1 .* Cd .* (Cdk4tot - (Mdi + Md + Mdp27)) -  kdecom1 .* Mdi + Vm2d .* (Md./( K2d + Md)) - Vm1d .* (Mdi./(K1d + Mdi))) .* eps;
F(11,:) = (Vm1d .* (Mdi./(K1d + Mdi)) - Vm2d .* (Md./( K2d + Md)) - kc1 .* Md.* p27 + kc2 .* Mdp27) .* eps;
F(12,:) = (kc1 .* Md.* p27 - kc2 .* Mdp27) .* eps;
F(13,:) = (kce .* E2F .* (Ki9 ./(Ki9 + pRB)) .* (Ki10./(Ki10 + pRBp))- kcom2 .* Ce .* (Cdk2tot - (Mei + Me + Mep27 + Mai + Ma + Map27))+ kdecom2 .* Mei - Vde .* (Skp2./(Kdceskp2 + Skp2)) .* (Ce./( Kde + Ce)) - kdde .* Ce) .* eps;
F(14,:) = (kcom2 .* Ce .* (Cdk2tot - (Mei + Me + Mep27 + Mai + Ma + Map27)) - kdecom2 .* Mei + Vm2e .* (Wee1 + ib1) .* (Me./(K2e + Me)) - Vm1e .* Pe .* (Mei./(K1e + Mei))) .* eps;
F(15,:) = (Vm1e .* Pe .* (Mei./( K1e + Mei)) - Vm2e .* (Wee1 + ib1) .* (Me./( K2e + Me)) - kc3 .* Me.* p27 +  kc4 .* Mep27) .* eps;
F(16,:) = (vsskp2 - Vdskp2 .* (Skp2./(Kdskp2 + Skp2)) .* (Cdh1a./(Kcdh1 + Cdh1a)) - kddskp2 .* Skp2) .* eps;
F(17,:) = (kc3 .* Me.* p27 - kc4 .* Mep27) .* eps;
F(18,:) = (vspei + V6e .* (xe1 + xe2 .* Chk1) .* (Pe./(K6e + Pe)) - Vm5e .* (Me + ae) .* (Pei./(K5e + Pei)) - kdpei .* Pei) .* eps;
F(19,:) = (Vm5e .* (Me + ae) .* (Pei./(K5e + Pei))- V6e .* (xe1 + xe2 .* Chk1) .* (Pe./( K6e + Pe)) - kdpe .* Pe) .* eps;
F(20,:) = (kca .* E2F .* (Ki11./( Ki11 + pRB)) .* (Ki12./(Ki12 + pRBp))- kcom3 .* Ca.* (Cdk2tot - (Mei + Me + Mep27 + Mai + Ma + Map27))+ kdecom3 .* Mai - Vda .* (Ca./(Kda + Ca)) .* (Cdc20a./( Kacdc20 + Cdc20a)) - kdda .* Ca) .* eps;

F(21,:) = (kcom3 .* Ca.* (Cdk2tot - (Mei + Me + Mep27 + Mai + Ma + Map27)) -  kdecom3 .* Mai + Vm2a .* (Wee1 + ib2) .* (Ma./(K2a + Ma)) - Vm1a .* Pa.* (Mai./(K1a + Mai))) .* eps;

F(22,:) = (Vm1a .* Pa.* (Mai./( K1a + Mai)) - Vm2a .* (Wee1 + ib2) .* (Ma./( K2a + Ma)) - kc5 .* Ma.* p27 + kc6 .* Map27) .* eps;

F(23,:) = (kc5 .* Ma.* p27 - kc6 .* Map27) .* eps;
F(24,:) = (vs1p27 +  vs2p27 .* E2F .* (Ki13./( Ki13 + pRB)) .* (Ki14./(Ki14 + pRBp)) -  kc1 .* Md .* p27 + kc2 .* Mdp27 - kc3 .* Me.* p27 + kc4 .* Mep27 - kc5 .* Ma.* p27 + kc6 .* Map27 - kc7 .* Mb.* p27 + kc8 .* Mbp27 - V1p27 .* Me.* (p27./(K1p27 + p27)) + V2p27 .* (p27p./( K2p27 + p27p)) - kddp27 .* p27) .* eps;

F(25,:) = (V1p27 .* Me.* (p27./(K1p27 + p27)) - V2p27 .* (p27p./(K2p27 + p27p)) - Vdp27p .* (Skp2./( Kdp27skp2 + Skp2)) .* (p27p./(Kdp27p + p27p)) - kddp27p .* p27p) .* eps;

F(26,:) = (V2cdh1 .* (Cdh1a./( K2cdh1 + Cdh1a)) .* (Ma + Mb) - V1cdh1 .* (Cdh1i./( K1cdh1 + Cdh1i)) - kdcdh1i .* Cdh1i) .* eps;

F(27,:) = (vscdh1a + V1cdh1 .* (Cdh1i./(K1cdh1 + Cdh1i)) - V2cdh1 .* (Cdh1a./( K2cdh1 + Cdh1a)) .* (Ma + Mb) - kdcdh1a .* Cdh1a) .* eps;

F(28,:) = (vspai + V6a .* (xa1 + xa2 .* Chk1) .* (Pa ./(K6a + Pa)) - Vm5a .* (Ma + aax ) .* (Pai./( K5a + Pai)) - kdpai .* Pai) .* eps;
F(29,:) = (Vm5a .* (Ma + aax) .* (Pai./( K5a + Pai)) -  V6a .* (xa1 + xa2 .* Chk1) .* (Pa./(K6a + Pa)) - kdpa .* Pa) .* eps;

F(30,:) = (vcb - kcom4 .* Cb.* (Cdk1tot - (Mbi + Mb + Mbp27)) + kdecom4 .* Mbi - Vdb .* (Cb./( Kdb + Cb)) .*((Cdc20a./(  Kdbcdc20 + Cdc20a)) + (Cdh1a./(Kdbcdh1 + Cdh1a))) - kddb .* Cb) .* eps;

F(31,:) = (kcom4 .* Cb.* (Cdk1tot - (Mbi + Mb + Mbp27)) - kdecom4 .* Mbi +  Vm2b .* (Wee1 + ib3 ) .* (Mb./( K2b + Mb)) - Vm1b .* Pb.* (Mbi./( K1b + Mbi))) .* eps;
F(32,:) = (Vm1b .* Pb.* (Mbi./(K1b + Mbi)) - Vm2b .* (Wee1 + ib3) .* (Mb./(K2b + Mb)) - kc7 .* Mb.* p27 +  kc8 .* Mbp27) .* eps;

F(33,:) = (kc7 .* Mb.* p27 - kc8 .* Mbp27) .* eps;
F(34,:) = (vscdc20i - Vm3b .* Mb.* (Cdc20i./( K3b + Cdc20i)) + Vm4b .* (Cdc20a./( K4b + Cdc20a))- kdcdc20i .* Cdc20i) .* eps;

F(35,:) = (Vm3b .* Mb.* (Cdc20i./(K3b + Cdc20i)) - Vm4b .* (Cdc20a./( K4b + Cdc20a))- kdcdc20a .* Cdc20a) .* eps;

F(36,:) = (vspbi + V6b .* (xb1 + xb2 .* Chk1) .* (Pb./(K6b + Pb)) - Vm5b .* (Mb + ab) .* (Pbi./(K5b + Pbi)) - kdpbi .* Pbi) .* eps;

F(37,:) = (Vm5b .* (Mb + ab) .* (Pbi./(K5b + Pbi))- V6b .* (xb1 + xb2 .* Chk1) .* (Pb./( K6b + Pb)) - kdpb .* Pb) .* eps;

F(38,:) = (vswee1 + ksw .* Mw - Vm7b .* (Mb + ib) .* (Wee1./(K7b + Wee1)) + Vm8b .* (Wee1p./( K8b + Wee1p)) - kdwee1 .*Wee1) .* eps;

F(39,:) = (Vm7b .* (Mb + ib ) .* (Wee1./( K7b + Wee1)) - Vm8b .* (Wee1p./(K8b + Wee1p)) - kdwee1p .*Wee1p) .* eps;

F(40,:) = (V1cdc45 .* Me.* ((Cdc45tot - Cdc45)./( K1cdc45 + (Cdc45tot - Cdc45))) -  V2cdc45 .* (Cdc45./(K2cdc45 + Cdc45)) - kspol .* (Poltot - Pol) .* Cdc45 + kdpol .* Pol) .* eps;

F(41,:) = (kspol .* (Poltot - Pol) .* Cdc45 - kdpol .* Pol) .* eps;
F(42,:) = (ksprim .* Pol - kdprim .* Primer - kaatr .* (ATRtot - ATR) .* Primer + kdatr .* ATR) .* eps;

F(43,:) = (kaatr .* (ATRtot - ATR) .* Primer - kdatr .* ATR) .* eps;
F(44,:) = (V1chk .* ATR.* ((Chk1tot - Chk1)./(K1chk + (Chk1tot - Chk1))) - V2chk .* (Chk1./( K2chk + Chk1))) .* eps;

end