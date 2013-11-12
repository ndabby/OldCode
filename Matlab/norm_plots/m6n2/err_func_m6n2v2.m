function err_func = err_func_m6n2v2(input)


load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m6n2/cleanset1.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m6n2/cleanset2.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m6n2/cleanset3.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m6n2/clean_m4n6m6n246v4.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m6n2/clean_m4n6m6n246v5.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m6n2/clean_m6n246v678.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m6n2/feb2011clean.mat;

end_index = 15*60;

%m6n2
%k1 = 0.001;
%k2 = 15000;
%fmin k2 = 0.002;

%concentration_difference1 = 2.5 *10^-9
%concentration_difference2 = 2.5 *10^-9
%concentration_difference3 = 4 * 10^(-9);
%concentration_difference4 = 4.5 * 10^(-9);
%concentration_difference5 = 4.5 * 10^(-9);
%concentration_difference6 = 4.5* 10^(-9);
%concentration_difference7 = 4.5* 10^(-9);
%concentration_difference8 = 4.5* 10^(-9);
%concentration_difference9 = -4.5* 10^(-9);


%index_offset1 = 9;
index_offset2 = 23;
%index_offset3 = 7;
%index_offset4 = 7;
%index_offset5 = 7;
%index_offset6 = 7;
%index_offset7 = 7;
%index_offset8 = 7;
%index_offset9 = 7;

%start_conc1 = 2.5 * 10^(-9); 
start_conc2 = 2.5 * 10^(-9); 
%start_conc3 = 1 * 10^(-9); 
%start_conc4 = 0.5 * 10^(-9); 
%start_conc5 = 0.5 * 10^(-9); 
%start_conc6 = 0.5 * 10^(-9); 
%start_conc7 = 0.5 * 10^(-9); 
%start_conc8 = 0.5 * 10^(-9); 
%start_conc9 = 0.5 * 10^(-9); 


%offset1 = 600;
offset2 = 1500;
%offset3 = 400;
%offset4 = 600;
%offset5 = 500;
%offset6 = 400;
%offset7 = 500;
%offset8 = 600;
%offset9 = 450;


%m_n1 = cleanm4n6m6n246(:, 3); 
m_n2 = cleanm4n6m6n246v2(:, 3); 
%m_n3 = cleanm4n6m6n246v3(:, 3); 
%m_n4 = cleanm4n6m6n246v4(:, 3);  
%m_n5 = cleanm4n6m6n246v5(:, 3);
%m_n6 = m6n244redov2(:, 2);
%m_n7 = m6n2444redov3(:, 2);
%m_n8 = d_m6n246v9(:, 3);
%m_n9 = rev_m6n246v10(:, 3);

%xaxis1 = cleanm4n6m6n246(:, 1); 
xaxis2 = cleanm4n6m6n246v2(:, 1); 
%xaxis3 = cleanm4n6m6n246v3(:, 1); 
%xaxis4 = cleanm4n6m6n246v4(:, 1); 
%xaxis5 = cleanm4n6m6n246v5(:, 1); 
%xaxis6 = m6n244redov2(:, 1);
%xaxis7 = m6n2444redov3(:, 1);
%xaxis8 = d_m6n246v9(:, 1);
%xaxis9 = rev_m6n246v10(:, 1);

%baseline1 = min(m_n1);
baseline2 = min(m_n2);
%baseline3 = min(m_n3);
%baseline4 = min(m_n4);
%baseline5 = min(m_n5);
%baseline6 = min(m_n6);
%baseline7 = min(m_n7);
%baseline8 = min(m_n8);
%baseline9 = min(m_n9);


%max1 = max(m_n1);
max2 = max(m_n2);
%max3 = max(m_n3);
%max4 = max(m_n4);
%max5 = max(m_n5);
%max6 = max(m_n6);
%max7 = max(m_n7);
%max8 = max(m_n8);
%max9 = max(m_n9);

%max1b = 26000; %max1;
max2b = 145000; %max2;
%max3b = max3 %29000; %max(m_n3);
%max4b = 40000; %max(m_n4);
%max5b = 19000;
%max6b = 53500; %max6;
%max7b = 6300; %max7;
%max8b = 13750; %max8;
%max9b = 34000; %max9;


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
