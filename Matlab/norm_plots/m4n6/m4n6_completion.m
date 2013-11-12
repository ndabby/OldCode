%m4n6 trying to understand completion levels:
%in nanomolar 
addpath /Users/nadinedabby/Desktop/PrettyMatlab/


end_index = 15*60;



m_n1 = cleanm4n6m6n246(:, 2); 
m_n2 = cleanm4n6m6n246v2(:, 2); 
m_n3 = cleanm4n6m6n246v3(:, 2); 
m_n4 = cleanm4n6m6n246v4(:, 2);  
m_n5 = cleanm4n6m6n246v5(:, 2);




m_n1f = cleanm4n6m6n246(end_index, 2); %batch1 /init1
m_n2f = cleanm4n6m6n246v2(end_index, 2); %batch1 /init#3
m_n3f = cleanm4n6m6n246v3(end_index, 2); %batch1 /init#4
m_n4f = cleanm4n6m6n246v4(end_index, 2);  %batch 1 / polyT  / init5
m_n5f = cleanm4n6m6n246v5(end_index, 2); %batch 1 / polyT    /init5

max1 = max(m_n1);
max2 = max(m_n2);
max3 = max(m_n3);
max4 = max(m_n4);
max5 = max(m_n5);




conc1 = 2.5; % =
conc2 = 2.5;% =
conc3 = 1; % >
conc4 = 2.5;% >
conc5 = 2.5;% >




k1 = 4.835175359950389e+05;
k2 = 4.343954927189927e+05;
k3 = 1.045474710012968e+05;
k4 = 2.319511049924896e+05;
k5 = 1.330454690679667e+05;




close all;
f = figure(1);
set(f,'Color',[1 1 1]);
subplot(2,2,1);
a1 = plot(conc1, m_n1f*100/max1, 'o', 'MarkerFaceColor', yellow_gold, 'MarkerSize', 10);
hold
a2 = plot(conc2, m_n2f*100/max2, 'o', 'MarkerFaceColor', green_seafoam, 'MarkerSize', 10);
a3 = plot(conc3, m_n3f*100/max3, '^', 'MarkerFaceColor', fuschia, 'MarkerSize', 10);
a4 = plot(conc4, m_n4f*100/max4, '^', 'MarkerFaceColor', pink, 'MarkerSize', 10);
a5 = plot(conc5, m_n5f*100/max5, '^', 'MarkerFaceColor', pink, 'MarkerSize', 10);



xlim([0 3]);
ylim([70, 100]);
set(gca,'FontSize',14);
xlabel('complex concentration','FontSize',20);
ylabel('% completion', 'FontSize', 20);


subplot(2,2,2);
b1 = plot(conc1, k1, 'o', 'MarkerFaceColor', yellow_gold, 'MarkerSize', 10);
hold
b2 = plot(conc2, k2, 'o', 'MarkerFaceColor', green_seafoam, 'MarkerSize', 10);
b3 = plot(conc3, k3, '^', 'MarkerFaceColor', fuschia, 'MarkerSize', 10);
b4 = plot(conc4, k4, '^', 'MarkerFaceColor', pink, 'MarkerSize', 10);
b5 = plot(conc5, k5, '^', 'MarkerFaceColor', pink, 'MarkerSize', 10);

xlim([0 3]);
ylim([0, 500000]);
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

xlim([70, 100]);
ylim([0, 500000]);
legend([c3 c4 c1 c2],'C = 4 weeks, R = 3 weeks', 'C = 3 to 4 months, R = 6 to 8 weeks', 'C = 1 day, R = 5 months', 'C = 3 weeks, R = 6 months',  'Location','EastOutside')
set(gca,'FontSize',14);
xlabel('% completion','FontSize',20);
ylabel('Fitted k_1', 'FontSize', 20);

