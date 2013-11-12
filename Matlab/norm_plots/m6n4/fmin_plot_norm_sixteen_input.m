function [average] = fmin_plot_norm_sixteen_input(xaxis1, xaxis2, xaxis3, xaxis4, xaxis5, xaxis6, xaxis7, xaxis8, xaxis9, xaxis10, xaxis11, xaxis12,  xaxis13, xaxis14, xaxis15, xaxis16, m_n1, m_n2, m_n3, m_n4, m_n5, m_n6, m_n7, m_n8, m_n9, m_n10, m_n11, m_n12, m_n13, m_n14, m_n15, m_n16, start_conc1, start_conc2, start_conc3, start_conc4, start_conc5, start_conc6, start_conc7, start_conc8, start_conc9, start_conc10, start_conc11, start_conc12, start_conc13, start_conc14, start_conc15, start_conc16, offset1, offset2, offset3, offset4, offset5, offset6, offset7, offset8, offset9, offset10, offset11, offset12, offset13, offset14, offset15, offset16, baseline1, baseline2, baseline3, baseline4, baseline5, baseline6, baseline7, baseline8, baseline9, baseline10, baseline11, baseline12, baseline13, baseline14, baseline15, baseline16, max1, max2, max3, max4, max5, max6, max7, max8, max9, max10, max11, max12, max13, max14, max15, max16, max1b, max2b, max3b, max4b, max5b, max6b, max7b, max8b, max9b, max10b, max11b, max12b, max13b, max14b, max15b, max16b)


addpath /Users/nadinedabby/Desktop/PrettyMatlab/

%x-axis = over-all time
%start_conc = limited reactant concentration
%offset = start time
%baseline = low fluorescence level
%max = high fluorescence level

average = zeros(1, 14)

options = odeset('MaxStep',100,'refine',1e-10,'InitialStep',100,'RelTol',1e-10,'AbsTol',1e-10);
options = optimset('Tolfun', 1e-12);


k0 = log(8000);

[estimated_k] = fminunc(@err_func_m6n4v1, k0);

options = odeset('MaxStep',100,'refine',1e-10,'InitialStep',100,'RelTol',1e-10,'AbsTol',1e-10);

testplotmn1 = (m_n1 - baseline1)/(max1-baseline1)*start_conc1;
%p1 = plot((xaxis1 - offset1)/3600, testplotmn1*10^9, 'color', fuschia, 'LineWidth',2);
%hold
[T,Y] = ode45(@fmin_toehold_norm_1,[0 86400],[start_conc1*(max1b-baseline1)/(max1-baseline1), 0, 0, exp(estimated_k)],options);
%p1b = plot(T/3600,Y(:,3)*10^9, ':', 'color', fuschia, 'LineWidth',2);
average(1) = exp(estimated_k)
[T,Y] = ode45(@toehold_ave_1,[0 86400],[start_conc1*(max1b-baseline1)/(max1-baseline1), 0, 0],options);
%p1c = plot(T/3600,Y(:,3)*10^9,':', 'color', grey, 'LineWidth',2)



[estimated_k] = fminunc(@err_func_m6n4v2, k0);

options = odeset('MaxStep',100,'refine',1e-10,'InitialStep',100,'RelTol',1e-10,'AbsTol',1e-10);

testplotmn2 = (m_n2 - baseline2)/(max2-baseline2)*start_conc2
%p2 = plot((xaxis2 - offset2)/3600, testplotmn2*10^9, 'color', pink, 'LineWidth',2)

[T,Y] = ode45(@fmin_toehold_norm_2,[0 86400],[start_conc2*(max2b-baseline2)/(max2-baseline2), 0, 0, exp(estimated_k)],options);
%p2b = plot(T/3600,Y(:,3)*10^9, ':', 'color', pink, 'LineWidth',2);
average(2) = exp(estimated_k)
[T,Y] = ode45(@toehold_ave_2,[0 86400],[start_conc2*(max2b-baseline2)/(max2-baseline2), 0, 0],options);
%p2c = plot(T/3600,Y(:,3)*10^9, ':', 'color', grey, 'LineWidth',2)





