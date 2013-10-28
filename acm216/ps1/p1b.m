function [states] = p1b()

n = 10000;
q = 5;
color = [1, 2, 3, 4, 5]; %initialized to a random coloring
adj = [0, 1, 0, 1, 1; 1, 0, 1, 0, 0; 0, 1, 0, 0, 0; 1, 0, 0, 0, 1; 1, 0, 0, 1, 0];
states = color;
dice = rand(q, n);
regcolor = [1, 2, 3, 4, 5];
for z = 1:n
    color = [1, 2, 3, 4, 5];
    for i = 1:q
        goodcolor = regcolor;
        if (dice(i, z)>= 0 & dice(i, z)< 0.2)
            v = 1;
        elseif (dice(i, z)>= 0.2 & dice(i, z)< 0.4)
            v = 2;
        elseif (dice(i, z)>= 0.4 & dice(i, z)< 0.6)
            v = 3;
        elseif (dice(i, z)>= 0.6 & dice(i, z)< 0.8)
            v = 4;
        elseif (dice(i, z)>= 0.8 & dice(i, z)< 1)
            v = 5;
        end
        %v
        neighbors = find(adj(v, :) > 0);
        p = size(neighbors, 2);
        for j = 1: p
            for k = 1:5
                if color(neighbors(j)) == goodcolor(k)
                    goodcolor(k) = 0;
                end
            end
        end
    %    goodcolor
        choice = find(goodcolor > 0);
        sz = size(choice);
        dist = 1/sz(2);
        roll = rand();
        %pick = color(v);
        for a = 1: sz(2)
            if( roll >= 0 & roll < (a*dist))
                pick = goodcolor(choice(a));%
                color(v) = pick;%
            end
        end
    end
    states = [states; color];
end
    
        
    
    