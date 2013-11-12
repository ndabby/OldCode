function err_func = err_func_mdisplace4wayv5(input)


load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/mdisplace4way/mdisplacev4.mat;


end_index = 15*60;

%mdisplace
%4-way branch migration starting with april 14 data
% k2 = 0.1
% k1 = 100000
% fmin k2 = 0.1
%

%index_offset1 = 7;
%index_offset2 = 7;
index_offset5 = 7;


%offset1 = 500;
%offset2 = 500;
offset5 = 500;


start_conc5 = 1 * 10^(-9); 

m_n5 = mdisplacev4(:, 3);

xaxis5 = mdisplacev4(:, 1);

baseline5 = mdisplacev4(6, 3);

max5 = max(m_n5);


max5b = max5;




data = [xaxis5, m_n5];

k = exp(input(1));
%ratio = exp(input(2));

err_func = 0;

%options = odeset('MaxStep',100,'refine',1e-10,'InitialStep',100,'RelTol',1e-10,'AbsTol',1e-10);

%options = odeset('RelTol', 1e-4, 'AbsTol', 1e-30);

options = odeset('MaxStep',100,'refine',1e-10,'InitialStep',100,'RelTol',1e-10,'AbsTol',1e-10);


datasize = size(data, 1);

%(4,8) data
t = data(index_offset5:datasize,1)-offset5;  %what is 23 is the data point where offset exists



y0 = [start_conc5*(max5b-baseline5)/(max5-baseline5), 0, 0, k];

[t, y2] = ode45(@fmin_toehold_norm_5, t, y0, options);


ye = y2(:,3);

for i = index_offset5:(end_index - index_offset5) %cutting off the high rise at the end 

   
err_func = err_func + ((ye(i-(index_offset5 -1)) - (data(i, 2) - baseline5)/(max5-baseline5)*start_conc5)^2)*1e17; %min square difference of sim - data

end
