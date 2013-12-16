function [S, V] = myIaF(I)

[m, n] = size(I);
S = zeros(m, 1);
V = zeros(m, 1);

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
V(1) = Vreset;
i = 2;

while i < (m + 1)
    if (time > ft + tref)
        %fired = 0;
        dv = (Vrest - V(i-1))/(C*R) + I(i-1)/C; 
        V(i) = V(i-1) + dt* dv;
        if V(i)>= Vthr
            V(i) = Vreset;
            S(i) = 1;
            ft = time;
        %    fired = 1;
        end
    else
        V(i) = Vreset;
    end
    i = i + 1; 
    time = time + dt;
end
        