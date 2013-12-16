function [Y, E] = q2test(X, D, W, V)

 N = size(X,2);
 Xp = [ -ones(1,N); X ];
 Z = 1./(1+exp(-W * Xp));
 Zp = [ -ones(1,N); Z]; 
 
 Y = 1./(1+exp(-V * Zp));
 E = sum(sum( (Y-D).^2 )) / 2 / N ;
  