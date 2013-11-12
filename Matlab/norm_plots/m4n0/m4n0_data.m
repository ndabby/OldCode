%m4n0
%k2 = 0.0004
%k1 = 1
% fmin k2 = 0.00048662
%
index_offset1 = 22;
index_offset2 = 8;
index_offset3 = 7;

offset1 = 1300;
offset2 = 600;
offset3 = 400;

start_conc1 = 50 * 10^(-9); 
start_conc2 = 50 * 10^(-9); 
start_conc3 = 100 * 10^(-9); 

m_n1 = cleanm2n6m4n04m6n0(:, 3); 
m_n2 = cleanm2n6m4n04m6n0v2(:, 3);  
m_n3 = cleanm2n6m4n04m6n0v3(:, 3);

xaxis1 = cleanm2n6m4n04m6n0(:, 1); 
xaxis2 = cleanm2n6m4n04m6n0v2(:, 1); 
xaxis3 = cleanm2n6m4n04m6n0v3(:, 1); 

baseline1 = min(m_n1)+ 4.5* 10^4; 
baseline2 = min(m_n2)+ 4.5* 10^4; 
baseline3 = min(m_n3)+ 4.5* 10^4;

max1 = max(m_n1);
max2 = max(m_n2);
max3 = max(m_n3);

max1b = max1;
max2b = max2;
max3b = max3;

