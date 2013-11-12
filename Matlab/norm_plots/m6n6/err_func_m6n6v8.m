function err_func = err_func_m6n6v8(input)

load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m6n6/feb2011clean.mat;

%offset1 = 600;
%offset2 = 400;
%offset3 = 1000;
%offset4 = 1500;
%offset5 = 00;
%offset6 = 400;
%offset7 = 400;
offset8 = 600;
%offset9 = 450;

%start_conc1 = 2.5 * 10^(-9);
%start_conc2 = 2.5 * 10^(-9);
%start_conc3 = 0.5 * 10^(-9); 
%start_conc4 = 0.5 * 10^(-9); 
%start_conc5 = 0.5 * 10^(-9); 
%start_conc6 = 2.5 * 10^(-9);
%start_conc7 = 2.5 * 10^(-9);
start_conc8 = 2.5 * 10^(-9);
%start_conc9 = 2.5 * 10^(-9);

%m_n1 = cleanm4n6m6n246(:, 5); 
%m_n2 = cleanm4n6m6n246v2(:, 5); 
%m_n3 = cleanm4n6m6n246v3(:, 5); 
%m_n4 = cleanm4n6m6n246v4(:, 5);  
%m_n5 = cleanm4n6m6n246v5(:, 5);
%m_n6 = m6n44m6n66redov1(:, 4);
%m_n7 = m6n44m6n66redov1(:, 5);
m_n8 = d_m6n246v9(:, 5);
%m_n9 = rev_m6n246v10(:, 5);

%xaxis1 = cleanm4n6m6n246(:, 1); 
%xaxis2 = cleanm4n6m6n246v2(:, 1); 
%xaxis3 = cleanm4n6m6n246v3(:, 1); 
%xaxis4 = cleanm4n6m6n246v4(:, 1); 
%xaxis5 = cleanm4n6m6n246v5(:, 1); 
%xaxis6 = m6n44m6n66redov1(:, 1);
%xaxis7 = m6n44m6n66redov1(:, 1);
xaxis8 = d_m6n246v9(:, 1);
%xaxis9 = rev_m6n246v10(:, 1);

%baseline1 = min(m_n1);
%baseline2 = min(m_n2);
%baseline3 = min(m_n3);
%baseline4 = min(m_n4);
%baseline5 = min(m_n5);
%baseline6 = min(m_n6);
%baseline7 = min(m_n7);
baseline8 = min(m_n8);
%baseline9 = min(m_n9);

%max1 = max(m_n1);
%max2 = max(m_n2);
%max3 = max(m_n3);
%max4 = max(m_n4);
%max5 = max(m_n5);
%max6 = max(m_n6);
%max7 = max(m_n7);
max8 = max(m_n8);
%max9 = max(m_n9);

%max1b = 2.9*10^4; %max1;
%max2b = 1.77*10^5; %max2;
%max3b = max3;
%max4b = 3.35*10^4
%max5b = max5;
%max6b = 3.52*10^4;
%max7b = 3.33 *10^4;
max8b = max8;
%max9b = max9;






index_offset8 = 7;

end_index = 15*60;

data = [xaxis8, m_n8];

k = exp(input(1));
%ratio = exp(input(2));

err_func = 0;

%options = odeset('MaxStep',100,'refine',1e-10,'InitialStep',100,'RelTol',1e-10,'AbsTol',1e-10);

%options = odeset('RelTol', 1e-4, 'AbsTol', 1e-30);

options = odeset('MaxStep',100,'refine',1e-10,'InitialStep',100,'RelTol',1e-10,'AbsTol',1e-10);


datasize = size(data, 1);

%(4,8) data
t = data(index_offset8:datasize,1)-offset8;  %what is 23 is the data point where offset exists



y0 = [start_conc8*(max8b-baseline8)/(max8-baseline8), 0, 0, k];

[t, y2] = ode45(@fmin_toehold_norm_8, t, y0, options);


ye = y2(:,3);

for i = index_offset8:(end_index - index_offset8) %cutting off the high rise at the end 

   
err_func = err_func + ((ye(i-(index_offset8 -1)) - (data(i, 2) - baseline8)/(max8-baseline8)*start_conc8)^2)*1e17; %min square difference of sim - data

end
