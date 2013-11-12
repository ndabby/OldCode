%m2n6
%k1 = 460
%k2 = 0.001 -- 10x speed-up here doesn't affect plot very much
%

offset1 = 1300;
offset2 = 400;
offset3 = 500;

start_conc1 = 50 * 10^(-9); 
start_conc2 = 50 * 10^(-9); 
start_conc3 = 25 * 10^(-9); 

m_n1 = cleanm2n6m4n04m6n0(:,2); 
m_n2 = cleanm2n6m4n04m6n0v2(:,2); 
m_n3 = cleanm2n6m4n04m6n0v3(:,2); 

xaxis1 = cleanm2n6m4n04m6n0(:,1); 
xaxis2 = cleanm2n6m4n04m6n0v2(:,1);  
xaxis3 = cleanm2n6m4n04m6n0v3(:,1); 

baseline1 = min(m_n1); 
baseline2 = min(m_n2); 
baseline3 = min(m_n3); 

max1 = max(m_n1);
max2 = max(m_n2);
max3 = max(m_n3);

max1b = 1119500;
max2b = 1120000;
max3b = max3;