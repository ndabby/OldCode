function [freq] = threetwo()
%        [f,V] = IaFsim(S,Vin,W,Ie,tau,tref,tdelay,tmax,dt,noise,showit)
% ***********  Description of Parameters and Variables ************
%
% f      = unit spike trains             (0-1)    matrix (units i, dt samples) 
% V      = membrane voltage waveform      (V)     matrix (units i, dt samples) 
% S      = initial spike volley          (0-1)    vector (units i)
%     S may be arranged as an array, which affects only its real-time display    
% Vin    = initial membrane voltages      (V)     scalar or vector
% W      = synaptic current weights       (A)     matrix (units i,j)
% Ie     = external input current         (A)     scalar or vector
% tau    = synaptic current time         (sec)    scalar or vector 
% tref   = refractory period             (sec)    scalar or vector
% tdelay = axonal delay                  (sec)    scalar or vector 
% dt     = time step                     (sec)   
% noise  = std for iid gausian/sqrt(dt)  (A/sqrt(sec))     
% showit = graphic display during simulation? [0 or 1]

freq = zeros(1, 100)

S = [1; 0]
Vin = [-0.07; -0.07]  %Vreset
W = [0, 8.0e-5; 8.0e-5, 0]
Ie = zeros(2, 100)
for i = 1:100
    Ie(1, i) = 1.0e-6 + (i)*0.7e-8;
    Ie(2, i) = 1.0e-6 + (i)*0.7e-8;
end

tau = [0.01; 0.01]
tref = [0.005; 0.005]
tdelay = [0.002; 0.002]
tmax = 1
dt = 0.001
noise = 0.00000
showit = 0

for j = 1:100
    [f,V] = IaFsim(S,Vin,W,Ie(:, j),tau,tref,tdelay,tmax,dt,noise,showit);
    freq(j) = sum(sum(f))/2;
end

plot(Ie(1,:), freq)
hold;

S = [0, 0]
for j = 1:100
    [f,V] = IaFsim(S,Vin,W,Ie(:, j),tau,tref,tdelay,tmax,dt,noise,showit);
    freq(j) = sum(sum(f))/2;
end

plot(Ie(1,:), freq)

S = [1, 1]

for j = 1:100
    [f,V] = IaFsim(S,Vin,W,Ie(:, j),tau,tref,tdelay,tmax,dt,noise,showit);
    freq(j) = sum(sum(f))/2;
end

plot(Ie(1,:), freq)
