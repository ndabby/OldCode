function [freq, input, disp] = twotwo(w, t, data)

freq = zeros(20, 10);
input = zeros(825, 20);
disp = zeros(825, 20);

red = w'; %retransposing screwed up weights
tees = zeros(825, 825);
for i = 1:825
    tees(i, :) = t;
end


dhat = 0.5*(data + 1);


weight = 0.004*(red./tees);

W = [zeros(825,825), weight; zeros(825, 1650)];

for i = 1:20

    S = [zeros(825, 1); dhat(:,i) ];
%Vin = [-0.07; -0.07]  %Vreset
%Ie = [0; 0]
    tau = 0.002* ones(1650, 1);
    tref = 0.014* ones(1650, 1);
    tdelay = 0.002* ones(1650,1);
    tmax = 0.01
    dt = 0.001
    noise = 0.00000
%showit = 1

    [f,V] = IaFsim(S,W,tau,tref,tdelay,tmax,dt,noise)
    %imagesc(reshape(pat, 33, 25)); axis equal; axis off; colormap gray; 
    
    freq(i, :) = sum(f(1:825, :));
    disp(:, i) = f(1:825, 3);
    input(:, i) = f(826:1650, 1);
end
