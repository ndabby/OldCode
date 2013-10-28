function [f, count] = p2conesample()

n = 100000;
count = 0;
t = zeros(n, 1);
for j = 1:n
    y = zeros(12, 1);
    y(1) = randn(1);
    for k = 2:12
       y(k) = 0.7*y(k-1) + randn(1);
    end
    if((y(1) > y(2)) & (y(2) > y(3)) & (y(3) > y(4)) & (y(4) > y(5)) & (y(5)>y(6)) & (y(6) > y(7)) & (y(7)>y(8)) & (y(8) > y(9)) & (y(9)>y(10)) & (y(10)> y(11)) & (y(11) > y(12)))
       t(j) = 1;
        
    end
end
f = find(t>0);   
count = size(f);