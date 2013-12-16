function [freq, f] = twofour(data)%w, t, data)

freq = zeros(1, 1000);
%input = zeros(825, 20);
%disp = zeros(825, 20);

%red = w'; %retransposing screwed up weights
%tees = zeros(825, 825);
%for i = 1:825
%    tees(i, :) = t;
%end


dhat = 0.5*(data + 1);

z = 0.0000116
%weight = 0.004*(red./tees %0.004 is Wtheta

W = ones(825, 825); %weight;
W = W - diag(diag(W));
W = z*W;

for i = 1:1
    S = dhat(:,i) ;
%Vin = [-0.07; -0.07]  %Vreset
%Ie = [0; 0]
    tau = 0.002* ones(825, 1);
    tref = 0.014* ones(825, 1);
    tdelay = 0.03* ones(825,1);
    tmax = 1
    dt = 0.001
    noise = 0.00000
%showit = 1

    [f,V] = IaFsim(S,W,tau,tref,tdelay,tmax,dt,noise);
    %imagesc(reshape(pat, 33, 25)); axis equal; axis off; colormap gray; 
    
    freq(i, :) = sum(f);
    %disp(:, i) = f(1:825, 3);
    %input(:, i) = f(1:825, 1);
end