function [S,V] = IaF(I,R,C,Vthr,Vrest,Vreset,tref,dt,noise)
% [S,V] = IaF(I,R,C,Vthr,Vrest,Vreset,tref,dt,noise)
% This is a routine to implement the integrate and fire model of a
% neuron. The input to the routine is the current injected into  
% the neuron, and neuron parameters. The output of the routine is 
% the spike train vector output of the neuron in response to the current.  
%
% ***********  Description of Parameters and Variables ************
%
% I            = input current vector      (A)     vector (dt samples) 
% V            = membrane voltage waveform (V)     vector (dt samples) 
% S            = spike waveform           (0-1)    vector (dt samples) 
% Vthr         = voltage threshold         (V)         scalar
% Vrest        = resting voltage           (V)         scalar
% Vreset       = voltage reset after spike (V)         scalar
% R            = membrane resistance       (Ohm)       scalar
% C            = membrane capacitance      (F)         scalar
% tref         = refractory period         (sec)       scalar
% dt           = time step                 (sec)       scalar
% noise        = std for iid gausian/dt    (A)         scalar 
%
% Note: Vectors are row vectors.
%       Multiple trials may be given, in which case I(n,t) is the current
%        input for trial n, time step t.  (I.e. time t*dt.)


trials     = size(I,1);
L          = size(I,2);            
S          = zeros(trials,L);
V          = Vrest*ones(trials,L);

for n = 1:trials
   tlast = -tref; 
   for j=2:L
     if(j*dt > tlast + tref)      % If the time past last spike > Tref  
        dV = (Vrest-V(n,j-1))/R/C + I(n,j-1)/C + noise * randn(1) / C;
        V(n,j) = V(n,j-1) + dt * dV;
        if V(n,j) >= Vthr            % If the threshold voltage is exceeded 
           V(n,j) = Vreset;          % Set the voltage to Vrest for t <Tref 
           tlast  = j*dt;            % Record the spike time 
           S(n,j) = 1;
        end
     else
        V(n,j)=Vreset;
     end
   end
end



