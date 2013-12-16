function [w]= plu(pat, x)
w = zeros(100, 100);
counter = 0;
si = zeros(100,1);
while counter <10000
    a = floor(rand()*x + 1);
    si = sign(w*pat(:, a));
    dw = pat(:,a)*(pat(:,a) - si)';
    dw = dw - diag(diag(dw));
    w = w + dw + dw'; 
    counter = counter + 1;
end

