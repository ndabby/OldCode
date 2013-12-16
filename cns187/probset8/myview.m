function [] = myview(d, we, th)

w = [we; th];
data = zeros(826, 20);
data(1:825, 1) = d(:, 1);
data(826, 1) = -1;
for i = 2:20
    data(:, i) = sign(w*data(1:825, i-1));
end


for i = 1:10, for j = 1:20
        imagesc(reshape(data(1:825,j), 33, 25)); axis equal; axis off; drawnow
    end; end