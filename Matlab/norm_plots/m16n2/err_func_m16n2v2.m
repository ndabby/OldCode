function err_func = err_func_m16n2v2(input)

load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m16n2/clean_m16n0246v1.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m16n2/clean_m16n0246v2.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m16n2/clean_m16n0246v34.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m16n2/clean_m16fast.mat;


%m16n2
%k2 = 0.001; %high concentration data
%k1 = 2000000; %low concentration data

%index_offset1 = 7;
index_offset2 = 7;
%index_offset3 = 5;
%index_offset4 = 8;
%index_offset5 = 27;

%offset1 = 300;
offset2 = 600;
%offset3 = 350;
%offset4 = 600;
%offset5 = 450;

%m_n1 = cleanm16n0246v1(:,3); 
m_n2 = cleanm16n0246v2(:, 3);  
%m_n3 = cleanm16n0246v3(:,3); 
%m_n4 = cleanm16n0246v4(:, 3);  
%m_n5 = m16n2FAST(:,2);

%xaxis1 = cleanm16n0246v1(:,1); 
xaxis2 = cleanm16n0246v2(:, 1); 
%xaxis3 = cleanm16n0246v3(:,1); 
%xaxis4 = cleanm16n0246v4(:, 1); 
%xaxis5 = m16n2FAST(:,1); 

%baseline1 = min(m_n1);
baseline2 = min(m_n2);
%baseline3 = min(m_n3);
%baseline4 = min(m_n4);
%baseline5 = min(m_n5);

%max1 = max(m_n1);
max2 = max(m_n2);
%max3 = max(m_n3);
%max4 = max(m_n4);
%max5 = max(m_n5);

%max1b = max1;
max2b = max2;
%max3b = max3;
%max4b = max4;
%max5b = max5;


%max1b = 29000; 
%max2b = 40000; 
%max3b = 19000;


%start_conc1 = 20 * 10^(-9); 
start_conc2 = 1 * 10^(-9);
%start_conc3 = 0.25 * 10^(-9);
%start_conc4 = 0.1 * 10^(-9);
%start_conc5 = 0.25 * 10^(-9);   




data = [xaxis2, m_n2];
end_index = size(data, 1);
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
