function [hd, hr, pr, pd, mydata] = analyzeme()

mydata = randpat();   %my random hundred patterns


hebbr = zeros(100, 100); %histo for hebb rands
plur = zeros(100, 100);  %histo for plu rand

hr = zeros(1,100);
pr = zeros(1,100);

for a = 1:100 
    rw = hebb(mydata, a);
    rv = plu(mydata, a);
    for b = 1:a
        resrw = AsyncNet(rw, mydata(:, b), 10000);
        resrv = AsyncNet(rv, mydata(:, b), 10000);
        
        if isequal(resrw, mydata(:,b))
            hebbr(a, b) = hebbr(a, b) + 1;
        end
        
        if isequal(resrv, mydata(:,b))
            plur(a, b) = plur(a, b) + 1;
        end
    end
end

for x = 1:100
        hr(x) = sum(hebbr(x,:))
        pr(x) = sum(plur(x,:))
end

subplot(2, 1, 2), plot(hr, 'blue'), hold, plot(pr, 'green'), hold
%subplot(3,2,1),
%subplot(3,2,2), bar(plud, 'stacked')
%subplot(3,2,3), bar(, 'stacked')
%subplot(3,2,4), bar(, 'stacked')
%subplot(3,2,5), plot(), hold, plot(), plot(), plot(), hold