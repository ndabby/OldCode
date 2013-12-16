function [ newW, newV, Ehist, Etrain, bestet, besteh] = earlym(X, D, Xv, Dv, W, V, dt,iters, Tau)


 N = size(X,2);
 Xp = [ -ones(1,N); X ];
 Ehist=zeros(1,iters);
 Etrain=zeros(1,iters);
 
 mW = zeros(16, 2);
 mV = zeros(1, 17);
 
 vcol = size(V,2);
 
 Z = 1./(1+exp(-W * Xp));
 Zp = [ -ones(1,N); Z]; 
 
 lowest =100;
 
 alpha = 0.0001;
 beta = 0.0001;
  
 for i=1:iters
    Z = 1./(1+exp(-W * Xp));
    Zp = [ -ones(1,N); Z]; 
    Y = 1./(1+exp(-V * Zp));
    eY = (Y-D).*Y.*(1-Y);
    Vp = V(:, 2:vcol);
    eZ = (Vp'*eY).*(Z.*(1-Z));
    dEdV = eY*Zp';
    dEdW = eZ*Xp';
    Ehist(i) = sum(sum( (Y-D).^2 )) / 2 / N ;
    
    Xpv = [ -ones(1,N); Xv ];
    Zv = 1./(1+exp(-W * Xpv));
    Zpv = [ -ones(1,N); Zv]; 
    Yv = 1./(1+exp(-V * Zpv));
    Etrain(i) = sum(sum( (Yv-Dv).^2 )) / 2 / N ;
  

    if Etrain(i)< lowest
        lowest = Etrain(i);
        newW = W;
        newV = V;
        bestet = Etrain(i);
        besteh = Ehist(i);
    end 
    
    mW = mW + dt*((-1/Tau)*mW - dEdW);
    mV = mV + dt*((-1/Tau)*mV - dEdV);
    
    W = W + dt*mW;
    V = V + dt*mV;
       
    if i > 1
        dL = (-1/Tau)*(sum(sum(mW.^2)) + sum(sum(mV.^2)))
    
        if dL < 0
            dt = dt +alpha;
        else if dL > 0
            dt = dt - (beta * dt);
            end
        end
        if dL == 0;
            dt = 0;
        end 
    end
 end
