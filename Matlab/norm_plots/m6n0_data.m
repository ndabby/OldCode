%m6n0

offset1 = 900;
offset2 = 300;
offset3 = 300;

start_conc1 = 50 * 10^(-9); 
start_conc2 = 50 * 10^(-9); 
start_conc3 = 100 * 10^(-9); 

m_n1 = cleanm2n6m4n04m6n0(:, 5); 
m_n2 = cleanm2n6m4n04m6n0v2(:, 5);  
m_n3 = cleanm2n6m4n04m6n0v3(:, 5);

xaxis1 = cleanm2n6m4n04m6n0(:, 1); 
xaxis2 = cleanm2n6m4n04m6n0v2(:, 1); 
xaxis3 = cleanm2n6m4n04m6n0v3(:, 1); 

baseline1 = min(m_n1);
baseline2 = min(m_n2);
baseline3 = min(m_n3);

max1 = max(m_n1);
max2 = max(m_n2);
max3 = max(m_n3);


max1b = 904000;
max2b = 1060000;
max3b = 2080000;