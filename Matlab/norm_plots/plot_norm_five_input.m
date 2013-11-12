function testplotmn = plot_norm_five_input(xaxis1, xaxis2, xaxis3, xaxis4, xaxis5, m_n1, m_n2, m_n3, m_n4, m_n5, start_conc1, start_conc2, start_conc3, start_conc4, start_conc5, offset1, offset2, offset3, offset4, offset5, baseline1, baseline2, baseline3, baseline4, baseline5, max1, max2, max3, max4, max5, max1b, max2b, max3b, max4b, max5b)

%x-axis = over-all time
%start_conc = limited reactant concentration
%offset = start time
%baseline = low fluorescence level
%max = high fluorescence level

options = odeset('MaxStep',100,'refine',1e-10,'InitialStep',100,'RelTol',1e-10,'AbsTol',1e-10)

testplotmn1 = (m_n1 - baseline1)/(max1-baseline1)*start_conc1
p1 = plot((xaxis1 - offset1), testplotmn1, 'color', fuschia, 'LineWidth',2)
hold
[T,Y] = ode45(@toehold_norm_1,[0 86400],[start_conc1*max1b/max1, 0, 0],options);
p1b = plot(T,Y(:,3),':', 'color', fuschia, 'LineWidth',2)

testplotmn2 = (m_n2 - baseline2)/(max2-baseline2)*start_conc2
p2 = plot((xaxis2 - offset2), testplotmn2, 'color', pink, 'LineWidth',2)

[T,Y] = ode45(@toehold_norm_2,[0 86400],[start_conc2*max2b/max2, 0, 0],options);
p2b = plot(T,Y(:,3), ':', 'color', pink, 'LineWidth',2)

testplotmn3 = (m_n3 - baseline3)/(max3-baseline3)*start_conc3
p3 = plot((xaxis3 - offset3), testplotmn3, 'color', red_lipstick, 'LineWidth',2)

[T,Y] = ode45(@toehold_norm_3,[0 86400],[start_conc3*max3b/max3, 0, 0],options);
p3b = plot(T,Y(:,3), ':', 'color', red_lipstick, 'LineWidth',2)

testplotmn4 = (m_n4 - baseline4)/(max4-baseline4)*start_conc4
p4 = plot((xaxis4 - offset4), testplotmn4, 'color', purple, 'LineWidth',2)

[T,Y] = ode45(@toehold_norm_4,[0 86400],[start_conc4*max4b/max4, 0, 0],options);
p4b = plot(T,Y(:,3), ':', 'color', purple, 'LineWidth',2)

testplotmn5 = (m_n5 - baseline5)/(max5-baseline5)*start_conc5
p5 = plot((xaxis5 - offset5), testplotmn5, 'color', blue_midnight, 'LineWidth',2)

[T,Y] = ode45(@toehold_norm_5,[0 86400],[start_conc5*max5b/max5, 0, 0],options);
p5b = plot(T,Y(:,3), ':', 'color', blue_midnight, 'LineWidth',2)

legend([p1 p2 p3 p4 p5],'C = 2.5 nM, R = 2.5 nM', 'C = 2.5 nM, R = 2.5 nM', 'C = 1 nM, R = 0.5 nM', 'C = 2.5 nM, R = 0.5 nM', 'C = 2.5 nM, R = 0.5 nM')
