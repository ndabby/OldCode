function boundary(X, D, W) 
% boundary(X, D, W) makes a scatter plot of the data 
%  from class1 (X(:,i) for which D(:,i)=[1;0], shown as 'o') 
%  and class2 (X(:,i) for which D(:,i)=[0;1], shown as '+') 
%  and draws the decision boundary for all units in W, 
%  where each row of W is [th a b], specifying a 
%  unit whose activity is z = 1/(1+exp(a*x + b*y - th)).  The 
%  line for z(x,y) = .2 is dotted; the line for z(x,y) = .5 is 
%  dashed; the line for z(x,y) = .8 is solid.

 class1 = X(:, find(D(1,:)));  class2 = X(:, find(D(2,:)));
 plot(class1(1,:), class1(2,:), 'o', class2(1,:), class2(2,:), '+')
 for i = 1:size(W,1)
    h = drawline(W(i,:)+[log(4) 0 0]); set(h,'linestyle',':');
    h = drawline(W(i,:)); set(h,'linestyle','--');
    h = drawline(W(i,:)-[log(4) 0 0]); set(h,'linestyle','-');
 end
  
 axis([0 1 0 1])  


