function [solutions, failed] = q1(p)

%D = [1; -1; -1; -1; 1; 1; 1; 1; -1; 1; 1]
solutions = zeros(2^11, 11);
failed = zeros(2^11, 11);

for i = 1:2^11
    i
    for j = 1:11 
        nadine(j) = str2num(dec2bin(i,11))
        nadine = 2*nadine -1;
    end
    D = nadine';
    [w, match, count, thresh] = learn(p, D);
    if D == match
        solutions(i, :) = nadine;
    else
        failed(i, :) = nadine;
    end
end