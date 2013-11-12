%m6n4 trying to understand completion levels:
%in nanomolar 
addpath /Users/nadinedabby/Desktop/PrettyMatlab/


end_index = 15*60;



m_n1 = cleanm4n6m6n246(:, 4);
m_n2 = cleanm4n6m6n246v2(:, 4);
m_n3 = cleanm4n6m6n246v3(:, 4); 
m_n4 = cleanm4n6m6n246v4(:, 4);  
m_n5 = cleanm4n6m6n246v5(:, 4);
m_n6 = m6n44m6n66redov1(:, 2);
m_n7 = m6n44m6n66redov1(:, 3);
m_n8 = m6n244redov2(:, 3);
m_n9 = m6n244redov2(:, 4);
m_n10 = m6n2444redov3(:, 3);
m_n11 = m6n2444redov3(:, 4);
m_n12 = m6n2444redov3(:, 5)
m_n13 = d_m6n246v9(:, 4);
%m_n14 = rev_m6n246v10(:, 4);
m_n15 = m6n44ddv11_12(:, 2);
%m_n16 = m6n44ddv11_12(:, 3);



m_n1f = cleanm4n6m6n246(end_index, 4); %batch1 /init1
m_n2f = cleanm4n6m6n246v2(end_index, 4); %batch1 /init#3
m_n3f = cleanm4n6m6n246v3(end_index, 4); %batch1 /init#4
m_n4f = cleanm4n6m6n246v4(end_index, 4);  %batch 1 / polyT  / init5
m_n5f = cleanm4n6m6n246v5(end_index, 4); %batch 1 / polyT    /init5
m_n6f = m6n44m6n66redov1(end_index, 2); %batch1 /polyT  /init5 
m_n7f = m6n44m6n66redov1(end_index, 3); %batch1 / polyT   /init 5
m_n8f = m6n244redov2(end_index, 3);     %batch1 / polyT   /init 5 /redilute
m_n9f = m6n244redov2(end_index, 4);     %batch1 / polyT   /init 5 /redilute
m_n10f = m6n2444redov3(end_index, 3); %batch 2 /polyT /init5
m_n11f = m6n2444redov3(end_index, 4); %batch 2 /polyT /init5
m_n12f = m6n2444redov3(end_index, 5) %batch 2 /polyT /init5
m_n13f = d_m6n246v9(end_index, 4); %batch 3 / polyT / Fresh init x
%m_n14f = rev_m6n246v10(end_index, 4);
m_n15f = m6n44ddv11_12(end_index, 2); %batch 3 / polyT / Fresh init x
%m_n16f = m6n44ddv11_12(end_index, 3);

max1 = max(m_n1);
max2 = max(m_n2);
max3 = max(m_n3);
max4 = max(m_n4);
max5 = max(m_n5);
max6 = max(m_n6);
max7 = max(m_n7);
max8 = max(m_n8);
max9 = max(m_n9);
max10 = max(m_n10);
max11 = max(m_n11);
max12 = max(m_n12);
max13 = max(m_n13);
%max14 = max(m_n14);
max15 = max(m_n15);
%max16 = max(m_n16);


conc1 = 2.5; % =
conc2 = 2.5;% =
conc3 = 1; % >
conc4 = 2.5;% >
conc5 = 2.5;% >
conc6 = 1;% >
conc7 = 2;% >
conc8 = 5;% >
conc9 = 10; % >
conc10 = 1;% >
conc11 = 2.5; % >
conc12 = 5;% >
conc13 = 1;% >
%conc14 = 0.5;% <
conc15 = 2.5;% >
%conc16 = 0.5;% <



k1 =9.110720402743070e+04;
k2 = 8.730760583245203e+04;
k3= 9.778710112775819e+04;
k4 = 3.712122306021393e+04;
k5 = 1.173888080326382e+05;
k6 = 1.000628819388286e+05;
k7 = 5.416758523934297e+04;
k8 =7.573216782986597e+04;
k9 = 3.240305621072140e+04; 
k10 =7.973812096095100e+04; 
k11 = 4.015972388793999e+04;
k12 = 3.967347178839290e+04;
k13 = 3.355865527367355e+04;
k15 = 9.517116436319100e+04;



close all;
f = figure(1);
set(f,'Color',[1 1 1]);
subplot(2,2,1);
a1 = plot(conc1, m_n1f*100/max1, 'o', 'MarkerFaceColor', yellow_gold, 'MarkerSize', 10);
hold
a2 = plot(conc2, m_n2f*100/max2, 'o', 'MarkerFaceColor', green_seafoam, 'MarkerSize', 10);
%hold 
a3 = plot(conc3, m_n3f*100/max3, '^', 'MarkerFaceColor', fuschia, 'MarkerSize', 10);
a4 = plot(conc4, m_n4f*100/max4, '^', 'MarkerFaceColor', pink, 'MarkerSize', 10);
a5 = plot(conc5, m_n5f*100/max5, '^', 'MarkerFaceColor', pink, 'MarkerSize', 10);
a6 = plot(conc6, m_n6f*100/max6, '^', 'MarkerFaceColor', blue_middle, 'MarkerSize', 10);
a7 = plot(conc7, m_n7f*100/max7, '^', 'MarkerFaceColor', blue_middle, 'MarkerSize', 10);
a8 = plot(conc8, m_n8f*100/max8, '^', 'MarkerFaceColor', blue_middle, 'MarkerSize', 10);
a9 = plot(conc9, m_n9f*100/max9, '^', 'MarkerFaceColor', blue_middle, 'MarkerSize', 10);
a10 = plot(conc10, m_n10f*100/max10, '^', 'MarkerFaceColor', green_pistachio, 'MarkerSize', 10);
a11 = plot(conc11, m_n11f*100/max11, '^', 'MarkerFaceColor', green_pistachio, 'MarkerSize', 10);
a12 = plot(conc12, m_n12f*100/max12, '^', 'MarkerFaceColor', green_pistachio, 'MarkerSize', 10);
a13 = plot(conc13, m_n13f*100/max13, '^', 'MarkerFaceColor', red_lipstick, 'MarkerSize', 10);
a15 = plot(conc15, m_n15f*100/max15, '^', 'MarkerFaceColor', red_lipstick, 'MarkerSize', 10);



