function [w, yarray, counter] = learning(Pat) 
D = zeros(825, 20);
for i = 1:19
    D(:, i) = Pat(:, (i+1)); 
end
D(:, 20) = Pat(:, 1);

P = [Pat; -ones(1, 20)];


%while all are not correctly classified

w = zeros(826, 825);    


yarray = zeros(825, 20);

for j = 1:825
    hope = rand(826, 1);
    counter = 0;
    cont = 1;
    while (cont == 1 & counter < 500)
        if yarray(j, :) == D(j, :);
            cont = 0;
        end
        %if y not equal to d pick a random pattern
        pick = floor(20*rand(1,1))+ 1; %get a number from 1-20
        x = P(:, pick);               %store pattern into x
        y(i, pick) = classify(hope, x);
        if y(i, pick) == D(i, pick)
            ;
        else
            hope = hope + x*(D(i,pick)- y(i, pick))';
            %w(1:825, :) = w(1:825, :) - diag(diag(w(1:825, :)));
              counter = counter + 1;

        end

    end
    w(:, j) = hope;        
    
end

