function err_func = err_func_m4n6v3(input)


load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m6n4/cleanset1.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m6n4/cleanset2.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m6n4/cleanset3.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m6n4/clean_m4n6m6n246v4.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m6n4/clean_m4n6m6n246v5.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m6n4/clean_m6n246v678.mat;



%m4n6
%k2 = 0.001; %high concentration data
%k1 = 200000

%concentration_difference1 = 0
%concentration_difference2 = 0
%concentration_difference3 = 0.5 * 10^(-9);
%concentration_difference4 = 2 * 10^(-9);
%concentration_difference5 = 2 * 10^(-9);

%index_offset1 = 9;
%index_offset2 = 23;
index_offset3 = 7;
%index_offset4 = 7;
%index_offset5 = 7;

%offset1 = 600;
%offset2 = 1400;
offset3 = 400;
%offset4 = 400;
%offset5 = 400;

%start_conc1 = 2.5 * 10^(-9);
%start_conc2 = 2.5 * 10^(-9);
start_conc3 = 0.5 * 10^(-9); 
%start_conc4 = 0.5 * 10^(-9); 
%start_conc5 = 0.5 * 10^(-9); 

%m_n1 = cleanm4n6m6n246(:, 2);
%m_n2 = cleanm4n6m6n246v2(:, 2);
m_n3 = cleanm4n6m6n246v3(:, 2); 
%m_n4 = cleanm4n6m6n246v4(:, 2);  
%m_n5 = cleanm4n6m6n246v5(:, 2);

%xaxis1 = cleanm4n6m6n246(:, 1); 
%xaxis2 = cleanm4n6m6n246v2(:, 1); 
xaxis3 = cleanm4n6m6n246v3(:, 1); 
%xaxis4 = cleanm4n6m6n246v4(:, 1); 
%xaxis5 = cleanm4n6m6n246v5(:, 1); 

%baseline1 = min(m_n1);
%baseline2 = min(m_n2);
baseline3 = min(m_n3);
%baseline4 = min(m_n4);
%baseline5 = min(m_n5);

%max1 = max(m_n1);
%max2 = max(m_n2);
max3 = max(m_n3);
%max4 = max(m_n4);
%max5 = max(m_n5);

%max1b = 3.635 * 10^4;
%max2b = 1.7 * 10^5;
max3b = 1.65 *10^4; %max3;
%max4b = 4* 10^4; %max4;
%max5b = 1.84*10^4; %max5;



end_index = 15*60;


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

