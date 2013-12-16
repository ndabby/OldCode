function [freq] = derived(I)

[m, n] = size(I);
freq = zeros(m, n);

dt = 0.001;
R = 1.0e8;
C = 2.0e-10;
Vrest = -0.065;
Vthr = -0.050;
Vreset = -0.070;
tref = 0.005;


for i = 1:n 
    if (Vthr-Vrest-R*I(i))/(Vreset-Vrest-R*I(i)) >= 0
        tfire = -R*C*log((Vthr-Vrest-R*I(i))/(Vreset-Vrest-R*I(i)));
    else
        tfire = inf;
    end
    freq(i) = 1/(tref + tfire);
end       