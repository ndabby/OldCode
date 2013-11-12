%m6n2 trying to understand completion levels:
%in nanomolar 
addpath /Users/nadinedabby/Desktop/PrettyMatlab/


end_index = 15*60;



m_n1 = cleanm4n6m6n246(:, 3); 
m_n2 = cleanm4n6m6n246v2(:, 3); 
%m_n3 = cleanm4n6m6n246v3(:, 3); 
m_n4 = cleanm4n6m6n246v4(:, 3);  
%m_n5 = cleanm4n6m6n246v5(:, 3);
%m_n6 = m6n244redov2(:, 2);
m_n7 = m6n2444redov3(:, 2);
m_n8 = d_m6n246v9(:, 3);
%m_n9 = rev_m6n246v10(:, 3);



m_n1f = cleanm4n6m6n246(end_index, 3); %batch1 /init1
m_n2f = cleanm4n6m6n246v2(end_index, 3); %batch1 /init#3
%m_n3f = cleanm4n6m6n246v3(end_index, 3); %batch1 /init#4
m_n4f = cleanm4n6m6n246v4(end_index, 3);  %batch 1 / polyT  / init5
%m_n5f = cleanm4n6m6n246v5(end_index, 3); %batch 1 / polyT    /init5
%m_n6f = m6n244redov2(end_index, 2);     %batch1 / polyT   /init 5 
m_n7f = m6n2444redov3(end_index, 2); %batch 2 /polyT /init5
m_n8f = d_m6n246v9(end_index, 3); %batch 3 / polyT / Fresh init x

max1 = max(m_n1);
max2 = max(m_n2);
%max3 = max(m_n3);
max4 = max(m_n4);
%max5 = max(m_n5);
%max6 = max(m_n6);
max7 = max(m_n7);
max8 = max(m_n8);



conc1 = 5; % >
conc2 = 5;% >
%conc3 = 5; % >
conc4 = 5;% >
%conc5 = 5;% >
%conc6 = 5;% >
conc7 = 5;% >
conc8 = 5;% >




k1 = 1.208860903498386e+04;
k2 = 7.250533872912291e+03; 
%k3 = 
k4 = 5.297156406925094e+03;
%k5 = 
%k6 = 
k7 = 1.378394444171464e+04;
k8 = 8.596893746854805e+03;



close all;
f = figure(1);
set(f,'Color',[1 1 1]);
subplot(2,2,1);
a1 = plot(conc1, m_n1f*100/max1, '^', 'MarkerFaceColor', yellow_gold, 'MarkerSize', 10);
hold
a2 = plot(conc2, m_n2f*100/max2, '^', 'MarkerFaceColor', green_seafoam, 'MarkerSize', 10);
%hold 
%a3 = plot(conc3, m_n3f*100/max3, '^', 'MarkerFaceColor', pink, 'MarkerSize', 10);
a4 = plot(conc4, m_n4f*100/max4, '^', 'MarkerFaceColor', pink, 'MarkerSize', 10);
%a5 = plot(conc5, m_n5f*100/max5, '^', 'MarkerFaceColor', blue_middle, 'MarkerSize', 10);
%a6 = plot(conc6, m_n6f*100/max6, '^', 'MarkerFaceColor', blue_middle, 'MarkerSize', 10);
a7 = plot(conc7, m_n7f*100/max7, '^', 'MarkerFaceColor', green_pistachio, 'MarkerSize', 10);
a8 = plot(conc8, m_n8f*100/max8, '^', 'MarkerFaceColor', red_lipstick, 'MarkerSize', 10);



xlim([0 6]);
ylim([50, 100]);
set(gca,'FontSize',14);
xlabel('complex concentration','FontSize',20);
ylabel('% completion', 'FontSize', 20);


subplot(2,2,2);
b1 = plot(conc1, k1, '^', 'MarkerFaceColor', yellow_gold, 'MarkerSize', 10);
hold
b2 = plot(conc2, k2, '^', 'MarkerFaceColor', green_seafoam, 'MarkerSize', 10);
%hold
%b3 = plot(conc3, k3, '^', 'MarkerFaceColor', pink, 'MarkerSize', 10);
b4 = plot(conc4, k4, '^', 'MarkerFaceColor', pink, 'MarkerSize', 10);
%b5 = plot(conc5, k5, '^', 'MarkerFaceColor', blue_middle, 'MarkerSize', 10);
%b6 = plot(conc6, k6, '^', 'MarkerFaceColor', blue_middle, 'MarkerSize', 10);
b7 = plot(conc7, k7, '^', 'MarkerFaceColor', green_pistachio, 'MarkerSize', 10);
b8 = plot(conc8, k8, '^', 'MarkerFaceColor', red_lipstick, 'MarkerSize', 10);

xlim([0 6]);
ylim([0, 15000]);
set(gca,'FontSize',14);
xlabel('complex concentration','FontSize',20);
ylabel('Fitted k_1', 'FontSize', 20);


subplot(2,2,3);
c1 = plot(m_n1f*100/max1, k1, '^', 'MarkerFaceColor', yellow_gold, 'MarkerSize', 10);
hold
c2 = plot(m_n2f*100/max2, k2, '^', 'MarkerFaceColor', green_seafoam, 'MarkerSize', 10);
%hold
%c3 = plot(m_n3f*100/max3, k3, '^', 'MarkerFaceColor', pink, 'MarkerSize', 10);
c4 = plot(m_n4f*100/max4,k4, '^', 'MarkerFaceColor', pink, 'MarkerSize', 10);
%c5 = plot(m_n5f*100/max5, k5, '^', 'MarkerFaceColor', blue_middle, 'MarkerSize', 10);
%c6 = plot(m_n6f*100/max6, k6,'^', 'MarkerFaceColor', blue_middle, 'MarkerSize', 10);
c7 = plot(m_n7f*100/max7,k7, '^', 'MarkerFaceColor', green_pistachio, 'MarkerSize', 10);
c8 = plot(m_n8f*100/max8,k8, '^', 'MarkerFaceColor', red_lipstick, 'MarkerSize', 10);

xlim([50, 100]);
ylim([0, 15000]);
legend([c8 c4 c1 c7 c2],'C = 1 day, R = 1 day',  'C = 3-4 months, R = 6-8 weeks', 'C = 1 day, R = 5 months', 'C = 1 day, R = 6 months', 'C = 3 weeks, R = 6 months', 'Location','EastOutside')
set(gca,'FontSize',14);
xlabel('% completion','FontSize',20);
ylabel('Fitted k_1', 'FontSize', 20);

