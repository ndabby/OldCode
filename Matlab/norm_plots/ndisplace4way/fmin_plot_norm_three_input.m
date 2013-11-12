function [average] = fmin_plot_norm_three_input(xaxis1, xaxis2, xaxis3, m_n1, m_n2, m_n3, start_conc1, start_conc2, start_conc3, offset1, offset2, offset3, baseline1, baseline2, baseline3, max1, max2, max3, max1b, max2b, max3b)


addpath /Users/nadinedabby/Desktop/PrettyMatlab/

%x-axis = over-all time
%start_conc = limited reactant concentration
%offset = start time
%baseline = low fluorescence level
%max = high fluorescence level

close all;
f = figure(1);
set(f,'Color',[1 1 1]);


average = zeros(1, 3)

options = odeset('MaxStep',100,'refine',1e-12,'InitialStep',100,'RelTol',1e-12,'AbsTol',1e-12);
options = optimset('Tolfun', 1e-18);


k0 = log(3500); %in this case we are using k2 as fixed and k1 as adjustable parameter

[estimated_k] = fminunc(@err_func_ndisplacev1, k0);

options = odeset('MaxStep',100,'refine',1e-10,'InitialStep',100,'RelTol',1e-10,'AbsTol',1e-10);

testplotmn1 = (m_n1 - baseline1)/(max1-baseline1)*start_conc1;
p1 = plot(((xaxis1 - offset1)/3600), (testplotmn1*10^9), 'color', fuschia, 'LineWidth',2);
hold
[T,Y] = ode45(@fmin_toehold_norm_1,[0 86400],[start_conc1*(max1b-baseline1)/(max1-baseline1), 0, 0, exp(estimated_k)],options);
p1b = plot((T/3600),(Y(:,3)*10^9), ':', 'color', fuschia, 'LineWidth',2);
average(1) = exp(estimated_k)

[T,Y] = ode45(@toehold_ave_1,[0 86400],[start_conc1*(max1b-baseline1)/(max1-baseline1), 0, 0],options);
p1c = plot(T/3600,Y(:,3)*10^9, ':', 'color', grey, 'LineWidth',2);


[estimated_k] = fminunc(@err_func_ndisplacev2, k0);

options = odeset('MaxStep',100,'refine',1e-12,'InitialStep',100,'RelTol',1e-12,'AbsTol',1e-12);

testplotmn2 = (m_n2 - baseline2)/(max2-baseline2)*start_conc2
p2 = plot((xaxis2 - offset2)/3600, testplotmn2*10^9, 'color', pink, 'LineWidth',2)

[T,Y] = ode45(@fmin_toehold_norm_2,[0 86400],[start_conc2*(max2b-baseline2)/(max2-baseline2), 0, 0, exp(estimated_k)],options);
p2b = plot(T/3600,Y(:,3)*10^9, ':', 'color', pink, 'LineWidth',2);
average(2) = exp(estimated_k)
[T,Y] = ode45(@toehold_ave_2,[0 86400],[start_conc2*(max2b-baseline2)/(max2-baseline2), 0, 0],options);
p2c = plot(T/3600,Y(:,3)*10^9, ':', 'color', grey, 'LineWidth',2);


[estimated_k] = fminunc(@err_func_ndisplacev3, k0);

options = odeset('MaxStep',100,'refine',1e-12,'InitialStep',100,'RelTol',1e-12,'AbsTol',1e-12);
%
testplotmn3 = (m_n3 - baseline3)/(max3-baseline3)*start_conc3
p3 = plot((xaxis3 - offset3)/3600, testplotmn3*10^9, 'color', red_lipstick, 'LineWidth',2)

[T,Y] = ode45(@fmin_toehold_norm_3,[0 86400],[start_conc3*(max3b-baseline3)/(max3-baseline3), 0, 0, exp(estimated_k)],options);
p3b = plot(T/3600,Y(:,3)*10^9, ':', 'color', red_lipstick, 'LineWidth',2);
average(3) = exp(estimated_k)
[T,Y] = ode45(@toehold_ave_3,[0 86400],[start_conc3*(max3b-baseline3)/(max3-baseline3), 0, 0],options);
p3c = plot(T/3600,Y(:,3)*10^9, ':', 'color', grey, 'LineWidth',2);



legend([p1 p2 p3],'C = 500 nM, R = 120 nM','C = 100 nM, R = 10 nM','C = 10 nM, R = 5 nM','Location','Best');
set(gca,'FontSize',14);
xlabel('Time (in hours)','FontSize',16);
ylabel('Normalized Fluorescence (nM)', 'FontSize', 16);
title('ndisplace with m toehold present plot mean squared error fit for k1', 'FontSize', 16);