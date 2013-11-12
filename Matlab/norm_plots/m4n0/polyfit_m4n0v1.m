function [slope] = polyfit_m4n0v1()

load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m0n0/cleanset1.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m0n0/cleanset2.mat;
load /Users/nadinedabby/Desktop/4-way_junction/Fluorescence/norm_plots/m0n0/cleanset3.mat;


end_index = 18*60;

index_offset1 = 5*60; %7;


start_conc1 = 50 * 10^(-9); 
%start_conc2 = 50 * 10^(-9); 
%start_conc3 = 100 * 10^(-9); 

m_n1 = cleanm2n6m4n04m6n0(:, 3); 
%m_n2 = cleanm2n6m4n04m6n0v2(:, 3);  
%m_n3 = cleanm2n6m4n04m6n0v3(:, 3);

xaxis1 = cleanm2n6m4n04m6n0(:, 1); 
%xaxis2 = cleanm2n6m4n04m6n0v2(:, 1); 
%xaxis3 = cleanm2n6m4n04m6n0v3(:, 1); 

baseline1 = min(m_n1)+ 4.5* 10^4; 
%baseline2 = min(m_n2)+ 4.5* 10^4; 
%baseline3 = min(m_n3)+ 4.5* 10^4;

max1 = max(m_n1);
%max2 = max(m_n2);
%max3 = max(m_n3);

max1b = max1;
%max2b = max2;
%max3b = max3;


%data = [xaxis1(index_offset1: end_index), m_n1(index_offset1: end_index)];

[slope] = polyfit(xaxis1(index_offset1: end_index), m_n1(index_offset1: end_index), 1)