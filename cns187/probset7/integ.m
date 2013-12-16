[Z] = integ()%R,C,Vthr,Vrest,Vreset,tref,dt,w, A)




R=10^8;C=10^-10;Vthr=-0.050;Vrest=-0.065;Vreset=-0.070;tref=0.005;
dt=0.0001;
w = 5
A = 1



n = 1/dt;
x = zeros(n, 1);
y = zeros(n, 1);



for i = 1:n
    x(i)= n*(1/dt*w)
    tfire = -R*C*log((Vthr - Vrest -R*(A*sin(2*pi*w*x(i))))/(Vreset - Vrest -R*(A*sin(2*pi*w*x(i)))))
    y(i)= (1/(tref + tfire))
end

Z = trapz(x,y)

