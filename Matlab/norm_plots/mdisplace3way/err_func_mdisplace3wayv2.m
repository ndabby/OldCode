function err_func = err_func_mdisplace3wayv2(input)

load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/mdisplace3way/dq_dtdt.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/mdisplace3way/displace.mat;


end_index = 15*60;

%mdisplace
%4-way branch migration starting with april 14 data
% k2 = 1
% k1 = 100000
% fmin k2 = 1
%

%index_offset1 = 7;
index_offset2 = 7;
%index_offset3 = 7;


%offset1 = 500;
offset2 = 500;
%offset3 = 500;


%start_conc1 = 10 * 10^(-9); 
start_conc2 = 2.5 * 10^(-9); 
%start_conc3 = 1 * 10^(-9); 

%m_n1 = displacev3(:, 5);
m_n2 = displacev4(:, 5);
%m_n3 = dq_dtdt(:, 3);

%xaxis1 = displacev3(:, 1);
xaxis2 = displacev4(:, 1);
%xaxis3 = dq_dtdt(:, 1);

%baseline1 = displacev3(6, 5); 
baseline2 = displacev4(6, 5);
%baseline3 = dq_dtdt(6, 3);

%max1 = max(m_n1);
max2 = max(m_n2);
%max3 = max(m_n3);

%max1b = max1; %109550;
max2b = max2;
%max3b = max3;


data = [xaxis2, m_n2];

k = exp(input(1));
%ratio = exp(input(2));

err_func = 0;

%options = odeset('MaxStep',100,'refine',1e-10,'InitialStep',100,'RelTol',1e-10,'AbsTol',1e-10);

%options = odeset('RelTol', 1e-4, 'AbsTol', 1e-30);

options = odeset('MaxStep',100,'refine',1e-10,'InitialStep',100,'RelTol',1e-10,'AbsTol',1e-10);


datasize = size(data, 1);

%(4,8) data
t = data(index_offset2:datasize,1)-offset2;  %what is 23 is the data point where offset exists



y0 = [start_conc2*(max2b-baseline2)/(max2-baseline2), 0, 0, k];

[t, y2] = ode45(@fmin_toehold_norm_2, t, y0, options);


ye = y2(:,3);

for i = index_offset2:(end_index - index_offset2) %cutting off the high rise at the end 

   
err_func = err_func + ((ye(i-(index_offset2 -1)) - (data(i, 2) - baseline2)/(max2-baseline2)*start_conc2)^2)*1e17; %min square difference of sim - data

end