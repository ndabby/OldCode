function [hebbd, plud, hebbr, plur] = analyzethat(pat)

mydata = randdata();   %my random ten patterns
test = randpat();

hebbr = zeros(10, 11); %histo for hebb rands
plur = zeros(10, 11);  %histo for plu rand
hebbd = zeros(10, 11); %histo for hebb digits
plud = zeros(10, 11);  %histo for plu digits


for a = 1:10 
    w = hebb(pat, a);
    v = plu(pat, a);
    rw = hebb(mydata, a);
    rv = plu(mydata, a);
    for b = 1:100
        resw = AsyncNet(w, test(:, b), 10000);
        resv = AsyncNet(v, test(:, b), 10000);
        resrw = AsyncNet(rw, test(:, b), 10000);
        resrv = AsyncNet(rv, test(:, b), 10000);
        for c = 1:10
            if isequal(resw, pat(:,c)) || isequal(resw, -(pat(:,c)))
                hebbd(a, c) = hebbd(a, c) + 1;
            end
              
            if isequal(resv, pat(:,c)) || isequal(resv, -(pat(:,c)))
                plud(a, c) = plud(a, c) + 1;
            end
        
            if isequal(resrw, mydata(:,c)) || isequal(resrw, -(mydata(:,c)))
                hebbr(a, c) = hebbr(a, c) + 1;
            end
        
            if isequal(resrv, mydata(:,c)) || isequal(resrv, -(mydata(:,c)))
                plur(a, c) = plur(a, c) + 1;
            end
        end
    end
end

for x = 1:10
        hebbr(x, 11) = 100 - sum(hebbr(x,:));
        hebbd(x, 11) = 100 - sum(hebbd(x,:));
        plur(x, 11) = 100 - sum(plur(x,:));
        plud(x, 11) = 100 - sum(plud(x,:));
end

subplot(2,2,1), bar(hebbd, 'stacked')
subplot(2,2,2), bar(plud, 'stacked')
subplot(2,2,3), bar(hebbr, 'stacked')
subplot(2,2,4), bar(plur, 'stacked')