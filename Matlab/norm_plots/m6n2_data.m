%m6n2
%k1 = 0.001;
%k2 = 25000

offset1 = 400;
offset2 = 400;
offset3 = 400;


m_n1 = cleanm4n6m6n246v3(:, 3); 
m_n2 = cleanm4n6m6n246v4(:, 3);  
m_n3 = cleanm4n6m6n246v5(:, 3);

xaxis1 = cleanm4n6m6n246v3(:, 1); 
xaxis2 = cleanm4n6m6n246v4(:, 1); 
xaxis3 = cleanm4n6m6n246v5(:, 1); 

baseline1 = min(m_n1);
baseline2 = min(m_n2);
baseline3 = min(m_n3);

max1 = max(m_n1);
max2 = max(m_n2);
max3 = max(m_n3);

max1b = max1;
max2b = max2;
max3b = max3;

max1b = 29000; %max(m_n1);
max2b = 40000; %max(m_n2);
max3b = 19000;


start_conc1 = 1 * 10^(-9); 
start_conc2 = 0.5 * 10^(-9); 
start_conc3 = 0.5 * 10^(-9); 