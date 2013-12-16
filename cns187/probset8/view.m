function [] = view(data)
for i = 1:10, for j = 1:20
        imagesc(reshape(data(:,j), 33, 25)); axis equal; axis off; drawnow
    end; end