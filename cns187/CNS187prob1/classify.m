function [y] = classify(w, x, theta)
y = sign(w'*x - theta)