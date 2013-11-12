%mdisplace
%4-way branch migration starting with april 14 data
% k2 = 0.1
% k1 = 100000
% fmin k2 = 0.1
%

index_offset1 = 7;
index_offset2 = 7;
index_offset3 = 7;
index_offset4 = 7;
index_offset5 = 7;


offset1 = 500;
offset2 = 500;
offset3 = 500;
offset4 = 500;
offset5 = 500;


start_conc1 = 10 * 10^(-9); 
start_conc2 = 2.5 * 10^(-9); 
start_conc3 = 1 * 10^(-9); 
start_conc4 = 2.5 * 10^(-9); 
start_conc5 = 1 * 10^(-9); 

m_n1 = displacev3(:, 3);
m_n2 = displacev4(:, 3);
m_n3 = dq_dtdt(:, 3);
m_n4 = mdisplacev4(:, 2);
m_n5 = mdisplacev4(:, 3);

xaxis1 = displacev3(:, 1);
xaxis2 = displacev4(:, 1);
xaxis3 = dq_dtdt(:, 1);
xaxis4 = mdisplacev4(:, 1);
xaxis5 = mdisplacev4(:, 1);

baseline1 = displacev3(6, 3); 
baseline2 = displacev4(6, 3);
baseline3 = dq_dtdt(6, 3);
baseline4 = mdisplacev4(6, 2);
baseline5 = mdisplacev4(6, 3);


max1 = max(m_n1);
max2 = max(m_n2);
max3 = max(m_n3);
max4 = max(m_n4);
max5 = max(m_n5);

max1b = 109550;
max2b = max2;
max3b = 120000; %max3;
max4b = max4;
max5b = max5;
