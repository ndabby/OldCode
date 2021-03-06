function err_func = err_func_m2n6v3(input)

load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m2n6/cleanset1.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m2n6/cleanset2.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m2n6/cleanset3.mat;

end_index = 18*60;

%m2n6
%k1 = 460
%k2 = 0.001 -- 10x speed-up here doesn't affect plot very much
%
%fmin k2 = 0.002
%
%index_offset1 = 22;
%index_offset2 = 8;
index_offset3 = 7;

%offset1 = 1300;
%offset2 = 400;
offset3 = 400;

%start_conc1 = 50 * 10^(-9); 
%start_conc2 = 50 * 10^(-9); 
start_conc3 = 25 * 10^(-9); 

%m_n1 = cleanm2n6m4n04m6n0(:,2); 
%m_n2 = cleanm2n6m4n04m6n0v2(:,2); 
m_n3 = cleanm2n6m4n04m6n0v3(:,2); 

%xaxis1 = cleanm2n6m4n04m6n0(:,1); 
%xaxis2 = cleanm2n6m4n04m6n0v2(:,1);  
xaxis3 = cleanm2n6m4n04m6n0v3(:,1); 

%baseline1 = min(m_n1); 
%baseline2 = min(m_n2); 
baseline3 = min(m_n3); 

%max1 = max(m_n1);
%max2 = max(m_n2);
max3 = max(m_n3);

%max1b = 1119500;
%max2b = 1120000;
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
