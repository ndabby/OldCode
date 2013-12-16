function [ newW, newV, Ehist, Chist, dtHist, counter] = bprop2(X, W, V, D,dt,iters)
% [newW, Ehist, Chist] = bprop1(X,W,D,dt,iters)
%   X is n x N, where each column is a data sample.
%   Z, eZ is h x N
%   Y, eY is m x N
%   W is h x (n+1), giving the weights to the hidden units and their biases.
%   V is m x (h+1), giving weights to output units and their biases
%   D is m x N, giving the desired ouput values for each sample.
%
%   dt is the learning rate.
%   iters is the number of epochs.
%
%   newW is the network weights after learning.
%   Ehist is a vector of mean error values, one for each step.
%   Chist is a vector of percentage of correct classifications, one for each step.

 N = size(X,2);
 Xp = [ -ones(1,N); X ];
 Ehist=zeros(1,iters);
 Chist=zeros(1,iters);
 dtHist = zeros(1,iters);
 
 Z = 1./(1+exp(-W * Xp))
 Zp = [ -ones(1,N); Z]; 
 %t = 0;
 alpha = 0.01;
 beta = 0.1;
 counter = 0;
 
 for i=1:iters
    Z = 1./(1+exp(-W * Xp))
    Zp = [ -ones(1,N); Z]; 
    Y = 1./(1+exp(-V * Zp));
    eY = (Y-D).*Y.*(1-Y);
    Vp = V(:, 2:3);
    eZ = (Vp'*eY).*(Z.*(1-Z));
    dEdV = eY*Zp';
    dEdW = eZ*Xp';
    Ehist(i) = sum(sum( (Y-D).^2 )) / 2 / N ;
    Chist(i) = sum(prod(abs(abs(Y-D)<.2))) / N ;

    W = W - dt * dEdW;
    V = V - dt * dEdV;
    
    if i > 1
        dE = Ehist(i) - Ehist(i-1);
    
        if dE < 0
            dt = dt +alpha;
            counter = counter + 1;
        else if dE > 0
    %     W = W + dt * dEdW;
    %     V = V + dt * dEdV;
            dt = dt - (beta * dt);
            end
        end
        if dE == 0;
            dt = 0;
        end 
    end
    dtHist(i) = dt;
 end
 newW = W;
 newV = V;
 