function [newW, Ehist, Chist] = bprop1(X,W,D,dt,iters)
% [newW, Ehist, Chist] = bprop1(X,W,D,dt,iters)
%   X is n x N, where each column is a data sample.
%   W is m x (n+1), giving the weights to the output units and their biases.
%   D is m x N, giving the desired ouput values for each sample.
%   dt is the learning rate.
%   iters is the number of weight updates.
%
%   newW is the network weights after learning.
%   Ehist is a vector of mean error values, one for each step.
%   Chist is a vector of percentage of correct classifications, one for each step.

 N = size(X,2);
 Xp = [ -ones(1,N); X ];
 Ehist=zeros(1,iters);
 Chist=zeros(1,iters);
 for i=1:iters
  Y = 1./(1+exp(-W * Xp));
  Ehist(i) = sum(sum( (Y-D).^2 )) / 2 / N ;
  Chist(i) = sum(prod(abs(Y-D)<.2)) / N ;
  dEdW = % FILL THIS LINE IN
  W = W - dt * dEdW;
 end
 newW = W;
 
 
