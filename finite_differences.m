% start by prompting the user for circuit values
% as well as time-step values.
prompt0 = 'Please enter a V0 value: ';
V = input(prompt0);
prompt1 = 'Please enter an R1 value: ';
R1 = input(prompt1);
prompt2 = 'Please enter an R2 value: ';
R2 = input(prompt2);
prompt3 = 'Please enter a value for C: ';
C = input(prompt3);
prompt4 = 'Please enter a maximum value for t (time): ';
tn = input(prompt4);
prompt5 = 'Lastly, please enter a delta t value for the time steps: ';
Dt = input(prompt5);

% initialize time array with t0 = 0 and increments of size Dt
t0 = 0;
t = [t0:Dt:tn]; 
n = length(t); 
tau = (R1*R2*C) / (R1 + R2); % time constant

% The analytical solutions will be plotted as well for reference
VC_Actual = -(V*R2/(R1 + R2)) * exp(- t / tau) + V*R2/(R1 + R2);
V1_Actual = V - VC_Actual;

% Initial conditions
VC_0 = 0; 
V1_0 = V - VC_0;

% initialize VC and V1 arrays that will hold the calculated values at the
% time steps t0:tn.
VC_FinDiff = zeros(n); V1_FinDiff = zeros(n);
VC_FinDiff(1) = VC_0;
V1_FinDiff(1) = V1_0;

% calculate the VC and V1 values using finite differences
for i = 2:n
   VC_FinDiff(i) = (Dt*V)/(R1*C) + VC_FinDiff(i-1) * (1 - (Dt/tau));
   disp(VC_FinDiff(i));
   V1_FinDiff(i) = V - VC_FinDiff(i);
end

% plot the finite differences calculations
ax1 = subplot(2,1,1);
Capacitor   = plot(ax1, t, VC_FinDiff);
title('Capacitor Voltage using Finite Differences');
ylabel('Vc (V)');
xlabel('Time');

ax2 = subplot(2,1,2);
Resistor1   = plot(ax2, t, V1_FinDiff);
title('R1 Voltage using Finite Differences');
ylabel('V1 (V)');
xlabel('Time');


% finally, in a new window, plot the analytical solutions 
% for V1 and VC
fig = figure;

ax3 = subplot(2,1,1);
CapacitorActual   = plot(ax3, t, VC_Actual);
title('Actual Capacitor Voltage');
ylabel('Vc (V)');
xlabel('Time');

ax4 = subplot(2,1,2);
Resistor1Actual   = plot(ax4, t, V1_Actual);
title('Actual R1 Voltage');
ylabel('V1 (V)');
xlabel('Time');
