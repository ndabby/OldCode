%ndisplace
%3-way branch migration starting with april 14 data
% k2 = 0.1
% k1 = 3500
% fmin k2 = 0.1
%

index_offset1 = 7;
index_offset2 = 7;
index_offset3 = 7;


offset1 = 500;
offset2 = 500;
offset3 = 500;


start_conc1 = 120 * 10^(-9); 
start_conc2 = 10 * 10^(-9); 
start_conc3 = 5 * 10^(-9); 

m_n1 = displacev2(:, 5);
m_n2 = displacev3(:, 4);
m_n3 = displacev4(:, 4);

xaxis1 = displacev2(:, 1);
xaxis2 = displacev3(:, 1);
xaxis3 = displacev4(:, 1);

baseline1 = displacev2(6, 5); 
baseline2 = displacev3(6, 4);
baseline3 = displacev4(6, 4);

max1 = max(m_n1);
max2 = max(m_n2);
max3 = max(m_n3);

max1b = max1;
max2b = max2;
max3b = max3;

