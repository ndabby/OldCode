function [w] = hebb(pat, x)
w = pat(:, 1:x)*(pat(:, 1:x))';
w = w-diag(diag(w));