[estimated_k] = fminunc(@err_func_m6n4v3, k0);

options = odeset('MaxStep',100,'refine',1e-10,'InitialStep',100,'RelTol',1e-10,'AbsTol',1e-10);

testplotmn3 = (m_n3 - baseline3)/(max3-baseline3)*start_conc3
%p3 = plot((xaxis3 - offset3)/3600, testplotmn3*10^9, 'color', red_lipstick, 'LineWidth',2)

[T,Y] = ode45(@fmin_toehold_norm_3,[0 86400],[start_conc3*(max3b-baseline3)/(max3-baseline3), 0, 0, exp(estimated_k)],options);
%p3b = plot(T/3600,Y(:,3)*10^9, ':', 'color', red_lipstick, 'LineWidth',2);
average(3) = exp(estimated_k)
[T,Y] = ode45(@toehold_ave_3,[0 86400],[start_conc3*(max3b-baseline3)/(max3-baseline3), 0, 0],options);
%p3c = plot(T/3600,Y(:,3)*10^9, ':', 'color', grey, 'LineWidth',2)





[estimated_k] = fminunc(@err_func_m6n4v4, k0);

options = odeset('MaxStep',100,'refine',1e-10,'InitialStep',100,'RelTol',1e-10,'AbsTol',1e-10);

testplotmn4 = (m_n4 - baseline4)/(max4-baseline4)*start_conc4
%p4 = plot((xaxis4 - offset4)/3600, testplotmn4*10^9, 'color', purple, 'LineWidth',2)

[T,Y] = ode45(@fmin_toehold_norm_4,[0 86400],[start_conc4*(max4b-baseline4)/(max4-baseline4), 0, 0, exp(estimated_k)],options);
%p4b = plot(T/3600,Y(:,3)*10^9, ':', 'color', purple, 'LineWidth',2);
average(4) = exp(estimated_k)
[T,Y] = ode45(@toehold_ave_4,[0 86400],[start_conc4*(max4b-baseline4)/(max4-baseline4), 0, 0],options);
%p4c = plot(T/3600,Y(:,3)*10^9, ':', 'color', grey, 'LineWidth',2)





[estimated_k] = fminunc(@err_func_m6n4v5, k0);

options = odeset('MaxStep',100,'refine',1e-10,'InitialStep',100,'RelTol',1e-10,'AbsTol',1e-10);

testplotmn5 = (m_n5 - baseline5)/(max5-baseline5)*start_conc5
%p5 = plot((xaxis5 - offset5)/3600, testplotmn5*10^9, 'color', yellow_gold, 'LineWidth',2)

[T,Y] = ode45(@fmin_toehold_norm_5,[0 86400],[start_conc5*(max5b-baseline5)/(max5-baseline5), 0, 0, exp(estimated_k)],options);
%p5b = plot(T/3600,Y(:,3)*10^9, ':', 'color', yellow_gold, 'LineWidth',2);
average(5) = exp(estimated_k)
[T,Y] = ode45(@toehold_ave_5,[0 86400],[start_conc5*(max5b-baseline5)/(max5-baseline5), 0, 0],options);
%p5c = plot(T/3600,Y(:,3)*10^9, ':', 'color', grey, 'LineWidth',2)



options = odeset('MaxStep',100,'refine',1e-10,'InitialStep',100,'RelTol',1e-10,'AbsTol',1e-10);

[estimated_k] = fminunc(@err_func_m6n4v6, k0);

testplotmn6 = (m_n6 - baseline6)/(max6-baseline6)*start_conc6
%p6 = plot((xaxis6 - offset6)/3600, testplotmn6*10^9, 'color', blue_sapphire, 'LineWidth',2)

[T,Y] = ode45(@fmin_toehold_norm_6,[0 86400],[start_conc6*(max6b-baseline6)/(max6-baseline6), 0, 0, exp(estimated_k)],options);
%p6b = plot(T/3600,Y(:,3)*10^9, ':', 'color', blue_sapphire, 'LineWidth',2);
average(6) = exp(estimated_k)

