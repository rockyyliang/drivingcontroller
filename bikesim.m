% simulation of bike model

% select track
%circletrack;
track = [0 0; 5 0; 30 50; 90 50];

% Time
T = 150; % Duration
dt = 0.1;  % Timestep
tvec = 0:dt:T; % Time vector
n = length(tvec); % Number of timesteps

% Vehicle parameters
r = 0.25; % Wheel radius
l = 4; % Distance between axles
deltamax = deg2rad(30);
ks = 1.5; %steering gain
vr = 6; %rear wheel velocity

% state initialization
u = zeros(2,n);
x = zeros(3,n);
delta = zeros(n,1);
trajcount = 1;
% starting location
x(1,1) = -50;
x(2,1) = 20;
x(3,1) = -pi/2;

for i = 2:n
    endp = track(trajcount+1,1:2);
    startp = track(trajcount,1:2);
    trajang = atan2(endp(2)-startp(2), endp(1)-startp(1));
    
    [ect, nextp] = distanceToLineSegment(startp,endp,x(1:2,i-1)');
    
    rawdelta = (mod(trajang-x(3,i-1)+pi, 2*pi)-pi) + atan2(-ks*ect,vr);
    delta(i) = max(-deltamax,min(deltamax,rawdelta));
    u(:,i) = [vr, delta(i)]';
    x(:,i) = bike(x(:,i-1), u(:,i), r, l, dt);
    
    %angle wrap heading
    x(3,i) = mod(x(3,i)+pi, 2*pi) - pi;
    
    %for debugging
    xnow = x(:,i);
    dnow = delta(i);
    
    % Check if we have travelled the distance of the line segment. 
    % If we have, then get the next point
    if (nextp == 1)
        trajcount = trajcount+1;
        if (trajcount == length(track(:,1)))
            break;
        end
    end
    
    %store variables
    trajangS(i) = trajang;
    ectS(i) = ect;
    eS(i) = (mod(trajang-x(3,i)+pi, 2*pi)-pi); 
    
end

plot(track(:,1),track(:,2))
hold on
daspect([1 1 1]);
for i = 1:n
    plot(x(1,i),x(2,i),'go');
    drawnow;
end
legend('track','vehicle path');
hold off
figure;
subplot(3,1,1);
plot(tvec,ectS);title('crosstrack error');
subplot(3,1,2);
plot(tvec,rad2deg(eS));title('heading error');
subplot(3,1,3);
plot(tvec,rad2deg(trajangS));title('trajectory angle');


