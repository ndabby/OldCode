%m4n2
% k2 = 0.001
% k1 = 50


offset1 = 400;
offset2 = 400;
offset3 = 400;

start_conc1 = 120 * 10^(-9); 
start_conc2 = 120 * 10^(-9); 
start_conc3 = 250 * 10^(-9); 

m_n1 = cleanm2n024m4n2(:, 5); 
m_n2 = cleanm2n024m4n2v2(:, 5);  
m_n3 = cleanm2n024m4n2v3(:, 5);

xaxis1 = cleanm2n024m4n2(:, 1); 
xaxis2 = cleanm2n024m4n2v2(:, 1); 
xaxis3 = cleanm2n024m4n2v3(:, 1); 

baseline1 = min(m_n1); 
baseline2 = min(m_n2); 
baseline3 = min(m_n3); 

max1 = max(m_n1);
max2 = max(m_n2);
max3 = max(m_n3);

max1b = 2.5*10^6;% max1;
max2b = max2;
max3b = max3;
