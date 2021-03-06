%m6n6
%k2 = 0.0015; %high concentration data
%k1 = 400000


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

m_n1 = cleanm4n6m6n246(:, 5); 
m_n2 = cleanm4n6m6n246v2(:, 5); 
m_n3 = cleanm4n6m6n246v3(:, 5); 
m_n4 = cleanm4n6m6n246v4(:, 5);  
m_n5 = cleanm4n6m6n246v5(:, 5);

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

max1b = 2.65*10^4; %max1;
max2b = 1.77*10^5; %max2;
max3b = max3;
max4b = max4;
max5b = max5;