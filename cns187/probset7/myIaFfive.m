function [S, V] = myIaFfive(I)

[m, n] = size(I);
S = zeros(1, n);
V = zeros(1, n);

dt = 0.001;
R = 1.0e8;
C = 2.0e-10;
Vrest = -0.065;
Vthr = -0.050;
Vreset = -0.070;
tref = 0.005;

ft = 0;
fired = 0;
time = 0.002;
V(1) = Vrest;
i = 2;

for j = 1:n
   I(j)= I(j) + (50.0e-12)*randn;
end

while i < (n + 1)
    if (fired == 0 || time > ft + tref)
        fired = 0;
        dv = (Vrest - V(i-1))/(C*R) + I(i-1)/C; 
        V(i) = V(i-1) + dt* dv;
        if V(i)>= Vthr
            S(i) = 1;
            ft = time;
            fired = 1;
        end
    else
        V(i) = Vreset;
    end
    i = i + 1; 
    time = time + dt;
end
        