%m2n4
% k2 = 0.001
% k1 = 1
%fmin k2 = 0.002
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

m_n1 = cleanm2n024m4n2(:, 4); 
m_n2 = cleanm2n024m4n2v2(:, 4);  
m_n3 = cleanm2n024m4n2v3(:, 4);

xaxis1 = cleanm2n024m4n2(:, 1); 
xaxis2 = cleanm2n024m4n2v2(:, 1); 
xaxis3 = cleanm2n024m4n2v3(:, 1); 

baseline1 = 7.6 *10^4; %min(m_n1); 
baseline2 = 4.6*10^4; %min(m_n2); 
baseline3 = 5.6*10^4; %min(m_n3); 

max1 = max(m_n1);
max2 = max(m_n2);
max3 = max(m_n3);

max1b = max1;
max2b = max2;
max3b = max3;