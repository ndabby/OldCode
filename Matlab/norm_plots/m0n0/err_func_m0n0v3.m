function err_func = err_func_m0n0v3(input)

load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m0n0/cleanset1.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m0n0/cleanset2.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m0n0/cleanset3.mat;

%m0n0
% k2 = 0.0004
% k1 = 0.05
% fmin k2 = 0.00048662
%

end_index = 18*60;


%index_offset1 = 7;
%index_offset2 = 7;
index_offset3 = 7;

%offset1 = 900;
%offset2 = 900;
offset3 = 900;

%start_conc1 = 120 * 10^(-9); 
%start_conc2 = 120 * 10^(-9); 
start_conc3 = 250 * 10^(-9); 

%m_n1 = cleanm0n0246(:, 2); 
%m_n2 = cleanm0n0246v2(:, 2);  
m_n3 = cleanm0n0246v3(:, 2);

%xaxis1 = cleanm0n0246(:, 1); 
%xaxis2 = cleanm0n0246v2(:, 1); 
xaxis3 = cleanm0n0246v3(:, 1); 

%baseline1 = cleanm0n0246(7, 2); 
%baseline2 = cleanm0n0246v2(7, 2); 
baseline3 = cleanm0n0246v3(7, 2); 

%max1 = max(m_n1);
%max2 = max(m_n2);
max3 = max(m_n3);

%max1b = max1;
%max2b = max2;
max3b = max3;


data = [xaxis3, m_n3];

k = exp(input(1));
%ratio = exp(input(2));

err_func = 0;

%options = odeset('MaxStep',100,'refine',1e-10,'InitialStep',100,'RelTol',1e-10,'AbsTol',1e-10);

%options = odeset('RelTol', 1e-4, 'AbsTol', 1e-30);

options = odeset('MaxStep',100,'refine',1e-10,'InitialStep',100,'RelTol',1e-10,'AbsTol',1e-10);


datasize = size(data, 1);

%(4,8) data
t = data(index_offset3:datasize,1)-offset3;  %what is 23 is the data point where offset exists



y0 = [start_conc3*(max3b-baseline3)/(max3-baseline3), 0, 0, k];

[t, y2] = ode45(@fmin_toehold_norm_3, t, y0, options);


ye = y2(:,3);

for i = index_offset3:(end_index - index_offset3) %cutting off the high rise at the end 

   
err_func = err_func + ((ye(i-(index_offset3 -1)) - (data(i, 2) - baseline3)/(max3-baseline3)*start_conc3)^2)*1e17; %min square difference of sim - data

end
