function err_func = err_func_m2n6v1(input)


load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/fminunc_normplots/cleanset1.mat;



%m2n6
%k1 = 460
%k2 = 0.001 -- 10x speed-up here doesn't affect plot very much
%TESTING!!!!

offset1 = 1300;
offset2 = 400;
offset3 = 500;

start_conc1 = 50 * 10^(-9); 
start_conc2 = 50 * 10^(-9); 
start_conc3 = 25 * 10^(-9); 

m_n1 = cleanm2n6m4n04m6n0(:,2); 
m_n2 = cleanm2n6m4n04m6n0(:,2); 
m_n3 = cleanm2n6m4n04m6n0(:,2); 

xaxis1 = cleanm2n6m4n04m6n0(:,1); 
xaxis2 = cleanm2n6m4n04m6n0(:,1);  
xaxis3 = cleanm2n6m4n04m6n0(:,1); 

baseline1 = min(m_n1); 
baseline2 = min(m_n2); 
baseline3 = min(m_n3); 

max1 = max(m_n1);
max2 = max(m_n2);
max3 = max(m_n3);

max1b = 1119500;
max2b = 1120000;
max3b = max3;






data = cleanm2n6m4n04m6n0(:, 1:2);

k = exp(input(1));
%ratio = exp(input(2));

err_func = 0;

%options = odeset('MaxStep',100,'refine',1e-10,'InitialStep',100,'RelTol',1e-10,'AbsTol',1e-10);
options = odeset('RelTol', 1e-4, 'AbsTol', 1e-30);

datasize = size(data, 1);

%(4,8) data
t = data(23:datasize,1)-1300;



y0 = [start_conc1*max1b/max1, 0, 0, k];

[t, y2] = ode45(@toehold_norm_1, t, y0, options);


ye = y2(:,3);

for i = 23:size(data, 1)

err_func = err_func + (ye(i-22) - (data(i, 2) - baseline1)/(max1-baseline1)*start_conc1)^2; %min square difference of sim - data

end
