function Y = ff1(X,W)
% Y = ff1(X,W)
%
%   ff1() computes the vector output of a one layer feedforward neural network.
%   the input is a n x 1 column vector (or n x N if many samples are to be
%   computed simultaneously), and the output is a m x 1 column vector (or 
%   m x N).
%
%   X is n x N, where each column is a data sample.
%   W is m x (n+1), giving the weights to the hidden units and their biases.

 Xp = [ -ones(1,size(X,2)); X ];
 Y = 1./(1+exp(-W * Xp)); 

 
