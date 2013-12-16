function h = drawline(w)
% drawline(w) draws the line a*x + b*y = th, within the
%    frame [0 1 0 1], where w = [th a b].  
% h = drawline(w) returns the handle to the line object.

axis([0 1 0 1]);
th = w(1); a = w(2);  b = w(3);  %   -th + a x + b y = 0

if a~=0
 x0 = th / a;      %   -th + a x0 + b 0 = 0
 x1 = (th-b) / a;  %   -th + a x1 + b 1 = 0
 h = line([x0 x1], [0 1]);
 axis([0 1 0 1]);
else
 y0 = th / b;      %   -th + a 0 + b y0 = 0
 y1 = (th-a) / b;  %   -th + a 1 + b y1 = 0
 h = line([0 1], [y0 y1]);
 axis([0 1 0 1]);
end