[T,Y] = ode45(@toehold_ave_6,[0 86400],[start_conc6*(max6b-baseline6)/(max6-baseline6), 0, 0],options);
%p6c = plot(T/3600,Y(:,3)*10^9, ':', 'color', grey, 'LineWidth',2)






[estimated_k] = fminunc(@err_func_m6n4v7, k0);

options = odeset('MaxStep',100,'refine',1e-10,'InitialStep',100,'RelTol',1e-10,'AbsTol',1e-10);

testplotmn7 = (m_n7 - baseline7)/(max7-baseline7)*start_conc7
%p7 = plot((xaxis7 - offset7)/3600, testplotmn7*10^9, 'color', blue_middle, 'LineWidth',2)

[T,Y] = ode45(@fmin_toehold_norm_7,[0 86400],[start_conc7*(max7b-baseline7)/(max7-baseline7), 0, 0, exp(estimated_k)],options);
%p7b = plot(T/3600,Y(:,3)*10^9, ':', 'color', blue_middle, 'LineWidth',2);
average(7) = exp(estimated_k)
[T,Y] = ode45(@toehold_ave_7,[0 86400],[start_conc7*(max7b-baseline7)/(max7-baseline7), 0, 0],options);
%p7c = plot(T/3600,Y(:,3)*10^9, ':', 'color', grey, 'LineWidth',2)




[estimated_k] = fminunc(@err_func_m6n4v8, k0);

options = odeset('MaxStep',100,'refine',1e-10,'InitialStep',100,'RelTol',1e-10,'AbsTol',1e-10);

testplotmn8 = (m_n8 - baseline8)/(max8-baseline8)*start_conc8
%p8 = plot((xaxis8 - offset8)/3600, testplotmn8*10^9, 'color', green_seafoam, 'LineWidth',2)

[T,Y] = ode45(@fmin_toehold_norm_8,[0 86400],[start_conc8*(max8b-baseline8)/(max8-baseline8), 0, 0, exp(estimated_k)],options);
%p8b = plot(T/3600,Y(:,3)*10^9, ':', 'color', green_seafoam, 'LineWidth',2);
average(8) = exp(estimated_k)
[T,Y] = ode45(@toehold_ave_8,[0 86400],[start_conc8*(max8b-baseline8)/(max8-baseline8), 0, 0],options);
%p8c = plot(T/3600,Y(:,3)*10^9, ':', 'color', grey, 'LineWidth',2)





[estimated_k] = fminunc(@err_func_m6n4v9, k0);

options = odeset('MaxStep',100,'refine',1e-10,'InitialStep',100,'RelTol',1e-10,'AbsTol',1e-10);

testplotmn9 = (m_n9 - baseline9)/(max9-baseline9)*start_conc9
p9 = plot((xaxis9 - offset9)/3600, testplotmn9*10^9, 'color', fuschia, 'LineWidth',2)
hold
[T,Y] = ode45(@fmin_toehold_norm_9,[0 86400],[start_conc9*(max9b-baseline9)/(max9-baseline9), 0, 0, exp(estimated_k)],options);
p9b = plot(T/3600,Y(:,3)*10^9, ':', 'color', fuschia, 'LineWidth',2);
average(9) = exp(estimated_k)
[T,Y] = ode45(@toehold_ave_9,[0 86400],[start_conc9*(max9b-baseline9)/(max9-baseline9), 0, 0],options);
p9c = plot(T/3600,Y(:,3)*10^9, ':', 'color', grey, 'LineWidth',2)







[estimated_k] = fminunc(@err_func_m6n4v10, k0);

options = odeset('MaxStep',100,'refine',1e-10,'InitialStep',100,'RelTol',1e-10,'AbsTol',1e-10);

