
R=10^8;C=10^-10;Vthr=-0.050;Vrest=-0.065;Vreset=-0.070;tref=0.005;
dt=0.0001; % RC = .010 sec  
noise=100*10^-12;

ampRange  = (0:.05:2.5)*10^-9; ampRangeL = length(ampRange);
wRange    = -2:.1:log(300); wRangeL   = length(wRange);
f = zeros(wRangeL,ampRangeL);
for wI = 1:wRangeL
 w=exp(wRange(wI));
 t = 0:dt:1/w;
 for ampI =1:ampRangeL
   amp = ampRange(ampI);
   I   = amp * sin(2 * pi * w * t);
   q = find(I <= 0);
       I(q) = 0;
   
   tfire = -R*C.*log((Vthr - Vrest - R.*I)./(Vreset - Vrest -R.*I));
   Z = w.*trapz(t, 1./(tref + tfire));
   
   %I   = amp * cos(2 * pi * w * t);
   %[S,V] = IaF(I,R,C,Vthr,Vrest,Vreset,tref,dt,noise);
   f(wI,ampI) = Z;
   %fprintf(1, 'f(%d,%d) = %f spikes in 1 sec: w=%f Hz, I=%f nA\n', ...
    %       wI, ampI, sum(S), w, amp*10^9);
 end
end
save IAFdata f

surf(ampRange*10^9,wRange,f)

ylabel('input current frequency (Hz, log scale)');
xlabel('input current amplitude (nA)'); zlabel('firing rate (Hz)')

%print -depsc IaF_freq_v1.eps 