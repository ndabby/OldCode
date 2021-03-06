function err_func = err_func_m0n6v2(input)


load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m0n6/cleanset1.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m0n6/cleanset2.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m0n6/cleanset3.mat;

end_index = 18*60;

%m0n6
%k2 = 0.0004
%k1 = 4.5
% fmin k2 = 0.00048662
%
%index_offset1 = 7;
index_offset2 = 7;
%index_offset3 = 7;

%offset1 = 600;
offset2 = 600;
%offset3 = 600;

%start_conc1 = 120 * 10^(-9); 
start_conc2 = 120 * 10^(-9); 
%start_conc3 = 250 * 10^(-9); 

%m_n1 = cleanm0n0246(:, 5); 
m_n2 = cleanm0n0246v2(:, 5);  
%m_n3 = cleanm0n0246v3(:, 5);

%xaxis1 = cleanm0n0246(:, 1); 
xaxis2 = cleanm0n0246v2(:, 1); 
%xaxis3 = cleanm0n0246v3(:, 1); 

%baseline1 = 4 * 10^4; %min(m_n1); 
baseline2 = 4*10^4; %min(m_n2); 
%baseline3 = 4*10^4; %min(m_n3); 

%max1 = max(m_n1);
max2 = max(m_n2);
%max3 = max(m_n3);

%max1b = max1;
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