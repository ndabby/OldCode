function [f, count, y1, y6, y12] = p2d()

n = 5000;
count = 0;
y1 = 0;
y6 = 0;
y12 = 0;
t = zeros(n, 1);
y = [3, 2.5, 2, 1, 0, -0.2, -0.8, -1, -2, -2.5, -3, -3.5]
for i = 1:n

    q = ceil(12* rand(1));
    if q > 1 & q < 12
        r = 0.7*y(q-1) + (0.7/1.49)* (y(q+1)-0.49*y(q-1)) + (1/1.49)*randn(1);
        if(r > y(q+1) & r < y(q-1))
            y(q) = r;
            y1 = [y1; y(1)];
            y6 = [y6; y(6)];                
            y12 = [y12; y(12)];
            t(i) = 1;
        end
    end
    h = find(t>0);
    if( i == 1)
        f = h;
    else
        f = [f; h];
    end
    count = count + size(h);
    
end