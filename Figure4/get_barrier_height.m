function BH_data = get_barrier_height(pcycle,cycle,if_plot)
if(~exist('if_plot','var'))
    if_plot = 0;  % provide the value if absent
end
extrab=1;
n0=size(cycle);
n0=n0(1)-1;
xla2=cycle(:,15);
yla2=cycle(:,22);
zla21=pcycle(1:n0+1);
zla2=-log(zla21);
tpper=zeros(5,1);
tpper2=zeros(5,1);
tpper3=zeros(5,1);
tpper4=zeros(5,1);
i=0;
for t=3:2:n0-1
    if cycle(t+2,15) > cycle(t,15) && cycle(t-2,15) > cycle(t,15)
        tpper(i+1)=t;
        i=i+1;
    end
end
i=0;
for t=3:2:n0-1
    if cycle(t+2,22) > cycle(t,22) && cycle(t-2,22) > cycle(t,22)
        tpper2(i+1)=t;
        i=i+1;
    end
end
i=0;
for t=3:2:n0-1
    if cycle(t+2,22) < cycle(t,22) && cycle(t-2,22) < cycle(t,22)
        tpper3(i+1)=t;
        i=i+1;
    end
end

for t=3:2:n0-1
    if cycle(t,22) < 0.05 && cycle(t,15) > 0.37
        tpper4(1)=t;
        break;
    end
end
basin1=tpper(1);
for t=basin1:1:tpper4(1)
    if zla2(t-1) < zla2(t) && zla2(t+1) < zla2(t)
        bar1=t;
        break;
    end
end
for t=bar1:1:tpper4(1)
    if zla2(t-1) > zla2(t) && zla2(t+1) > zla2(t)
        basin2=t;
        break;
    end
end
findbar2=0;
for t=basin2:1:n0
    if zla2(t-1) < zla2(t) && zla2(t+1) < zla2(t)
        bar2=t;
        findbar2=1;
        break;
    end
end
if findbar2==0
    if zla2(n0-1) < zla2(n0) && zla2(2) < zla2(1)
        bar2=n0;
        findbar2=1;
    end
end
if findbar2==0
    for t=2:1:tpper3(1)
        if zla2(t-1) < zla2(t) && zla2(t+1) < zla2(t)
            bar2=t;
            findbar2=1;
            break;
        end
    end
end

for t=bar2:1:tpper2(1)
    if zla2(t-1) > zla2(t) && zla2(t+1) > zla2(t)
        basin3=t;
        break;
    end
end

if extrab>0
    for t=basin3:1:tpper2(1)
        if zla2(t-1) < zla2(t) && zla2(t+1) < zla2(t)
            bar3=t;
            break;
        end
    end
    for t=bar3:1:tpper(1)
        if zla2(t-1) > zla2(t) && zla2(t+1) > zla2(t)
            basin4=t;
            break;
        end
    end
end
if if_plot>0
    figure(parnum+100);
    plot(1:(n0+1),zla2);
    hold on
    scatter(basin1,zla2(basin1));
    scatter(bar1,zla2(bar1));
    scatter(basin2,zla2(basin2));
    scatter(bar2,zla2(bar2));
    scatter(basin3,zla2(basin3));
    if extrab>0
        scatter(bar3,zla2(bar3));
        scatter(basin4,zla2(basin4));
    end
    figure(parnum);
    plot(xla2,yla2);
    hold on
    scatter(xla2(basin1),yla2(basin1));
    scatter(xla2(bar1),yla2(bar1));
    scatter(xla2(basin2),yla2(basin2));
    scatter(xla2(bar2),yla2(bar2));
    scatter(xla2(basin3),yla2(basin3));
    if extrab>0
        scatter(xla2(bar3),yla2(bar3));
        scatter(xla2(basin4),yla2(basin4));
    end
end

BH_data = [zla2(basin1),zla2(basin2),zla2(basin3),zla2(basin4),...
    zla2(bar1),zla2(bar2),zla2(bar3)];