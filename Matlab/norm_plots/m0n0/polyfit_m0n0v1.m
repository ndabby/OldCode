function [slope] = polyfit_m0n0v1()

load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m0n0/cleanset1.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m0n0/cleanset2.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m0n0/cleanset3.mat;

%m0n0
% k2 = 0.0004
% k1 = 0.05
% fmin k2 = 0.00048662
%

end_index = 18*60;

index_offset1 = 5*60; %7;
%index_offset2 = 7;
%index_offset3 = 7;

offset1 = cleanm0n0246(5*60, 1); %900;
%offset2 = 900;
%offset3 = 900;

start_conc1 = 120 * 10^(-9); 
%start_conc2 = 120 * 10^(-9); 
%start_conc3 = 250 * 10^(-9); 

m_n1 = cleanm0n0246(:, 2); 
%m_n2 = cleanm0n0246v2(:, 2);  
%m_n3 = cleanm0n0246v3(:, 2);

xaxis1 = cleanm0n0246(:, 1); 
%xaxis2 = cleanm0n0246v2(:, 1); 
%xaxis3 = cleanm0n0246v3(:, 1); 

baseline1 = cleanm0n0246(5*60, 2); 
%baseline2 = cleanm0n0246v2(7, 2); 
%baseline3 = cleanm0n0246v3(7, 2); 

max1 = max(m_n1);
%max2 = max(m_n2);
%max3 = max(m_n3);

max1b = max1;
%max2b = max2;
%max3b = max3;


%data = [xaxis1(index_offset1: end_index), m_n1(index_offset1: end_index)];

[slope] = polyfit(xaxis1(index_offset1: end_index), m_n1(index_offset1: end_index), 1)