testplotmn10 = (m_n10 - baseline10)/(max10-baseline10)*start_conc10
p10 = plot((xaxis10 - offset10)/3600, testplotmn10*10^9, 'color', pink, 'LineWidth',2)
[T,Y] = ode45(@fmin_toehold_norm_10,[0 86400],[start_conc10*(max10b-baseline10)/(max10-baseline10), 0, 0, exp(estimated_k)],options);
p10b = plot(T/3600,Y(:,3)*10^9, ':', 'color', pink, 'LineWidth',2);
average(10) = exp(estimated_k)
[T,Y] = ode45(@toehold_ave_10,[0 86400],[start_conc10*(max10b-baseline10)/(max10-baseline10), 0, 0],options);
p10c = plot(T/3600,Y(:,3)*10^9, ':', 'color', grey, 'LineWidth',2)






[estimated_k] = fminunc(@err_func_m6n4v11, k0);

options = odeset('MaxStep',100,'refine',1e-10,'InitialStep',100,'RelTol',1e-10,'AbsTol',1e-10);

testplotmn11 = (m_n11 - baseline11)/(max11-baseline11)*start_conc11
p11 = plot((xaxis11 - offset11)/3600, testplotmn11*10^9, 'color', red_lipstick, 'LineWidth',2)

[T,Y] = ode45(@fmin_toehold_norm_11,[0 86400],[start_conc11*(max11b-baseline11)/(max11-baseline11), 0, 0, exp(estimated_k)],options);
p11b = plot(T/3600,Y(:,3)*10^9, ':', 'color', red_lipstick, 'LineWidth',2);
average(11) = exp(estimated_k)
[T,Y] = ode45(@toehold_ave_11,[0 86400],[start_conc11*(max11b-baseline11)/(max11-baseline11), 0, 0],options);
p11c = plot(T/3600,Y(:,3)*10^9,':', 'color', grey, 'LineWidth',2)






[estimated_k] = fminunc(@err_func_m6n4v12, k0);

options = odeset('MaxStep',100,'refine',1e-10,'InitialStep',100,'RelTol',1e-10,'AbsTol',1e-10);

testplotmn12 = (m_n12 - baseline12)/(max12-baseline12)*start_conc12
p12 = plot((xaxis12 - offset12)/3600, testplotmn12*10^9, 'color', purple, 'LineWidth',2)

[T,Y] = ode45(@fmin_toehold_norm_12,[0 86400],[start_conc12*(max12b-baseline12)/(max12-baseline12), 0, 0, exp(estimated_k)],options);
p12b = plot(T/3600,Y(:,3)*10^9, ':', 'color', purple, 'LineWidth',2);
average(12) = exp(estimated_k)
[T,Y] = ode45(@toehold_ave_12,[0 86400],[start_conc12*(max12b-baseline12)/(max12-baseline12), 0, 0],options);
p12c = plot(T/3600,Y(:,3)*10^9,':', 'color', grey, 'LineWidth',2)



[estimated_k] = fminunc(@err_func_m6n4v13, k0);

options = odeset('MaxStep',100,'refine',1e-10,'InitialStep',100,'RelTol',1e-10,'AbsTol',1e-10);

testplotmn13 = (m_n13 - baseline13)/(max13-baseline13)*start_conc13
p13 = plot((xaxis13 - offset13)/3600, testplotmn13*10^9, 'color', yellow_gold, 'LineWidth',2)

[T,Y] = ode45(@fmin_toehold_norm_13,[0 86400],[start_conc13*(max13b-baseline13)/(max13-baseline13), 0, 0, exp(estimated_k)],options);
p13b = plot(T/3600,Y(:,3)*10^9, ':', 'color', yellow_gold, 'LineWidth',2);
average(13) = exp(estimated_k)
[T,Y] = ode45(@toehold_ave_13,[0 86400],[start_conc13*(max13b-baseline13)/(max13-baseline13), 0, 0],options);
p13c = plot(T/3600,Y(:,3)*10^9,':', 'color', grey, 'LineWidth',2)



%[estimated_k] = fminunc(@err_func_m6n4v14, k0);

%options = odeset('MaxStep',100,'refine',1e-10,'InitialStep',100,'RelTol',1e-10,'AbsTol',1e-10);

