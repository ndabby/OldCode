function [f,V] = IaFsim(S,Vin,W,Ie,tau,tref,tdelay,tmax,dt,noise,showit)
%        [f,V] = IaFsim(S,Vin,W,Ie,tau,tref,tdelay,tmax,dt,noise,showit)
% This routine simulates a network of integrate and fire units,
% with the modification that only the most recent spike from a given unit
% is considered.  (Synaptic currents from prior spikes are set to
% zero whenever the neuron fires.)
% The input to the routine is spiking activity and membrane
% voltages at t=0, a constant input current, and unit parameters. 
% The output of the routine is 
% the spike train vector output of all the units.
%
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
%
% Built-in params:
% Vthr   = voltage threshold            (V)     
% Vrest  = resting voltage              (V)     
% Vreset = voltage reset after spike    (V)     
% R      = membrane resistance          (Ohm)   
% C      = membrane capacitance         (F)     

Vthr=-0.050; Vrest=-0.065; Vreset=-0.070;  %% in V
C = 5.0e-7;                                %% 200 nF
R = 1.0e4;                                 %% 100 kOhm 

m=size(S,1); n=size(S,2); S=S(:);  Vin=Vin(:); Ie=Ie(:);
L = ceil(tmax/dt);
N          = size(W,1);    % total number of units, including inputs
if ~(length(S)==N & (length(Vin)==N | length(Vin)==1) & (length(Ie)==N | length(Ie)==1))
  error('Inputs aren''t the correct lengths.');
end  
V          = Vrest*ones(N,L);  V(:,1)=Vin;
f          = zeros(N,L);
f(:,1)     = S(:);                   % initial spiking activity
I          = zeros(N,1);
tlast      = -Inf * ones(N,1); tlast(find(S))=0;

if showit
  figure(1); clf; colormap([gray(254); 1 0 0]);
  h = image(zeros(m,n)); title('neuron array'); 
  set(h, 'EraseMode', 'none'); axis equal; axis off
end

for t=2:L
      s = t*dt - tlast - tdelay; 
      syn = s.*exp(-s./tau); syn(find(isinf(s)))=0; syn(find(s<0))=0;
      I   =  W * syn + Ie; 
      dV  =  (Vrest-V(:,t-1))/(R*C) + I/C + (noise*sqrt(dt))*randn(N,1)/C;
      V(:,t)          = V(:,t-1)+dV*dt; 
      refractory      = (t*dt <= tlast+tref); % still refractory
      V(refractory,t) = Vreset;
      spiking         = (V(:,t)>=Vthr); % wants to spike 
      tlast(spiking)  = t*dt;  
      f(spiking,t)    = 1;

  if showit
      imf = (V(:,t)-Vreset)/(Vthr-Vreset)*255; imf(spiking)=255;
      set(h,'CData', reshape(imf,m,n));  drawnow;                      %% usually best
      % set(h,'CData', reshape((t*dt-tlast<tdelay)*255,m,n)); drawnow;  %% best for movies
  end
end



