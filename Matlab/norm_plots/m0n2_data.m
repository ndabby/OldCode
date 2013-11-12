%m0n2
% k2 = 0.0004
% k1 = 0.05


offset1 = 900;
offset2 = 900;
offset3 = 900;

start_conc1 = 120 * 10^(-9); 
start_conc2 = 120 * 10^(-9); 
start_conc3 = 250 * 10^(-9); 

m_n1 = cleanm0n0246(:, 3); 
m_n2 = cleanm0n0246v2(:, 3);  
m_n3 = cleanm0n0246v3(:, 3);

xaxis1 = cleanm0n0246(:, 1); 
xaxis2 = cleanm0n0246v2(:, 1); 
xaxis3 = cleanm0n0246v3(:, 1); 

baseline1 = 4.14 * 10^4; %min(m_n1); 
baseline2 =  5.34 *10^4; %min(m_n2); 
baseline3 =  6.16 *10^4;  %min(m_n3); 

max1 = max(m_n1);
max2 = max(m_n2);
max3 = max(m_n3);

max1b = max1;
max2b = max2;
max3b = max3;