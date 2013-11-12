function testplotmn = plot_norm(xaxis1, xaxis2, xaxis3, m_n1, m_n2, m_n3, start_conc1, start_conc2, start_conc3, offset1, offset2, offset3, baseline1, baseline2, baseline3, max1, max2, max3, max1b, max2b, max3b)

%x-axis = over-all time
%start_conc = limited reactant concentration
%offset = start time
%baseline = low fluorescence level
%max = high fluorescence level

options = odeset('MaxStep',100,'refine',1e-10,'InitialStep',100,'RelTol',1e-10,'AbsTol',1e-10)

testplotmn1 = (m_n1 - baseline1)/(max1-baseline1)*start_conc1
plot((xaxis1 - offset1), testplotmn1, 'm', 'LineWidth',2)
hold
[T,Y] = ode45(@toehold_norm_1,[0 86400],[start_conc1*max1b/max1, 0, 0],options);
plot(T,Y(:,3),':m', 'LineWidth',2)

testplotmn2 = (m_n2 - baseline2)/(max2-baseline2)*start_conc2
plot((xaxis2 - offset2), testplotmn2, 'b', 'LineWidth',2)

[T,Y] = ode45(@toehold_norm_2,[0 86400],[start_conc2*max2b/max2, 0, 0],options);
plot(T,Y(:,3), ':b', 'LineWidth',2)

testplotmn3 = (m_n3 - baseline3)/(max3-baseline3)*start_conc3
plot((xaxis3 - offset3), testplotmn3, 'k', 'LineWidth',2)

[T,Y] = ode45(@toehold_norm_3,[0 86400],[start_conc3*max3b/max3, 0, 0],options);
plot(T,Y(:,3), ':k', 'LineWidth',2)