xlim([0 10]);
ylim([50, 100]);
set(gca,'FontSize',14);
xlabel('complex concentration','FontSize',20);
ylabel('% completion', 'FontSize', 20);


subplot(2,2,2);
b1 = plot(conc1, k1, 'o', 'MarkerFaceColor', yellow_gold, 'MarkerSize', 10);
hold
b2 = plot(conc2, k2, 'o', 'MarkerFaceColor', green_seafoam, 'MarkerSize', 10);
%hold
b3 = plot(conc3, k3, '^', 'MarkerFaceColor', fuschia, 'MarkerSize', 10);
b4 = plot(conc4, k4, '^', 'MarkerFaceColor', pink, 'MarkerSize', 10);
b5 = plot(conc5, k5, '^', 'MarkerFaceColor', pink, 'MarkerSize', 10);
b6 = plot(conc6, k6, '^', 'MarkerFaceColor', blue_middle, 'MarkerSize', 10);
b7 = plot(conc7, k7, '^', 'MarkerFaceColor', blue_middle, 'MarkerSize', 10);
b8 = plot(conc8, k8, '^', 'MarkerFaceColor', blue_middle, 'MarkerSize', 10);
b9 = plot(conc9, k9, '^', 'MarkerFaceColor', blue_middle, 'MarkerSize', 10);
b10 = plot(k10, conc10, '^', 'MarkerFaceColor', green_pistachio, 'MarkerSize', 10);
b11 = plot(k11, conc11,  '^', 'MarkerFaceColor', green_pistachio, 'MarkerSize', 10);
b12 = plot(k12, conc12, '^', 'MarkerFaceColor', green_pistachio, 'MarkerSize', 10);
b13 = plot(k13, conc13,  '^', 'MarkerFaceColor', red_lipstick, 'MarkerSize', 10);
b15 = plot(k15, conc15,  '^', 'MarkerFaceColor', red_lipstick, 'MarkerSize', 10);

xlim([0 10]);
ylim([0, 125000]);
set(gca,'FontSize',14);
xlabel('complex concentration','FontSize',20);
ylabel('Fitted k_1', 'FontSize', 20);


subplot(2,2,3);
c1 = plot(m_n1f*100/max1, k1, 'o', 'MarkerFaceColor', yellow_gold, 'MarkerSize', 10);
hold
c2 = plot(m_n2f*100/max2, k2, 'o', 'MarkerFaceColor', green_seafoam, 'MarkerSize', 10);
c3 = plot(m_n3f*100/max3, k3, '^', 'MarkerFaceColor', fuschia, 'MarkerSize', 10);
c4 = plot(m_n4f*100/max4,k4, '^', 'MarkerFaceColor', pink, 'MarkerSize', 10);
c5 = plot(m_n5f*100/max5, k5, '^', 'MarkerFaceColor', pink, 'MarkerSize', 10);
c6 = plot(m_n6f*100/max6, k6,'^', 'MarkerFaceColor', blue_middle, 'MarkerSize', 10);
c7 = plot(m_n7f*100/max7,k7, '^', 'MarkerFaceColor', blue_middle, 'MarkerSize', 10);
c8 = plot(m_n8f*100/max8,k8, '^', 'MarkerFaceColor', blue_middle, 'MarkerSize', 10);
c9 = plot(m_n9f*100/max9,k9, '^', 'MarkerFaceColor', blue_middle, 'MarkerSize', 10);
c10 = plot(m_n10f*100/max10, k10, '^', 'MarkerFaceColor', green_pistachio, 'MarkerSize', 10);
c11 = plot(m_n11f*100/max11, k11, '^', 'MarkerFaceColor', green_pistachio, 'MarkerSize', 10);
c12 = plot(m_n12f*100/max12, k12, '^', 'MarkerFaceColor', green_pistachio, 'MarkerSize', 10);
c13 = plot(m_n13f*100/max13, k13, '^', 'MarkerFaceColor', red_lipstick, 'MarkerSize', 10);
c15 = plot(m_n15f*100/max15, k15, '^', 'MarkerFaceColor', red_lipstick, 'MarkerSize', 10);

xlim([50, 100]);
ylim([0, 125000]);
legend([c13 c3 c4 c1 c10 c2 c6],'C = 1 day, R = 1 day', 'C = 4 weeks, R = 3 weeks', 'C = 3-4 months, R = 6-8 weeks','C = 1 day, R = 5 months', 'C = 1 day, R = 6 months', 'C = 3 weeks, R = 6 months', 'C = 6 months, R = 6 months', 'Location','EastOutside')
set(gca,'FontSize',14);
xlabel('% completion','FontSize',20);
ylabel('Fitted k_1', 'FontSize', 20);

