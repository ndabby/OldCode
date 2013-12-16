function [data] = oneerror(d, we, th, err)

rm = zeros(825, 1);

w = we;
data = zeros(825, 20);
data(:, 1) = d(:, 1);
for i = 2:20
    data(:, i) = sign(w'*data(:, i-1) - th(i-1)) ;
    rm = rand(825, 1);
    dude = -1*(2*(rm < err) - 1);
    data(:, i) = data(:,i).*( dude);
    
end


for i = 1:10, for j = 1:20
        imagesc(reshape(data(:,j), 33, 25)); axis equal; axis off; colormap gray; drawnow
      
    end; end