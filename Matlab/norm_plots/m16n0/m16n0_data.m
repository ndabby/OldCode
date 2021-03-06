%m16n0
%k2 = 0.0004; %high concentration data
%k1 = 3,000,000; %low concentration data

index_offset1 = 7;
index_offset2 = 7;
index_offset3 = 5;
index_offset4 = 8;
index_offset5 = 22;


offset1 = 400;
offset2 = 500;
offset3 = 300;
offset4 = 600;
offset5 = 400;


m_n1 = cleanm16n0246v1(:,2); 
m_n2 = cleanm16n0246v2(:, 2);  
m_n3 = cleanm16n0246v3(:, 2);
m_n4 = cleanm16n0246v4(:, 2);
m_n5 = m16n0FAST(:,2);

xaxis1 = cleanm16n0246v1(:,1); 
xaxis2 = cleanm16n0246v2(:, 1); 
xaxis3 = cleanm16n0246v3(:, 1);
xaxis4 = cleanm16n0246v4(:, 1); 
xaxis5 = m16n0FAST(:,1); 

baseline1 = min(m_n1);
baseline2 = min(m_n2);
baseline3 = min(m_n3);
baseline4 = min(m_n4);
baseline5 = min(m_n5);

max1 = max(m_n1);
max2 = max(m_n2);
max3 = max(m_n3);
max4 = max(m_n4);
max5 = max(m_n5);


max1b = max1;
max2b = max2;
max3b = max3;
max4b = max4;
max5b = max5;


%max1b = 29000; 
%max2b = 40000; 
%max3b = 19000;


start_conc1 = 20 * 10^(-9); 
start_conc2 = 1 * 10^(-9);
start_conc3 = 0.25 * 10^(-9);
start_conc4 = 0.1 * 10^(-9);
start_conc5 = 0.25 * 10^(-9); 