%testplotmn14 = (m_n14 - baseline14)/(max14-baseline14)*10^-9
%p14 = plot((xaxis14 - offset14)/3600, testplotmn14*10^9, 'color', blue_sapphire, 'LineWidth',2)
%[T,Y] = ode45(@fmin_toehold_norm_14,[0 86400],[start_conc14*(max14b-baseline14)/(max14-baseline14), 0, 0, exp(estimated_k)],options);
%p14b = plot(T/3600,Y(:,3)*10^9, ':', 'color', blue_sapphire, 'LineWidth',2);
%average(14) = exp(estimated_k)
%[T,Y] = ode45(@toehold_ave_14,[0 86400],[start_conc14*(max14b-baseline14)/(max14-baseline14), 0, 0],options);
%p14c = plot(T/3600,Y(:,3)*10^9,':', 'color', grey, 'LineWidth',2)






[estimated_k] = fminunc(@err_func_m6n4v15, k0);

options = odeset('MaxStep',100,'refine',1e-10,'InitialStep',100,'RelTol',1e-10,'AbsTol',1e-10);

testplotmn15 = (m_n15 - baseline15)/(max15-baseline15)*start_conc15
p15 = plot((xaxis15 - offset15)/3600, testplotmn15*10^9, 'color', blue_middle, 'LineWidth',2)
[T,Y] = ode45(@fmin_toehold_norm_15,[0 86400],[start_conc15*(max15b-baseline15)/(max15-baseline15), 0, 0, exp(estimated_k)],options);
p15b = plot(T/3600,Y(:,3)*10^9, ':', 'color', blue_middle, 'LineWidth',2);
average(14) = exp(estimated_k)
[T,Y] = ode45(@toehold_ave_15,[0 86400],[start_conc15*(max15b-baseline15)/(max15-baseline15), 0, 0],options);
p15c = plot(T/3600,Y(:,3)*10^9,':', 'color', grey, 'LineWidth',2)



%[estimated_k] = fminunc(@err_func_m6n4v16, k0);

%options = odeset('MaxStep',100,'refine',1e-10,'InitialStep',100,'RelTol',1e-10,'AbsTol',1e-10);

%testplotmn16 = (m_n16 - baseline16)/(max16-baseline16)*2.5*10^-9
%p16 = plot((xaxis16 - offset16)/3600, testplotmn16*10^9, 'color', green_seafoam, 'LineWidth',2)
%[T,Y] = ode45(@fmin_toehold_norm_16,[0 86400],[start_conc16*(max16b-baseline16)/(max16-baseline16), 0, 0, exp(estimated_k)],options);
%p16b = plot(T/3600,Y(:,3)*10^9, ':', 'color', green_seafoam, 'LineWidth',2);
%average(16) = exp(estimated_k)
%[T,Y] = ode45(@toehold_ave_16,[0 86400],[start_conc16*(max16b-baseline16)/(max16-baseline16), 0, 0],options);
%p16c = plot(T/3600,Y(:,3)*10^9,':', 'color', grey, 'LineWidth',2)



%legend([p1 p2 p3 p4 p5 p6 p7 p8 p8c],'C = 2.5 nM, R = 2.5 nM', 'C = 2.5 nM, R = 2.5 nM', 'C = 1 nM, R = 0.5 nM','C = 2.5 nM, R = 0.5 nM', 'C = 2.5 nM, R = 0.5 nM', 'C = 1 nM, R = 0.5 nM','C = 2 nM, R = 0.5 nM', 'C = 5 nM, R = 0.5 nM', 'average fit', 'Location', 'Best')

legend([p9 p10 p11 p12 p13 p15 p15c],'C = 10 nM, R = 0.5 nM', 'C = 1 nM, R = 0.5 nM', 'C = 2.5 nM, R = 0.5 nM', 'C = 5 nM, R = 0.5 nM','C = 1 nM, R = 0.5 nM', 'C = 2.5 nM, R = 0.5 nM', 'average fit', 'Location', 'Best')

%LEGEND BOXOFF
set(gca,'FontSize',14);
xlabel('Time (in hours)','FontSize',16);
ylabel('Normalized Fluorescence (nM)', 'FontSize', 16);
title('m6n4 plot mean squared error fit plot 2 of 2', 'FontSize', 16);
