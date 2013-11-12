function err_func = err_func_m6n4v1(input)


load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m6n4/cleanset1.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m6n4/cleanset2.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m6n4/cleanset3.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m6n4/clean_m4n6m6n246v4.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m6n4/clean_m4n6m6n246v5.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m6n4/clean_m6n246v678.mat;



%m6n4
%k2 = 0.001; %high concentration data
%k1 = 80000

%concentration_difference1 = 0
%concentration_difference2 = 0
%concentration_difference3 = 0.5 * 10^(-9);
%concentration_difference4 = 2 * 10^(-9);
%concentration_difference5 = 2 * 10^(-9);
%concentration_difference6 = 0.5 * 10^(-9);
%concentration_difference7 = 2 * 10^(-9);
%concentration_difference8 = 4.5 * 10^(-9);
%concentration_difference9 = 9.5 * 10^(-9);
%concentration_difference10 = 0.5 * 10^(-9);
%concentration_difference11 = 2 * 10^(-9);
%concentration_difference12 = 4.5 * 10^(-9);


index_offset1 = 9;
%index_offset2 = 23;
%index_offset3 = 7;
%index_offset4 = 7;
%index_offset5 = 7;
%index_offset6 = 7;
%index_offset7 = 7;
%index_offset8 = 7;
%index_offset9 = 7;
%index_offset10 = 7;
%index_offset11 = 7;
%index_offset12 = 7;
%index_offset13 = 7;
%index_offset14 = 7;
%index_offset15 = 7;
%index_offset16 = 7;

offset1 = 400;
%offset2 = 400;
%offset3 = 400;
%offset4 = 400;
%offset5 = 400;
%offset6 = 400;
%offset7 = 400;
%offset8 = 400;
%offset9 = 400;
%offset10 = 400;
%offset11 = 400;
%offset12 = 400;

start_conc1 = 2.5 * 10^(-9);
%start_conc2 = 2.5 * 10^(-9);
%start_conc3 = 0.5 * 10^(-9); 
%start_conc4 = 0.5 * 10^(-9); 
%start_conc5 = 0.5 * 10^(-9); 
%start_conc6 = 0.5 * 10^(-9);
%start_conc7 = 0.5 * 10^(-9);
%start_conc8 = 0.5 * 10^(-9);
%start_conc9 = 0.5 * 10^(-9);
%start_conc10 = 0.5 * 10^(-9);
%start_conc11 = 0.5 * 10^(-9);
%start_conc12 = 0.5 * 10^(-9);

m_n1 = cleanm4n6m6n246(:, 4);
%m_n2 = cleanm4n6m6n246v2(:, 4);
%m_n3 = cleanm4n6m6n246v3(:, 4); 
%m_n4 = cleanm4n6m6n246v4(:, 4);  
%m_n5 = cleanm4n6m6n246v5(:, 4);
%m_n6 = m6n44m6n66redov1(:, 2);
%m_n7 = m6n44m6n66redov1(:, 3);
%m_n8 = m6n244redov2(:, 3);
%m_n9 = m6n244redov2(:, 4);
%m_n10 = m6n2444redov3(:, 3);
%m_n11 = m6n2444redov3(:, 4);
%m_n12 = m6n2444redov3(:, 5)

xaxis1 = cleanm4n6m6n246(:, 1);
%xaxis2 = cleanm4n6m6n246v2(:, 1);
%xaxis3 = cleanm4n6m6n246v3(:, 1); 
%xaxis4 = cleanm4n6m6n246v4(:, 1); 
%xaxis5 = cleanm4n6m6n246v5(:, 1); 
%xaxis6 = m6n44m6n66redov1(:, 1);
%xaxis7 = m6n44m6n66redov1(:, 1);
%xaxis8 = m6n244redov2(:, 1);
%xaxis9 = m6n244redov2(:, 1);
%xaxis10 = m6n2444redov3(:, 1);
%xaxis11 = m6n2444redov3(:, 1);
%xaxis12 = m6n2444redov3(:, 1);

baseline1 = min(m_n1);
%baseline2 = min(m_n2);
%baseline3 = min(m_n3);
%baseline4 = min(m_n4);
%baseline5 = min(m_n5);
%baseline6 = min(m_n6);
%baseline7 = min(m_n7);
%baseline8 = min(m_n8);
%baseline9 = min(m_n9);
%baseline10 = min(m_n10);
%baseline11 = min(m_n11);
%baseline12 = min(m_n12);

max1 = max(m_n1);
%max2 = max(m_n2);
%max3 = max(m_n3);
%max4 = max(m_n4);
%max5 = max(m_n5);
%max6 = max(m_n6);
%max7 = max(m_n7);
%max8 = max(m_n8);
%max9 = max(m_n9);
%max10 = max(m_n10);
%max11 = max(m_n11);
%max12 = max(m_n12);


max1b = 3.2 *10^4;
%max2b = 1.5*10^5;
%max3b = 0.9*10^4; 
%max4b = 5.6*10^4; 
%max5b = 1.95*10^4; 
%max6b = 1.09 * 10^4;
%max7b = 1.57 * 10^4;
%max8b = 5.35 * 10^4;
%max9b = 6.23 * 10^4;
%max10b = 5.84 * 10^3;
%max11b = 6.4 * 10^3;
%max12b = 7.17 * 10^3;



end_index = 15*60;


data = [xaxis1, m_n1];

k = exp(input(1));
%ratio = exp(input(2));

err_func = 0;

%options = odeset('MaxStep',100,'refine',1e-10,'InitialStep',100,'RelTol',1e-10,'AbsTol',1e-10);

%options = odeset('RelTol', 1e-4, 'AbsTol', 1e-30);

options = odeset('MaxStep',100,'refine',1e-10,'InitialStep',100,'RelTol',1e-10,'AbsTol',1e-10);


datasize = size(data, 1);

%(4,8) data
t = data(index_offset1:datasize,1)-offset1;  %what is 23 is the data point where offset exists



y0 = [start_conc1*(max1b-baseline1)/(max1-baseline1), 0, 0, k];

[t, y2] = ode45(@fmin_toehold_norm_1, t, y0, options);


ye = y2(:,3);

for i = index_offset1:(end_index - index_offset1) %cutting off the high rise at the end 

   
err_func = err_func + ((ye(i-(index_offset1 -1)) - (data(i, 2) - baseline1)/(max1-baseline1)*start_conc1)^2)*1e17; %min square difference of sim - data

end