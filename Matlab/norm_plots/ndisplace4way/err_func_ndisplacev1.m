function err_func = err_func_ndisplacev1(input)

load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/ndisplace4way/displace.mat;

end_index = 60*15;


%ndisplace
%4-way branch migration starting with april 14 data
% k2 = 0.1
% k1 = 3500
% fmin k2 = 0.1
%

index_offset1 = 7;
%index_offset2 = 7;
%index_offset3 = 7;


offset1 = 500;
%offset2 = 500;
%offset3 = 500;


start_conc1 = 120 * 10^(-9); 
%start_conc2 = 10 * 10^(-9); 
%start_conc3 = 5 * 10^(-9); 

m_n1 = displacev2(:, 4);
%m_n2 = displacev3(:, 2);
%m_n3 = displacev4(:, 2);

xaxis1 = displacev2(:, 1);
%xaxis2 = displacev3(:, 1);
%xaxis3 = displacev4(:, 1);

baseline1 = displacev2(6, 4); 
%baseline2 = displacev3(6, 2);
%baseline3 = displacev4(6, 2);

max1 = max(m_n1);
%max2 = max(m_n2);
%max3 = max(m_n3);

max1b = max1;
%max2b = max2;
%max3b = max3;





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
