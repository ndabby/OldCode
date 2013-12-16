%function jens()
% Initialization:
load full_movie_data.mat
S = data;
MaxIterations = 3000;
N = length(S(:,1));
M = length(S(1,:));
W = zeros(N,N);
Theta = zeros(N,1);

%Input:
X = [S(1:N,M),S(1:N,1:M-1)]; %No loops: X = S(1:N,1:M-1); 

%Desired output:
D = [S(1:N,1),S(1:N,2:M)]; %No loops: %D = S(1:N,2:M); 

for n=1:N;
    %Init:
    V = zeros(N,1); Thr = 0; t=0;
    % PLR Algorithm
    while t<=MaxIterations %Prevents timeout
        %Random input/output set:
        a = round(rand(1)*(M-1))+1; % 1-20
        % Checks if correct classified
        if sign(V'*X(:,a) - Thr) ~= D(n,a)
            % Nudge W
            V = V + D(n,a)*X(:,a);
            V(n) = 0;
           
            MaxAct = sum(V.*(V>0));
            Thr = 2/10*MaxAct-sum(V);    %Thr = Thr - D(n,a);
            t = t+1;
        end
        %Check if all patterns are correctly classified:
        if sign(V'*X - Thr.*ones(1,M)) == D(n,:)
                %Learning is done - quit
                t = MaxIterations+1;
                ok=1;
        end
    end
    
    if t == MaxIterations+1
       'Fail'; 
    end
    W(:,n) = V;
    Theta(n) = Thr;
end