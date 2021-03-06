%m6n4
%k2 = 0.001; %high concentration data
%k1 = 80000

%concentration_difference1 = 0
%concentration_difference2 = 0
%concentration_difference3 = 0.5 * 10^(-9);
%concentration_difference4 = 2 * 10^(-9);
%concentration_difference5 = 2 * 10^(-9);
%concentration_difference6 = 0.5 * 10^(-9);
%concentration_difference7 = 2 * 10^(-9);
%concentration_difference8 = 4.5 * 10^(-9);
%concentration_difference9 = 9.5 * 10^(-9);
%concentration_difference10 = 0.5 * 10^(-9);
%concentration_difference11 = 2 * 10^(-9);
%concentration_difference12 = 4.5 * 10^(-9);

offset1 = 400;
offset2 = 400;
offset3 = 400;
offset4 = 400;
offset5 = 400;
offset6 = 400;
offset7 = 400;
offset8 = 400;
offset9 = 400;
offset10 = 400;
offset11 = 400;
offset12 = 400;

start_conc1 = 2.5 * 10^(-9);
start_conc2 = 2.5 * 10^(-9);
start_conc3 = 0.5 * 10^(-9); 
start_conc4 = 0.5 * 10^(-9); 
start_conc5 = 0.5 * 10^(-9); 
start_conc6 = 0.5 * 10^(-9);
start_conc7 = 0.5 * 10^(-9);
start_conc8 = 0.5 * 10^(-9);
start_conc9 = 0.5 * 10^(-9);
start_conc10 = 0.5 * 10^(-9);
start_conc11 = 0.5 * 10^(-9);
start_conc12 = 0.5 * 10^(-9);

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

xaxis1 = cleanm4n6m6n246(:, 1);
xaxis2 = cleanm4n6m6n246v2(:, 1);
xaxis3 = cleanm4n6m6n246v3(:, 1); 
xaxis4 = cleanm4n6m6n246v4(:, 1); 
xaxis5 = cleanm4n6m6n246v5(:, 1); 
xaxis6 = m6n44m6n66redov1(:, 1);
xaxis7 = m6n44m6n66redov1(:, 1);
xaxis8 = m6n244redov2(:, 1);
xaxis9 = m6n244redov2(:, 1);
xaxis10 = m6n2444redov3(:, 1);
xaxis11 = m6n2444redov3(:, 1);
xaxis12 = m6n2444redov3(:, 1);

baseline1 = min(m_n1);
baseline2 = min(m_n2);
baseline3 = min(m_n3);
baseline4 = min(m_n4);
baseline5 = min(m_n5);
baseline6 = min(m_n6);
baseline7 = min(m_n7);
baseline8 = min(m_n8);
baseline9 = min(m_n9);
baseline10 = min(m_n10);
baseline11 = min(m_n11);
baseline12 = min(m_n12);

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


max1b = 2.9 *10^4;
max2b = 1.5*10^5;
max3b = 0.9*10^4; %max1;
max4b = 5.6*10^4; %max2;
max5b = 1.95*10^4; %max3;
max6b = max6;
max7b = max7;
max8b = max8;
max9b = max9;
max10b = max10;
max11b = max11;
max12b = max12;
