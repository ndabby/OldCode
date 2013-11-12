function [average] = polyfit_plot_norm_three_input(xaxis1, xaxis2, xaxis3, m_n1, m_n2, m_n3, start_conc1, start_conc2, start_conc3, offset1, offset2, offset3, baseline1, baseline2, baseline3, max1, max2, max3, max1b, max2b, max3b)


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


testplotmn1 = (m_n1 - baseline1)/(max1-baseline1)*start_conc1;
p1 = plot(((xaxis1 - offset1)/3600), (testplotmn1*10^9), 'color', fuschia, 'LineWidth',2);
hold

[mean1] = polyfit_m4n0v1()

m_n1sim = (mean1(1)*xaxis1+ mean1(2));
testplotmn1b = (m_n1sim - baseline1)/(max1-baseline1)*start_conc1;

p1b = plot(((xaxis1 - offset1)/3600), (testplotmn1b*10^9), ':', 'color', fuschia, 'LineWidth',2);

average(1) = (mean1(1)/(max1-baseline1))/(2*10^-6); %exp(estimated_k)





testplotmn2 = (m_n2 - baseline2)/(max2-baseline2)*start_conc2;
p2 = plot(((xaxis2 - offset2)/3600), (testplotmn2*10^9), 'color', pink, 'LineWidth',2);

[mean2] = polyfit_m4n0v2()

m_n2sim = (mean2(1)*xaxis2+ mean2(2));
testplotmn2b = (m_n2sim - baseline2)/(max2-baseline2)*start_conc2;

p2b = plot(((xaxis2 - offset2)/3600), (testplotmn2b*10^9), ':', 'color', pink, 'LineWidth',2);

average(2) = (mean2(1)/(max2-baseline2))/(2*10^-6); %exp(estimated_k)




testplotmn3 = (m_n3 - baseline3)/(max3-baseline3)*start_conc3;
p3 = plot(((xaxis3 - offset3)/3600), (testplotmn3*10^9), 'color', red_lipstick, 'LineWidth',2);

[mean3] = polyfit_m4n0v3()

m_n3sim = (mean3(1)*xaxis3+ mean3(2));
testplotmn3b = (m_n3sim - baseline3)/(max3-baseline3)*start_conc3;

p3b = plot(((xaxis3 - offset3)/3600), (testplotmn3b*10^9), ':', 'color', red_lipstick, 'LineWidth',2);

average(3) = (mean3(1)/(max3-baseline3))/(2*10^-6) %exp(estimated_k)





legend([p1 p2 p3],'C = 2 uM, R = 50 nM', 'C = 2 uM, R = 50 nM', 'C = 2 uM, R = 100 nM', 'Location','Best')
set(gca,'FontSize',14);
xlabel('Time (in hours)','FontSize',16);
ylabel('Normalized Fluorescence (nM)', 'FontSize', 16);
title('m4n0 plot mean squared error linear fit for k1', 'FontSize', 16);