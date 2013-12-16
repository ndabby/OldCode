function [] = onefiveb(I)

xaxis = zeros(1000, 1);
for j = 1: 1000
    xaxis(j) = j;
end


rast = zeros(50, 1000);

for x = 1:50
   [s, v] = myIaFfive(I);
   rast(x, :) = s;
end
raster = rast;

sums= sum(rast);



subplot(3,1,1), imagesc(-raster), colormap('gray')
subplot(3,1,2), plot(xaxis, sums)
subplot(3,1,3), plot(xaxis, I)