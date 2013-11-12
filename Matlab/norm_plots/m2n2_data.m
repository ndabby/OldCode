%m2n2
%k2 = 0.001;
%k1 = 0.125;


offset1 = 600;
offset2 = 600;
offset3 = 600;

start_conc1 = 120 * 10^(-9); 
start_conc2 = 120 * 10^(-9); 
start_conc3 = 250 * 10^(-9); 

m_n1 = cleanm2n024m4n2(:, 3); 
m_n2 = cleanm2n024m4n2v2(:, 3);  
m_n3 = cleanm2n024m4n2v3(:, 3);

xaxis1 = cleanm2n024m4n2(:, 1); 
xaxis2 = cleanm2n024m4n2v2(:, 1); 
xaxis3 = cleanm2n024m4n2v3(:, 1); 

baseline1 = 9*10^4; %min(m_n1); 
baseline2 = 5*10^4; %min(m_n2); 
baseline3 = 6.4*10^4; %min(m_n3); 

max1 = max(m_n1);
max2 = max(m_n2);
max3 = max(m_n3);

max1b = max1;
max2b = max2;
max3b = max3;