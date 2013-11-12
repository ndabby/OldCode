%m0n0
% k2 = 0.0004
% k1 = 0.05


offset1 = 900;
offset2 = 900;
offset3 = 900;

start_conc1 = 120 * 10^(-9); 
start_conc2 = 120 * 10^(-9); 
start_conc3 = 250 * 10^(-9); 

m_n1 = cleanm0n0246(:, 2); 
m_n2 = cleanm0n0246v2(:, 2);  
m_n3 = cleanm0n0246v3(:, 2);

xaxis1 = cleanm0n0246(:, 1); 
xaxis2 = cleanm0n0246v2(:, 1); 
xaxis3 = cleanm0n0246v3(:, 1); 

baseline1 = cleanm0n0246(7, 2); 
baseline2 = cleanm0n0246v2(7, 2); 
baseline3 = cleanm0n0246v3(7, 2); 

max1 = max(m_n1);
max2 = max(m_n2);
max3 = max(m_n3);


max1b = 2.62*10^6
max2b = 2.76 * 10^6;
max3b = 6.4 * 10^6;