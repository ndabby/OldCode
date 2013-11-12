function dy = toehold_ave_1(t,y)

dy = zeros(3,1);
k2 = 0.0014; %calculated from m16 data ALWAYS THE SAME

k1 = 3000000; %from zhang et al

concentration_difference = 80*10^-9; %difference in concentration between reactants

dy(1) = -k1*(concentration_difference + y(1))*y(1); 
dy(2) = k1*y(1)*(concentration_difference+y(1))-k2*y(2);
dy(3) = k2*y(2);


%Step 1: link matlab path to the attached file
%
%For the attached file:
%
%This is the file defining the differential equation to be simulated.
%
%The last line is the differential equation. You can plug in the rates
%and concentrations.
%*************************************************
%
%
%Step 2:  Use the following commands to simulate:
%
%options =
%odeset('MaxStep',100,'refine',1e-10,'InitialStep',100,'RelTol',1e-10,'AbsTol',1e-10)
%
%[T,Y] = ode45(@six_n,[0 10000],[0],options);
%
%plot(T,Y(:,1))
%
%
%
%The first command has two parts. The part from MaxStep to InitialStep
%set the time between each simulation time step and output to be 100.
%The rest sets the simulation precision. You can change the time step
%to fit your data point.
%
%The second commnad tells it to simulate from 0 to 10000, the starting
%value is 0, and use the option set in the first command.
%
%
%You can compare the output Y to your data (need to convert the reading
%to concentration, or you can normalize the simulation output to
%max=1).
%