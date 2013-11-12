function err_func = err_func_m6n6v7(input)


load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m6n4/cleanset1.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m6n4/cleanset2.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m6n4/cleanset3.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m6n4/clean_m4n6m6n246v4.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m6n4/clean_m4n6m6n246v5.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m6n4/clean_m6n246v678.mat;



%m6n6
%k2 = 0.0015; %high concentration data
%k1 = 400000

%concentration_difference1 = 0
%concentration_difference2 = 0
%concentration_difference3 = 0.5 * 10^(-9);
%concentration_difference4 = 2 * 10^(-9);
%concentration_difference5 = 2 * 10^(-9);
%concentration_difference6 = 0
%concentration_difference7 = 0


%offset1 = 600;
%offset2 = 400;
%offset3 = 400;
%offset4 = 400;
%offset5 = 400;
%offset6 = 400;
offset7 = 400;

%start_conc1 = 2.5 * 10^(-9);
%start_conc2 = 2.5 * 10^(-9);
%start_conc3 = 0.5 * 10^(-9); 
%start_conc4 = 0.5 * 10^(-9); 
%start_conc5 = 0.5 * 10^(-9); 
%start_conc6 = 2.5 * 10^(-9);
start_conc7 = 2.5 * 10^(-9);

%m_n1 = cleanm4n6m6n246(:, 5); 
%m_n2 = cleanm4n6m6n246v2(:, 5); 
%m_n3 = cleanm4n6m6n246v3(:, 5); 
%m_n4 = cleanm4n6m6n246v4(:, 5);  
%m_n5 = cleanm4n6m6n246v5(:, 5);
%m_n6 = m6n44m6n66redov1(:, 4);
m_n7 = m6n44m6n66redov1(:, 5);

%xaxis1 = cleanm4n6m6n246(:, 1); 
%xaxis2 = cleanm4n6m6n246v2(:, 1); 
%xaxis3 = cleanm4n6m6n246v3(:, 1); 
%xaxis4 = cleanm4n6m6n246v4(:, 1); 
%xaxis5 = cleanm4n6m6n246v5(:, 1); 
%xaxis6 = m6n44m6n66redov1(:, 1);
xaxis7 = m6n44m6n66redov1(:, 1);

%baseline1 = min(m_n1);
%baseline2 = min(m_n2);
%baseline3 = min(m_n3);
%baseline4 = min(m_n4);
%baseline5 = min(m_n5);
%baseline6 = min(m_n6);
baseline7 = min(m_n7);

%max1 = max(m_n1);
%max2 = max(m_n2);
%max3 = max(m_n3);
%max4 = max(m_n4);
%max5 = max(m_n5);
%max6 = max(m_n6);
max7 = max(m_n7);

%max1b = 2.9*10^4; %max1;
%max2b = 1.77*10^5; %max2;
%max3b = max3;
%max4b = max4;
%max5b = max5;
%max6b = 3.52*10^4;
max7b = 3.33 *10^4;



index_offset7 = 7;

end_index = 15*60;


data = [xaxis7, m_n7];

k = exp(input(1));
%ratio = exp(input(2));

err_func = 0;

%options = odeset('MaxStep',100,'refine',1e-10,'InitialStep',100,'RelTol',1e-10,'AbsTol',1e-10);

%options = odeset('RelTol', 1e-4, 'AbsTol', 1e-30);

options = odeset('MaxStep',100,'refine',1e-10,'InitialStep',100,'RelTol',1e-10,'AbsTol',1e-10);


datasize = size(data, 1);

%(4,8) data
t = data(index_offset7:datasize,1)-offset7;  %what is 23 is the data point where offset exists



y0 = [start_conc7*(max7b-baseline7)/(max7-baseline7), 0, 0, k];

[t, y2] = ode45(@fmin_toehold_norm_7, t, y0, options);


ye = y2(:,3);

for i = index_offset7:(end_index - index_offset7) %cutting off the high rise at the end 

   
err_func = err_func + ((ye(i-(index_offset7 -1)) - (data(i, 2) - baseline7)/(max7-baseline7)*start_conc7)^2)*1e17; %min square difference of sim - data

end
