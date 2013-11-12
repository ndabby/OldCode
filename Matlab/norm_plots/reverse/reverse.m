load reverse;

addpath /Users/nadinedabby/Desktop/PrettyMatlab/

%x-axis = over-all time
%start_conc = limited reactant concentration
%offset = start time
%baseline = low fluorescence level
%max = high fluorescence level


time = reverse2(5:1165, 1);
time = time/3600;

control = reverse2(5:1165, 2);
m0n0 = reverse2(5:1165, 3);
m0n2 = reverse2(5:1165, 4);
m2n0 = reverse2(5:1165, 5);

offset = 5;
concentration = 500*10^(-9)

maxcontrol = max(control(offset: 1000));
max00 = max(m0n0(offset:1000));
max02 = max(m0n2(offset:1000));
max20 = max(m2n0(offset:1000));

control = control/maxcontrol*concentration;
m0n0 = m0n0/max00*concentration;
m0n2 = m0n2/max02*concentration;
m2n0 = m2n0/max20*concentration;




close all;
f = figure(1);
set(f,'Color',[1 1 1]);


p1 = plot(time, (control*10^9), 'color', charcoal, 'LineWidth', 2);
hold
p2 = plot(time, (m0n0*10^9), 'color', pink, 'LineWidth', 2.5);
p3 = plot(time, (m0n2*10^9), 'color', purple, 'LineWidth', 2);
p4 = plot(time, (m2n0*10^9), 'color', blue_middle, 'LineWidth', 2);

legend([p1 p2 p3 p4],'control: n2-product','m0n0reverse: 1 uM m0-product, 500nM n0-product', 'm0n2reverse: 1 uM m0-product, 500nM n2-product', 'm2n0reverse: 1 uM m2-product, 500nM n0-product', 'Location','Best')
set(gca,'FontSize',14);
xlabel('Time (in hours)','FontSize',16);
ylabel('Normalized Fluorescence (nM)', 'FontSize', 16);
title('Reversible four-way branch migration rates', 'FontSize', 16);