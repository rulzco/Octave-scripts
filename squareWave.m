%%Script to generate a square wave with frequency, duty cycle and period of 2pi%%

clc; clear all;
f_burst = 5; %frequency Hz
T = 1.0; % total time s
dt = 1e-3; % Time step s
duty = 0.75; % Duty 
cycles = T * f_burst; % number of cycles per period
n = 0:dt:T;
t = ones(1,length(n));
t_t = 1 / f_burst; % time of each cycle
t_on = duty / f_burst; % on time per cylce
t_off = 1 / f_burst * (1- duty); % off time per cylce
temp = 0; 
t_on_f = t_on * 1000; t_t_f = t_t * 1000; 
for i=1 : ceil(cycles);
  t(temp +  t_on_f +1:i * t_t_f) = 0; % apply zero in range t[n-t_on:n-tt]
  temp = temp +  t_t_f; % increase the base time
endfor
figure(1)
plot(n,t(1:length(n)),'g');ylim([-1 1.5]);

%% Alternative based on counting time steps
k = 0;
time_step = 0
x = zeros(length(n));
for i=1 : length(n);
  time_step = time_step + 1*dt;
  k = k + 1; % count until reach time on
  if k < t_on_f 
    x(i)=1;
  elseif k < t_t_f 
    x(i)=0;
  elseif k == t_t_f  
    k = 0; % reset counter
  end
  
end
figure(2)
plot(n,x(1:length(n)));ylim([-1 1.5]);