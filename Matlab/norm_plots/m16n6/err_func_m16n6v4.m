function err_func = err_func_m16n6v4(input)

load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m16n6/clean_m16n0246v1.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m16n6/clean_m16n0246v2.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m16n6/clean_m16n0246v34.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m16n6/clean_m16fast.mat;

%m16n6
%k2 = 0.002; %high concentration data
%k1 = 2000000; %low concentration data

%index_offset1 = 7;
%index_offset2 = 7;
%index_offset3 = 5;
index_offset4 = 8;
%index_offset5 = 22;

%offset1 = 700;
%offset2 = 800;
%offset3 = 500;
offset4 = 800;
%offset5 = 400;


%m_n1 = cleanm16n0246v1(:,5); 
%m_n2 = cleanm16n0246v2(:, 5);  
%m_n3 = cleanm16n0246v3(:,5); 
m_n4 = cleanm16n0246v4(:, 5);  
%m_n5 = m16n6FAST(:,2);

%xaxis1 = cleanm16n0246v1(:,1); 
%xaxis2 = cleanm16n0246v2(:, 1); 
%xaxis3 = cleanm16n0246v3(:,1); 
xaxis4 = cleanm16n0246v4(:, 1); 
%xaxis5 = m16n6FAST(:,1); 

%baseline1 = min(m_n1);
%baseline2 = min(m_n2);
%baseline3 = min(m_n3);
baseline4 = min(m_n4);
%baseline5 = min(m_n5);

%max1 = max(m_n1);
%max2 = max(m_n2);
%max3 = max(m_n3);
max4 = max(m_n4);
%max5 = max(m_n5);

%max1b = max1;
%max2b = max2;
%max3b = max3;
max4b = max4;
%max5b = max5;

%start_conc1 = 20 * 10^(-9); 
%start_conc2 = 1 * 10^(-9);
%start_conc3 = 0.25 * 10^(-9);
start_conc4 = 0.1 * 10^(-9);
%start_conc5 = 0.25 * 10^(-9); 


data = [xaxis4, m_n4];
end_index = size(data, 1);
k = exp(input(1));
%ratio = exp(input(2));

err_func = 0;

%options = odeset('MaxStep',100,'refine',1e-10,'InitialStep',100,'RelTol',1e-10,'AbsTol',1e-10);

%options = odeset('RelTol', 1e-4, 'AbsTol', 1e-30);

options = odeset('MaxStep',100,'refine',1e-10,'InitialStep',100,'RelTol',1e-10,'AbsTol',1e-10);


datasize = size(data, 1);

%(4,8) data
t = data(index_offset4:datasize,1)-offset4;  %what is 23 is the data point where offset exists



y0 = [start_conc4*(max4b-baseline4)/(max4-baseline4), 0, 0, k];

[t, y2] = ode45(@fmin_toehold_norm_4, t, y0, options);


ye = y2(:,3);

for i = index_offset4:(end_index - index_offset4) %cutting off the high rise at the end 

   
err_func = err_func + ((ye(i-(index_offset4 -1)) - (data(i, 2) - baseline4)/(max4-baseline4)*start_conc4)^2)*1e17; %min square difference of sim - data

end

