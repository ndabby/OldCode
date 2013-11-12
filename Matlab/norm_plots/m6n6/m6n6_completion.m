%m6n6 trying to understand completion levels:
%in nanomolar 
addpath /Users/nadinedabby/Desktop/PrettyMatlab/


end_index = 15*60;



%m_n1 = cleanm4n6m6n246(:, 5); 
m_n2 = cleanm4n6m6n246v2(:, 5); 
m_n3 = cleanm4n6m6n246v3(:, 5); 
m_n4 = cleanm4n6m6n246v4(:, 5);  
m_n5 = cleanm4n6m6n246v5(:, 5);
m_n6 = m6n44m6n66redov1(:, 4);
m_n7 = m6n44m6n66redov1(:, 5);
m_n8 = d_m6n246v9(:, 5);



%m_n1f = cleanm4n6m6n246(end_index, 5); %batch1 /init1
m_n2f = cleanm4n6m6n246v2(end_index, 5); %batch1 /init#3
m_n3f = cleanm4n6m6n246v3(end_index, 5); %batch1 /init#4
m_n4f = cleanm4n6m6n246v4(end_index, 5);  %batch 1 / polyT  / init5
m_n5f = cleanm4n6m6n246v5(end_index, 5); %batch 1 / polyT    /init5
m_n6f = m6n44m6n66redov1(end_index, 4); %batch1 /polyT  /init5 
m_n7f = m6n44m6n66redov1(end_index, 5); %batch1 / polyT   /init 5
m_n8f = d_m6n246v9(end_index, 5); %batch 3 /PolyT / fresh init x

%max1 = max(m_n1);
max2 = max(m_n2);
max3 = max(m_n3);
max4 = max(m_n4);
max5 = max(m_n5);
max6 = max(m_n6);
max7 = max(m_n7);
max8 = max(m_n8);


%conc1 = 2.5; % =
conc2 = 2.5;% =
conc3 = 1; % >
conc4 = 2.5;% >
conc5 = 2.5;% >
conc6 = 2.5;% =
conc7 = 2.5;% =
conc8 = 2.5;% =


%k1 =1959432.58179624;
k2 = 1.120292109246599e+06;
k3 =1.812834015088530e+05;
k4 = 8.809409891578829e+05;
k5 = 8.586408539983364e+05;
k6 = 3.433155560923086e+05;
k7 = 5.000338514112035e+05;
k8 = 9.439439964580348e+05;



close all;
f = figure(1);
set(f,'Color',[1 1 1]);
subplot(2,2,1);
%a1 = plot(conc1, m_n1f*100/max1, 'o', 'MarkerFaceColor', red_lipstick, 'MarkerSize', 10);
%hold
a2 = plot(conc2, m_n2f*100/max2, 'o', 'MarkerFaceColor', green_seafoam, 'MarkerSize', 10);
hold 
a3 = plot(conc3, m_n3f*100/max3, '^', 'MarkerFaceColor', fuschia, 'MarkerSize', 10);
a4 = plot(conc4, m_n4f*100/max4, '^', 'MarkerFaceColor', pink, 'MarkerSize', 10);
a5 = plot(conc5, m_n5f*100/max5, '^', 'MarkerFaceColor', pink, 'MarkerSize', 10);
a6 = plot(conc6, m_n6f*100/max6, 'o', 'MarkerFaceColor', blue_middle, 'MarkerSize', 10);
a7 = plot(conc7, m_n7f*100/max7, 'o', 'MarkerFaceColor', blue_middle, 'MarkerSize', 10);
a8 = plot(conc8, m_n8f*100/max8, 'o', 'MarkerFaceColor', red_lipstick, 'MarkerSize', 10);

