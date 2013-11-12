%m4n4
%k2 = 0.001; %high concentration data
%k1 = 750

offset1 = 1400;
offset2 = 700;
offset3 = 500;

start_conc1 = 50 * 10^(-9); 
start_conc2 = 50 * 10^(-9); 
start_conc3 = 25 * 10^(-9); 

m_n1 = cleanm2n6m4n04m6n0(:, 4); 
m_n2 = cleanm2n6m4n04m6n0v2(:, 4);  
m_n3 = cleanm2n6m4n04m6n0v3(:, 4);

xaxis1 = cleanm2n6m4n04m6n0(:, 1); 
xaxis2 = cleanm2n6m4n04m6n0v2(:, 1); 
xaxis3 = cleanm2n6m4n04m6n0v3(:, 1); 

baseline1 = min(m_n1);
baseline2 = min(m_n2);
baseline3 = min(m_n3);

max1 = max(m_n1);
max2 = max(m_n2);
max3 = max(m_n3);

max1b = 1.025*10^6; %max1
max2b = 1.1*10^6; %max2;
max3b = 5.6*10^5; %max3;