function S = DispAsyncNet(W,Sinit,tmax)
% S = DispAsyncNet(W,Sinit,tmax)
%
% Simulator for asynchronous-update high-gain network, for tmax time steps.
% Sinit has values +/- 1, as does S.
% If you know a stable state must be reached (e.g. W is symmetric), 
% then tmax = Inf is OK -- AsyncNet will return once it's verified that
% all bit positions are stable.
%
% Displays S as a square image at each update.


N=length(Sinit);
t=0; S = Sinit(:); tested=zeros(size(S));
while t<tmax & sum(tested)<N
 t=t+1;
 i=ceil(rand(1)*N);
 Si = sign(W(i,:) * S);
 if Si==S(i)
   tested(i)=1;
 else
   S(i)=Si; tested=zeros(size(S));
   DispPat(S); drawnow;
 end
end