xlim([0 3]);
ylim([75, 100]);
%legend([p1 p2 p3 p4 p5 p6 p7 p8 p9],'C = 2.5 nM, R = 2.5 nM', 'C = 2.5 nM, R = 2.5 nM', 'C = 1 nM, R = 0.5 nM', 'C = 2.5 nM, R = 0.5 nM', 'C = 2.5 nM, R = 0.5 nM','C = 2.5 nM, R = 2.5 nM', 'C = 2.5 nM, R = 2.5 nM', 'C = 2.5 nM, R = 2.5 nM******','C = 2.5 nM, R = 2.5 nM*****', 'Location','Best')
set(gca,'FontSize',14);
xlabel('complex concentration','FontSize',20);
ylabel('% completion', 'FontSize', 20);


subplot(2,2,2);
%b1 = plot(conc1, k1, 'o', 'MarkerFaceColor', red_lipstick, 'MarkerSize', 10);
%hold
b2 = plot(conc2, k2, 'o', 'MarkerFaceColor', green_seafoam, 'MarkerSize', 10);
hold
b3 = plot(conc3, k3, '^', 'MarkerFaceColor', fuschia, 'MarkerSize', 10);
b4 = plot(conc4, k4, '^', 'MarkerFaceColor', pink, 'MarkerSize', 10);
b5 = plot(conc5, k5, '^', 'MarkerFaceColor', pink, 'MarkerSize', 10);
b6 = plot(conc6, k6, 'o', 'MarkerFaceColor', blue_middle, 'MarkerSize', 10);
b7 = plot(conc7, k7, 'o', 'MarkerFaceColor', blue_middle, 'MarkerSize', 10);
b8 = plot(conc8, k8, 'o', 'MarkerFaceColor', red_lipstick, 'MarkerSize', 10);

xlim([0 3]);
ylim([0, 1500000]);
%legend([p1 p2 p3 p4 p5 p6 p7 p8 p9],'C = 2.5 nM, R = 2.5 nM', 'C = 2.5 nM, R = 2.5 nM', 'C = 1 nM, R = 0.5 nM', 'C = 2.5 nM, R = 0.5 nM', 'C = 2.5 nM, R = 0.5 nM','C = 2.5 nM, R = 2.5 nM', 'C = 2.5 nM, R = 2.5 nM', 'C = 2.5 nM, R = 2.5 nM******','C = 2.5 nM, R = 2.5 nM*****', 'Location','Best')
set(gca,'FontSize',14);
xlabel('complex concentration','FontSize',20);
ylabel('Fitted k_1', 'FontSize', 20);


subplot(2,2,3);
%c1 = plot(m_n1f*100/max1, k1, 'o', 'MarkerFaceColor', red_lipstick, 'MarkerSize', 10);
%hold
c2 = plot(m_n2f*100/max2, k2, 'o', 'MarkerFaceColor', green_seafoam, 'MarkerSize', 10);
hold
c3 = plot(m_n3f*100/max3, k3, '^', 'MarkerFaceColor', fuschia, 'MarkerSize', 10);
c4 = plot(m_n4f*100/max4,k4, '^', 'MarkerFaceColor', pink, 'MarkerSize', 10);
c5 = plot(m_n5f*100/max5, k5, '^', 'MarkerFaceColor', pink, 'MarkerSize', 10);
c6 = plot(m_n6f*100/max6, k6,'o', 'MarkerFaceColor', blue_middle, 'MarkerSize', 10);
c7 = plot(m_n7f*100/max7,k7, 'o', 'MarkerFaceColor', blue_middle, 'MarkerSize', 10);
c8 = plot(m_n8f*100/max8,k8, 'o', 'MarkerFaceColor', red_lipstick, 'MarkerSize', 10);

xlim([75, 100]);
ylim([0, 1500000]);
legend([c8 c3 c4 c2 c6],'C = 1 day, R = 1 day','C = 4 weeks, R = 3 weeks', 'C = 3 to 4 months, R = 6 to 8 weeks', 'C = 3 weeks, R = 6 months', 'C = 6 months, R = 6 months', 'Location','EastOutside')
set(gca,'FontSize',14);
xlabel('% completion','FontSize',20);
ylabel('Fitted k_1', 'FontSize', 20);

