function testplotmn = plot_norm_five_input(xaxis1, xaxis2, xaxis3, xaxis4, xaxis5, m_n1, m_n2, m_n3, m_n4, m_n5, start_conc1, start_conc2, start_conc3, start_conc4, start_conc5, offset1, offset2, offset3, offset4, offset5, baseline1, baseline2, baseline3, baseline4, baseline5, max1, max2, max3, max4, max5, max1b, max2b, max3b, max4b, max5b)


addpath /Users/nadinedabby/Desktop/PrettyMatlab/

%x-axis = over-all time
%start_conc = limited reactant concentration
%offset = start time
%baseline = low fluorescence level
%max = high fluorescence level

options = odeset('MaxStep',100,'refine',1e-10,'InitialStep',100,'RelTol',1e-10,'AbsTol',1e-10)

close all;
f = figure(1);
set(f,'Color',[1 1 1]);



testplotmn1 = (m_n1 - baseline1)/(max1-baseline1)*start_conc1
p1 = plot((xaxis1 - offset1)/3600, testplotmn1*10^9, 'color', fuschia, 'LineWidth',2)
hold
[T,Y] = ode45(@toehold_norm_1,[0 86400],[start_conc1*(max1b-baseline1)/(max1-baseline1), 0, 0],options);
p1b = plot(T/3600,Y(:,3)*10^9,':', 'color', fuschia, 'LineWidth',2)

testplotmn2 = (m_n2 - baseline2)/(max2-baseline2)*start_conc2
p2 = plot((xaxis2 - offset2)/3600, testplotmn2*10^9, 'color', pink, 'LineWidth',2)

[T,Y] = ode45(@toehold_norm_2,[0 86400],[start_conc2*(max2b-baseline2)/(max2-baseline2), 0, 0],options);
p2b = plot(T/3600,Y(:,3)*10^9, ':', 'color', pink, 'LineWidth',2)

testplotmn3 = (m_n3 - baseline3)/(max3-baseline3)*start_conc3
p3 = plot((xaxis3 - offset3)/3600, testplotmn3*10^9, 'color', red_lipstick, 'LineWidth',2)

[T,Y] = ode45(@toehold_norm_3,[0 86400],[start_conc3*(max3b-baseline3)/(max3-baseline3), 0, 0],options);
p3b = plot(T/3600,Y(:,3)*10^9, ':', 'color', red_lipstick, 'LineWidth',2)

testplotmn4 = (m_n4 - baseline4)/(max4-baseline4)*start_conc4
p4 = plot(((xaxis4 - offset4)/3600),(testplotmn4 * 10^9), 'color', purple, 'LineWidth',2)

[T,Y] = ode45(@toehold_norm_4,[0 86400],[start_conc4*(max4b-baseline4)/(max4-baseline4), 0, 0],options);
p4b = plot(T/3600,Y(:,3)*10^9, ':', 'color', purple, 'LineWidth',2)

testplotmn5 = (m_n5 - baseline5)/(max5-baseline5)*start_conc5
p5 = plot((xaxis5 - offset5)/3600, testplotmn5*10^9, 'color', blue_midnight, 'LineWidth',2)

[T,Y] = ode45(@toehold_norm_5,[0 86400],[start_conc5*(max5b-baseline5)/(max5-baseline5), 0, 0],options);
p5b = plot(T/3600,Y(:,3)*10^9, ':', 'color', blue_midnight, 'LineWidth',2)

legend([p1 p2 p3 p4 p5],'C = 100 nM, R = 20 nM', 'C = 5 nM, R = 1 nM', 'C = 1 nM, R = 0.25 nM', 'C = 0.5 nM, R = 0.1 nM', 'C = 1 nM, R = 0.25 nM','Location','Best')
set(gca,'FontSize',14);
xlabel('Time (in hours)','FontSize',16);
ylabel('Normalized Fluorescence (nM)', 'FontSize', 16);
title('m16n0 plot', 'FontSize', 16);