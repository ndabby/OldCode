function DispPat(thepat)
% DispPat(thepat)
%
% Displays a binary (-1/+1) vector of n x n elements long as an n x n matrix.

colormap('gray');
n = floor(sqrt(length(thepat)));
imagesc(reshape(thepat(:),n,n),[-1 1]);
axis('square');

