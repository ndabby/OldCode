function [opt] = packing()
%Solving the max packing problem using simulated annealing
%given a vertex set V and Edge set E
Adj = [0 1 0 0 0 0 1 0 1 0
       1 0 1 0 0 1 0 0 0 0
       0 1 0 1 1 1 0 0 0 0
       0 0 1 0 1 0 0 0 0 0
       0 0 1 1 0 0 0 0 0 0
       0 1 1 0 0 0 0 1 0 0 
       1 0 0 0 0 0 0 0 1 1
       0 0 0 0 0 1 0 0 0 1
       1 0 0 0 0 0 1 0 0 1
       0 0 0 0 0 0 1 1 1 0];
opt = zeros(1, 10);

%cooling schedule
nsteps = 1000000;
Tinit = 5;
Tfinal = 0.01;

n = 1:nsteps;
T = Tinit + (Tfinal-Tinit).*n/nsteps; %linear schedule

for n = 1:nsteps
    V = ceil(10*rand(1));
    oldsum = sum(opt);
    if opt(V) == 0
        valid = 1;
        for i = 1:10
            if (Adj(V, i) ==1) & (opt(i) == 1)
                valid = 0;
            end
        end
        if valid == 1
            newsum = oldsum + 1;
            delta = newsum - oldsum;
            if rand(1)< min(exp(delta/T(n)), 1)
                opt(V) = 1;
            end
        end
    else
        newsum = oldsum - 1;
        delta = newsum - oldsum;
        if rand(1)< min(exp(delta/T(n)), 1)
            opt(V) = 0;
        end
    end
end 


