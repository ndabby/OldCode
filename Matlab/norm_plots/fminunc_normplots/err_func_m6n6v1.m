function err_func = err_func_m6n6v1(input)


load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/fminunc_normplots/cleanset1.mat;




offset1 = 400;
offset2 = 400;
offset3 = 400;
offset4 = 400;
offset5 = 400;

start_conc1 = 2.5 * 10^(-9);
start_conc2 = 2.5 * 10^(-9);
start_conc3 = 0.5 * 10^(-9); 
start_conc4 = 0.5 * 10^(-9); 
start_conc5 = 0.5 * 10^(-9); 

m_n1 = cleanm4n6m6n246(:, 5); 
m_n2 = cleanm4n6m6n246(:, 5);%cleanm4n6m6n246v2(:, 5); 
m_n3 = cleanm4n6m6n246(:, 5);%cleanm4n6m6n246v3(:, 5); 
m_n4 = cleanm4n6m6n246(:, 5);%cleanm4n6m6n246v4(:, 5);  
m_n5 = cleanm4n6m6n246(:, 5);%cleanm4n6m6n246v5(:, 5);

xaxis1 = cleanm4n6m6n246(:, 1); 
xaxis2 = cleanm4n6m6n246(:, 1); %cleanm4n6m6n246v2(:, 1); 
xaxis3 = cleanm4n6m6n246(:, 1); %cleanm4n6m6n246v3(:, 1); 
xaxis4 = cleanm4n6m6n246(:, 1); %cleanm4n6m6n246v4(:, 1); 
xaxis5 = cleanm4n6m6n246(:, 1); %cleanm4n6m6n246v5(:, 1); 

baseline1 = min(m_n1);
baseline2 = min(m_n2);
baseline3 = min(m_n3);
baseline4 = min(m_n4);
baseline5 = min(m_n5);

max1 = max(m_n1);
max2 = max(m_n2);
max3 = max(m_n3);
max4 = max(m_n4);
max5 = max(m_n5);

max1b = 2.65*10^4; %max1;
max2b = 1.77*10^5; %max2;
max3b = max3;
max4b = max4;
max5b = max5;






data = [xaxis1, m_n1];

k = exp(input(1));
%ratio = exp(input(2));

err_func = 0;

%options = odeset('MaxStep',100,'refine',1e-10,'InitialStep',100,'RelTol',1e-10,'AbsTol',1e-10);
options = odeset('RelTol', 1e-4, 'AbsTol', 1e-30);

datasize = size(data, 1);

%(4,8) data
t = data(9:datasize,1)-420; %need to change offset and start data



y0 = [start_conc1*max1b/max1, 0, 0, k];

[t, y2] = ode45(@toehold_norm_1, t, y0, options);


ye = y2(:,3);

for i = 9:size(data, 1) %change start data

err_func = err_func + (ye(i-8) - (data(i, 2) - baseline1)/(max1-baseline1)*start_conc1)^2; %min square difference of sim - data

end
