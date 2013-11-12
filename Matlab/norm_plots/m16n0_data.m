%m16n0
%k2 = 0.0004; %high concentration data
%k1 = 400000; %low concentration data

offset1 = 400;
offset2 = 400;
offset3 = 400;


m_n1 = cleanm16n0246v1(:,2); 
m_n2 = cleanm16n0246v2(:, 2);  
m_n3 = m16n0FAST(:,2);

xaxis1 = cleanm16n0246v1(:,1); 
xaxis2 = cleanm16n0246v2(:, 1); 
xaxis3 = m16n0FAST(:,1); 

baseline1 = min(m_n1);
baseline2 = min(m_n2);
baseline3 = min(m_n3);

max1 = max(m_n1);
max2 = max(m_n2);
max3 = max(m_n3);

max1b = max1;
max2b = max2;
max3b = max3;

%max1b = 29000; 
%max2b = 40000; 
%max3b = 19000;


start_conc1 = 20 * 10^(-9); 
start_conc2 = 1 * 10^(-9); 
start_conc3 = 0.25 * 10^(-9); 