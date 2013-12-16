function [rpat] = randdata()
rpat = rand(100,10);
for i = 1 : 100
    for j = 1:10
        if rpat(i,j) < 0.5
            rpat(i,j) = -1;
        else rpat(i,j) = 1;
        end
    end
end

