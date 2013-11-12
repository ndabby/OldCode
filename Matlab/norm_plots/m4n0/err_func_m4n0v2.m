function err_func = err_func_m4n0v2(input)


load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m4n0/cleanset1.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m4n0/cleanset2.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m4n0/cleanset3.mat;

end_index = 18*60;

%m4n0
%k2 = 0.0004
%k1 = 1
% fmin k2 = 0.00048662
%
%index_offset1 = 22;
index_offset2 = 8;
%index_offset3 = 7;

%offset1 = 1300;
offset2 = 600;
%offset3 = 400;

%start_conc1 = 50 * 10^(-9); 
start_conc2 = 50 * 10^(-9); 
%start_conc3 = 100 * 10^(-9); 

%m_n1 = cleanm2n6m4n04m6n0(:, 3); 
m_n2 = cleanm2n6m4n04m6n0v2(:, 3);  
%m_n3 = cleanm2n6m4n04m6n0v3(:, 3);

%xaxis1 = cleanm2n6m4n04m6n0(:, 1); 
xaxis2 = cleanm2n6m4n04m6n0v2(:, 1); 
%xaxis3 = cleanm2n6m4n04m6n0v3(:, 1); 

%baseline1 = min(m_n1)+ 4.5* 10^4; 
baseline2 = min(m_n2)+ 4.5* 10^4; 
%baseline3 = min(m_n3)+ 4.5* 10^4;

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