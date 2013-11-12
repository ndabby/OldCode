%m4n6
%k2 = 0.001; %high concentration data
%k1 = 150000

%concentration_difference1 = 0
%concentration_difference2 = 0
%concentration_difference3 = 0.5 * 10^(-9);
%concentration_difference4 = 2 * 10^(-9);
%concentration_difference5 = 2 * 10^(-9);

offset1 = 400;
offset2 = 400;
offset3 = 400;
offset4 = 400;
offset5 = 400;

start_conc1 = 2.5 * 10^(-9);
start_conc2 = 2.5 * 10^(-9);
start_conc3 = 0.5 * 10^(-9); 
start_conc4 = 0.5 * 10^(-9); 
start_conc5 = 0.5 * 10^(-9); 

m_n1 = cleanm4n6m6n246(:, 2);
m_n2 = cleanm4n6m6n246v2(:, 2);
m_n3 = cleanm4n6m6n246v3(:, 2); 
m_n4 = cleanm4n6m6n246v4(:, 2);  
m_n5 = cleanm4n6m6n246v5(:, 2);

xaxis1 = cleanm4n6m6n246(:, 1); 
xaxis2 = cleanm4n6m6n246v2(:, 1); 
xaxis3 = cleanm4n6m6n246v3(:, 1); 
xaxis4 = cleanm4n6m6n246v4(:, 1); 
xaxis5 = cleanm4n6m6n246v5(:, 1); 

baseline1 = min(m_n1);
baseline2 = min(m_n2);
baseline3 = min(m_n3);
baseline4 = min(m_n4);
baseline5 = min(m_n5);

max1 = max(m_n1);
max2 = max(m_n2);
max3 = max(m_n3);
max4 = max(m_n4);
max5 = max(m_n5);

max1b = 3.63 * 10^4;
max2b = 1.7 * 10^5;
max3b = 1.65 *10^4; %max3;
max4b = 4* 10^4; %max4;
max5b = 1.84*10^4; %max5;