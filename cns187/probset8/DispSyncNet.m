function S = DispSyncNet(W,Sinit,Theta,tmax,perr) %data)
N=length(Sinit); %#825
S = Sinit(:);

Stmp = zeros(size(S));
%W=W';
t=0;

while t<tmax
    t=t+1;
    for i=1:N
        Stmp(i) = sign(W(i,:) * S - Theta(i));
        if rand(1) < perr
            %Flip unit value
            Stmp(i) = - Stmp(i);
        end
    end
    %Send noisy image to next frame
    S = Stmp;

    %Plot noisy image
    Subplot(1,3,1);
        imagesc(reshape(S, 33, 25)); axis equal; axis off; colormap gray;  drawnow;
    %Plot clean image
    %Subplot(1,3,2);
    %t1 = t+1 - 20*(floor((t)/20));
   % display(data(:,t1)); drawnow;
    %Plot "real" image
    %Subplot(1,3,3);
    %t2 = t+2 - 20*(floor((t+1)/20));
    %[t,t1,t2]
  %  display(data(:,t2)); drawnow;
end
%DispPat(S); drawnow;