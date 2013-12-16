function [w, yarray, counter] = learn(Pat) 
D = zeros(825, 20);
for i = 1:19
    D(:, i) = Pat(:, (i+1)); 
end
D(:, 20) = Pat(:, 1);

P = [Pat; -ones(1, 20)];


%while all are not correctly classified

w = zeros(826, 825);    
w(1:825, :) = w(1:825, :) - diag(diag(w(1:825, :)));

counter = 0;
cont = 1;
yarray = zeros(825, 20);
while (cont == 1 & counter < 1000)
    for i = 1:20
        yarray(:, i) = classify(w, P(:, i));
    end
    if(yarray == D) 
        cont = 0; %stop while loop
    else   %if y not equal to d pick a random pattern  
        pick = floor(20*rand(1,1))+ 1; %get a number from 1-20
        x = P(:, pick);               %store pattern into x
        yarray(:, pick) = classify(w, x);
        if yarray(:, pick) == D(pick) 
            ;
        else
            w = w + x*(D(:,pick) - yarray(:, pick))';
            w(1:825, :) = w(1:825, :) - diag(diag(w(1:825, :)));
             
        end
    end
    counter = counter + 1;
end

