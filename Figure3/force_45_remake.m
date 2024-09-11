function F = force_45_remake(x)
    n0=size(x);
    n0=n0(2);
    F = zeros(44,n0);
    
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