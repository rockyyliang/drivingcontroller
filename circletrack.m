a=50; % horizontal radius
b=20; % vertical radius
x0=0; % x0,y0 ellipse centre coordinates
y0=b;
t=-pi:0.01:pi;
x=x0+a*cos(t);
y=y0+b*sin(t);

track = zeros(4,length(t));
k = zeros(1,length(t));

track(1,:) = x;
track(2,:) = y;

%calculate curvature and heading
for i = 2:length(t)-1
    k(i) = 2*abs((x(i)-x(i-1)).*(y(i+1)-y(i-1))-(x(i+1)-x(i-1)).*(y(1)-y(i-1))) ./ ...
  sqrt(((x(1)-x(i-1)).^2+(y(1)-y(i-1)).^2)*((x(i+1)-x(i-1)).^2+(y(i+1)-y(i-1)).^2)*((x(i+1)-x(1)).^2+(y(i+1)-y(1)).^2));    
    
    h(i) = atan((x(i+1)-x(i))/(y(i+1)-y(i)));
    
    track(3,i) = k(i);
    track(4,i) = h(i);
end

track = track';

%plot(x,y)
clearvars -except track