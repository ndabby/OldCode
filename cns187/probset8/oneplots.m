function [] = oneplots(data, w, th)

err = 0.0;
%display(data(:, 20)), drawnow;
subplot(5, 2, 1) 
dude = oneerror(data, w, th, err);

subplot(5, 2, 2) 
dudette = oneerrorrand(w, th, err);

err = 0.01;
subplot(5, 2, 3) 
dude = oneerror(data, w, th, err);

subplot(5, 2, 4) 
dudette = oneerrorrand(w, th, err);

err = 0.05;
subplot(5, 2, 5) 
dude = oneerror(data, w, th, err);

subplot(5, 2, 6) 
dudette = oneerrorrand(w, th, err);

err = 0.1;
subplot(5, 2, 7) 
dude = oneerror(data, w, th, err);

subplot(5, 2, 8) 
dudette = oneerrorrand(w, th, err);

err = 0.2;
subplot(5, 2, 9) 
dude = oneerror(data, w, th, err);

subplot(5, 2, 10) 
dudette = oneerrorrand(w, th, err);
