function Y = ff2(X,W,V)
% Y = ff2(X,W,V)
%
%   ff2() computes the vector output of a two layer feedforward neural network.
%   the input is a n x 1 column vector (or n x N if many samples are to be
%   computed simultaneously), and the output is a m x 1 column vector (or 
%   m x N).
%
%   X is n x N, where each column is a data sample.
%   W is h x (n+1), giving the weights to the hidden units and their biases.
%   V is m x (h+1), giving the weights to the ouput units and their biases.

 Xp = [ -ones(1,size(X,2)); X ];
 Z = 1./(1+exp(-W * Xp)); 
 Zp = [ -ones(1,size(Z,2)); Z ];
 Y = 1./(1+exp(-V * Zp));
 
