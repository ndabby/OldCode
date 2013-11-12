function testplotmn = plot_norm_nine_input(xaxis1, xaxis2, xaxis3, xaxis4, xaxis5, xaxis6, xaxis7, xaxis8, xaxis9, m_n1, m_n2, m_n3, m_n4, m_n5, m_n6, m_n7, m_n8, m_n9, start_conc1, start_conc2, start_conc3, start_conc4, start_conc5, start_conc6, start_conc7, start_conc8, start_conc9, offset1, offset2, offset3, offset4, offset5, offset6, offset7, offset8, offset9, baseline1, baseline2, baseline3, baseline4, baseline5, baseline6, baseline7, baseline8, baseline9, max1, max2, max3, max4, max5, max6, max7, max8, max9, max1b, max2b, max3b, max4b, max5b, max6b, max7b, max8b, max9b)


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
p4 = plot((xaxis4 - offset4)/3600, testplotmn4*10^9, 'color', purple, 'LineWidth',2)

[T,Y] = ode45(@toehold_norm_4,[0 86400],[start_conc4*(max4b-baseline4)/(max4-baseline4), 0, 0],options);
p4b = plot(T/3600,Y(:,3)*10^9, ':', 'color', purple, 'LineWidth',2)

testplotmn5 = (m_n5 - baseline5)/(max5-baseline5)*start_conc5
p5 = plot((xaxis5 - offset5)/3600, testplotmn5*10^9, 'color', blue_midnight, 'LineWidth',2)

[T,Y] = ode45(@toehold_norm_5,[0 86400],[start_conc5*(max5b-baseline5)/(max5-baseline5), 0, 0],options);
p5b = plot(T/3600,Y(:,3)*10^9, ':', 'color', blue_midnight, 'LineWidth',2)

testplotmn6 = (m_n6 - baseline6)/(max6-baseline6)*start_conc6
p6 = plot((xaxis6 - offset6)/3600, testplotmn6*10^9, 'color', blue_sapphire, 'LineWidth',2)

[T,Y] = ode45(@toehold_norm_6,[0 86400],[start_conc6*(max6b-baseline6)/(max6-baseline6), 0, 0],options);
p6b = plot(T/3600,Y(:,3)*10^9, ':', 'color', blue_sapphire, 'LineWidth',2)

testplotmn7 = (m_n7 - baseline7)/(max7-baseline7)*start_conc7
p7 = plot((xaxis7 - offset7)/3600, testplotmn7*10^9, 'color', blue_middle, 'LineWidth',2)

[T,Y] = ode45(@toehold_norm_7,[0 86400],[start_conc7*(max7b-baseline7)/(max7-baseline7), 0, 0],options);
p7b = plot(T/3600,Y(:,3)*10^9, ':', 'color', blue_middle, 'LineWidth',2)

testplotmn8 = (m_n8 - baseline8)/(max8-baseline8)*start_conc8
p8 = plot((xaxis8 - offset8)/3600, testplotmn8*10^9, 'color', green_seafoam, 'LineWidth',2)

[T,Y] = ode45(@toehold_norm_8,[0 86400],[start_conc8*(max8b-baseline8)/(max8-baseline8), 0, 0],options);
p8b = plot(T/3600,Y(:,3)*10^9, ':', 'color', green_seafoam, 'LineWidth',2)

testplotmn9 = (m_n9 - baseline9)/(max9-baseline9)*5*10^-9
p9 = plot((xaxis9 - offset9)/3600, testplotmn9*10^9, 'color', green_pistachio, 'LineWidth',2)

[T,Y] = ode45(@toehold_norm_9,[0 86400],[5*10^-9*(max9b-baseline9)/(max9-baseline9), 0, 0],options);
p9b = plot(T/3600,Y(:,3)*10^9, ':', 'color', green_pistachio, 'LineWidth',2)

legend([p1 p2 p3 p4 p5 p6 p7 p8 p9],'C = 5 nM, R = 2.5 nM', 'C = 5 nM, R = 2.5 nM', 'C = 5 nM, R = 1 nM', 'C = 5 nM, R = 0.5 nM', 'C = 5 nM, R = 0.5 nM','C = 5 nM, R = 0.5 nM', 'C = 5 nM, R = 0.5 nM', 'C = 5 nM, R = 0.5 nM****', 'C = 0.5 nM, R = 5 nM****', 'Location','Best')
%legend boxoff
set(gca,'FontSize',14);
xlabel('Time (in hours)','FontSize',16);
ylabel('Normalized Fluorescence (nM)', 'FontSize', 16);
title('m6n2 plot', 'FontSize', 16);