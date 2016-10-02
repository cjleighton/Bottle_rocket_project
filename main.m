global g0 gamma R pa rhoair rhow vB Cd cd Ab At p0 vAi mAi TAi mB;
    % g0: Acceleration due to gravity
    % gamma: Ratio of specific heats of air
    % R: The gas constant for air
    % pa: Ambient pressure
    % rhoair: Density of outside air
    % rhow: Density of water
    % vB: The volume of the bottle
    % Cd: Drag coefficient
    % cd: Discharge coefficient
    % Ab: Cross-sectional area of bottle
    % At: Area of throat
    % p0: Initial air pressure in bottle
    % vAi: Initial volume of air in bottle
    % mAi: The initial mass of air in the bottle
    % TAi: The initial temperature of air in the bottle
    % mB: The mass of the bottle, cone, and vanes (without air and water)

%%{
% Parameters for test case
p0=427682+20000; % Total initial pressure in rocket, p
vWi=0.001; % +/- 0.0002
Cd=0.3; % +/- 0.02
theta0=45*(pi/180); % +/- 9 degrees
%%}

%{
p0=485000; % The initial gage pressure inside the rocket, pa
vWi=0.001; % The initial volume of water in the rocket, m^3
Cd=0.3; % The rocket's coefficient of drag
theta0=45*(pi/180); % The rocket's launch-angle
%}

pa=82943.93; % Ambient pressure, pa
g0=9.81; % Acceleration due to gravity
R=287; % Gas constant for air
cd=0.8; % Discharge coefficient of rocket
rhoair=0.961; % Density of outside air, kg/m^3
vB=0.002; % Volume of bottle, m^3
gamma=1.4; % Ratio of specific heats for air
rhow=1000; % density of water, kg/m^3
Dt=0.021; %Diameter of throat, m
Db=0.105; %Diameter of bottle, m
mB=0.07; %Mass of empty bottle, kg
Ab=pi*(Db/2)^2; % %Cross-sectional area of bottle, m^2
At=pi*(Dt/2)^2; % Throat area of bottle, m^2
TAi=300; % Initial temperature of air in bottle, K
vAi=vB-vWi; % Initial volume of air in bottle, m^3
mAi=(p0*vAi)/(R*TAi); % The initial mass of air in the rocket, kg
mri=mB+rhow*(vB-vAi)+vAi*(p0/(R*TAi)); % The total initial mass of the rocket, kg
V0=0; % Rocket's initial velocity, m/s
x0=0; % The rocket's initial horizontal position, m
z0=0.1; % The rocket's initial vertical position, m

%% evaluate the system
[t sol] = ode45(@diffeqs,[0 10], [x0 z0 V0 theta0 mri mAi vAi]); % Run ode45
x=sol(:,1); % Extract horizontal coordinates from the solutions
z=sol(:,2); % Extract vertical coordinates from the solutions
hold on;
plot(x,z); % Plot the trajectory
title('Trajectory of Rocket','FontSize',18);
xlabel('Horizontal distance, m','FontSize',16);
ylabel('Altitude above ground, m','FontSize',16);
axis([0 85 0 25]);
%axis([0 60 0 18]);
grid minor;