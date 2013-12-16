function [data] = myviewtwo(d, we, th)

w = we;
data = zeros(825, 20);
data(:, 1) = d(:, 1);
for i = 2:20
    data(:, i) = sign(w'*data(:, i-1) - th(i-1));
end


for i = 1:10, for j = 1:20
        imagesc(reshape(data(:,j), 33, 25)); axis equal; axis off; drawnow
        pause(0.1);
    end; end