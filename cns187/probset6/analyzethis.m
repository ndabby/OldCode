function [hd, hr, pr, pd, mydata] = analyzethis(pat)

mydata = randdata();   %my random ten patterns


hebbr = zeros(10, 10); %histo for hebb rands
plur = zeros(10, 10);  %histo for plu rand
hebbd = zeros(10, 10); %histo for hebb digits
plud = zeros(10, 10);  %histo for plu digits

hr = zeros(1,10);
hd = zeros(1,10);
pr = zeros(1,10);
pd = zeros(1,10);

for a = 1:10 
    w = hebb(pat, a);
    v = plu(pat, a);
    rw = hebb(mydata, a);
    rv = plu(mydata, a);
    for b = 1:a
        resw = AsyncNet(w, pat(:, b), 10000);
        resv = AsyncNet(v, pat(:, b), 10000);
        resrw = AsyncNet(rw, mydata(:, b), 10000);
        resrv = AsyncNet(rv, mydata(:, b), 10000);
        if isequal(resw, pat(:,b))
            hebbd(a, b) = hebbd(a, b) + 1;
        end
        
        if isequal(resv, pat(:,b))
            plud(a, b) = plud(a, b) + 1;
        end
        
        if isequal(resrw, mydata(:,b))
            hebbr(a, b) = hebbr(a, b) + 1;
        end
        
        if isequal(resrv, mydata(:,b))
            plur(a, b) = plur(a, b) + 1;
        end
    end
end

for x = 1:10
        hr(x) = sum(hebbr(x,:))
        hd(x) = sum(hebbd(x,:))
        pr(x) = sum(plur(x,:))
        pd(x) = sum(plud(x,:))
end




 subplot(2, 1, 1), plot(hd, 'red'), hold, plot(pd, 'black'), hold
 subplot(2, 1, 2), plot(hr, 'blue'), hold, plot(pr, 'green'), hold
%subplot(3,2,1),
%subplot(3,2,2), bar(plud, 'stacked')
%subplot(3,2,3), bar(, 'stacked')
%subplot(3,2,4), bar(, 'stacked')
%subplot(3,2,5), plot(), hold, plot(), plot(), plot(), hold