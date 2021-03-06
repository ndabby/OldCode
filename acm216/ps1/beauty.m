N = 50000;
a1 = [0, 0; 0, 0.16];
a2 = [0.2, -0.26; 0.23, 0.22];
a3 = [-0.15, 0.28; 0.26, 0.24];
a4 = [0.85, 0.04; -0.04, 0.85];
b1 = [0; 0];
b2 = [0; 1.6];
b3 = [0; 0.44];
b4 = [0; 1.6];

t1 = 0.01;
t2 = 0.07;
t3 = 0.07;
t4 = 0.85;

dice = rand(N, 1);
theta = ones(N, 1);
f2 = find(dice >= 0.01 & dice < 0.08);
theta(f2) = f2*0 + 2;
f3 = find(dice >= 0.07 & dice < 0.15);
theta(f3) = f3*0 + 3;
f4 = find(dice >= 0.15 & dice < 1);
theta(f4) = f4*0 + 4;

X = zeros(2, N);

for i = 2:N
    switch theta(i)
        case {1}
            alpha  = a1;
            beta = b1;
        case {2}
            alpha = a2;
            beta = b2;
        case {3}
            alpha = a3;
            beta = b3;
        case {4}
            alpha = a4;
            beta = b4;
        otherwise
    end
    X(:, i) = alpha*X(:, i-1) + beta;
end
plot(X(1, :), X(2, :), '.');
