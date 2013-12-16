function [rpat] = randpatbetter(x)
rpat = rand(100,x);
for i = 1 : 100
    for j = 1:x
        if rpat(i,j) < 0.5
            rpat(i,j) = -1;
        else rpat(i,j) = 1;
        end
    end
end

