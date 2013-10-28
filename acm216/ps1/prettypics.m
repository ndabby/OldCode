function [tot, states] = prettypics(states)
places = unique(states, 'rows')
sz = size(places);
tot = zeros(sz(1), 1);
for i= 1: sz(1)
    a = ismember(states, places(i, :), 'rows');
    b = sum(a);
    tot(i) = b;
end

bar(tot);
    