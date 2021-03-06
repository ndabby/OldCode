function [w, th, y, D, counter] = learningtwo(Pat) 
D = zeros(825, 20);
for i = 1:19
    D(:, i) = Pat(:, (i+1)); 
end
D(:, 20) = Pat(:, 1);

P = Pat;


%while all are not correctly classified

th = zeros(1, 825);
w = zeros(825, 825);    
y = zeros(825, 20);
counter = 0;
for j = 1:825
    hope = rand(825, 1);
    theta = 0;
    
    %counter
    counter = 0;
    cont = 1;
    while (cont == 1 & counter < 1000)

        %if y not equal to d pick a random pattern
        pick = floor(20*rand(1,1))+ 1; %get a number from 1-20
        x = P(:, pick);               %store pattern into x
        y(j, pick) = classify(hope, x, theta);
        if y(j, pick) == D(j, pick)
            ;
        else
            hope = hope + x*(D(j,pick)- y(j, pick))';
            hope(j) = 0;
            theta = theta - D(j,pick);

        end
        counter = counter + 1;        
        if sum(y(j, :) == D(j, :)) == 20;
            cont = 0;
        end
    end
    w(:, j) = hope;
    th(j) = theta;
end