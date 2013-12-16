function [I] = halfmaxcurrent(Vthr, Vrest, Vreset, tref, R, C)

I = (Vthr - Vrest - (Vreset - Vrest)*exp(-tref/(R*C)))/ (R*(1-exp(-tref/(R*C))))