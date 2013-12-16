function [rpat] = randpat()
rpat = rand(100,100);
for i = 1 : 100
    for j = 1:100
        if rpat(i,j) < 0.5
            rpat(i,j) = -1;
        else rpat(i,j) = 1;
        end
    end
end

