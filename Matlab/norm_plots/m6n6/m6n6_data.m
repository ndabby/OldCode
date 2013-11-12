%m6n6
%k2 = 0.0015; %high concentration data
%k1 = 400000

%concentration_difference1 = 0
%concentration_difference2 = 0
%concentration_difference3 = 0.5 * 10^(-9);
%concentration_difference4 = 2 * 10^(-9);
%concentration_difference5 = 2 * 10^(-9);
%concentration_difference6 = 0
%concentration_difference7 = 0


index_offset1 = 9;
index_offset2 = 23;
index_offset3 = 7;
index_offset4 = 7;
index_offset5 = 7;
index_offset6 = 7;
index_offset7 = 7;
index_offset8 = 7;
index_offset9 = 7;

offset1 = 600;
offset2 = 400;
offset3 = 1000;
offset4 = 1500;
offset5 = 00;
offset6 = 400;
offset7 = 400;
offset8 = 600;
offset9 = 450;

start_conc1 = 2.5 * 10^(-9);
start_conc2 = 2.5 * 10^(-9);
start_conc3 = 0.5 * 10^(-9); 
start_conc4 = 0.5 * 10^(-9); 
start_conc5 = 0.5 * 10^(-9); 
start_conc6 = 2.5 * 10^(-9);
start_conc7 = 2.5 * 10^(-9);
start_conc8 = 2.5 * 10^(-9);
start_conc9 = 2.5 * 10^(-9);

m_n1 = cleanm4n6m6n246(:, 5); 
m_n2 = cleanm4n6m6n246v2(:, 5); 
m_n3 = cleanm4n6m6n246v3(:, 5); 
m_n4 = cleanm4n6m6n246v4(:, 5);  
m_n5 = cleanm4n6m6n246v5(:, 5);
m_n6 = m6n44m6n66redov1(:, 4);
m_n7 = m6n44m6n66redov1(:, 5);
m_n8 = d_m6n246v9(:, 5);
m_n9 = rev_m6n246v10(:, 5);

xaxis1 = cleanm4n6m6n246(:, 1); 
xaxis2 = cleanm4n6m6n246v2(:, 1); 
xaxis3 = cleanm4n6m6n246v3(:, 1); 
xaxis4 = cleanm4n6m6n246v4(:, 1); 
xaxis5 = cleanm4n6m6n246v5(:, 1); 
xaxis6 = m6n44m6n66redov1(:, 1);
xaxis7 = m6n44m6n66redov1(:, 1);
xaxis8 = d_m6n246v9(:, 1);
xaxis9 = rev_m6n246v10(:, 1);

baseline1 = min(m_n1);
baseline2 = min(m_n2);
baseline3 = min(m_n3);
baseline4 = min(m_n4);
baseline5 = min(m_n5);
baseline6 = min(m_n6);
baseline7 = min(m_n7);
baseline8 = min(m_n8);
baseline9 = min(m_n9);

max1 = max(m_n1);
max2 = max(m_n2);
max3 = max(m_n3);
max4 = max(m_n4);
max5 = max(m_n5);
max6 = max(m_n6);
max7 = max(m_n7);
max8 = max(m_n8);
max9 = max(m_n9);

max1b = 2.9*10^4; %max1;
max2b = 1.77*10^5; %max2;
max3b = max3;
max4b = 3.35*10^4
max5b = max5;
max6b = 3.52*10^4;
max7b = 3.33 *10^4;
max8b = max8;
max9b = max9;