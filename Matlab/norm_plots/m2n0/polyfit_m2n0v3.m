function [slope] = polyfit_m2n0v3()

load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m0n0/cleanset1.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m0n0/cleanset2.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m0n0/cleanset3.mat;



end_index = 18*60;

index_offset3 = 5*60; %7;



%m2n0
%k2 = 0.0004
%k1 = 0.06
%fmin k2 = 0.00048662
%


%start_conc1 = 120 * 10^(-9); 
%start_conc2 = 120 * 10^(-9); 
start_conc3 = 250 * 10^(-9); 

%m_n1 = cleanm2n024m4n2(:, 2); 
%m_n2 = cleanm2n024m4n2v2(:, 2);  
m_n3 = cleanm2n024m4n2v3(:, 2);

%xaxis1 = cleanm2n024m4n2(:, 1); 
%xaxis2 = cleanm2n024m4n2v2(:, 1); 
xaxis3 = cleanm2n024m4n2v3(:, 1); 

%baseline1 = 9.4*10^4; %min(m_n1); 
%baseline2 = 5*10^4; %min(m_n2); 
baseline3 = 6*10^4; %min(m_n3); 

%max1 = max(m_n1);
%max2 = max(m_n2);
max3 = max(m_n3);

%max1b = max1;
%max2b = max2;
max3b = max3;


%data = [xaxis1(index_offset1: end_index), m_n1(index_offset1: end_index)];

[slope] = polyfit(xaxis3(index_offset3: end_index), m_n3(index_offset3: end_index), 1)