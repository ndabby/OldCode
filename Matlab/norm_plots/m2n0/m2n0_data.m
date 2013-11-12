%m2n0
%k2 = 0.0004
%k1 = 0.06
%fmin k2 = 0.00048662
%
index_offset1 = 7;
index_offset2 = 7;
index_offset3 = 7;

offset1 = 600;
offset2 = 600;
offset3 = 600;

start_conc1 = 120 * 10^(-9); 
start_conc2 = 120 * 10^(-9); 
start_conc3 = 250 * 10^(-9); 

m_n1 = cleanm2n024m4n2(:, 2); 
m_n2 = cleanm2n024m4n2v2(:, 2);  
m_n3 = cleanm2n024m4n2v3(:, 2);

xaxis1 = cleanm2n024m4n2(:, 1); 
xaxis2 = cleanm2n024m4n2v2(:, 1); 
xaxis3 = cleanm2n024m4n2v3(:, 1); 

baseline1 = 9.4*10^4; %min(m_n1); 
baseline2 = 5*10^4; %min(m_n2); 
baseline3 = 6*10^4; %min(m_n3); 

max1 = max(m_n1);
max2 = max(m_n2);
max3 = max(m_n3);

max1b = max1;
max2b = max2;
max3b = max3;