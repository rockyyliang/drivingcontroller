function xcur = bike(xprev, u, r, l, dt)
%bicycle model
%states = [x, y, theta]'
%inputs = [w, delta]' 

%A = 3x3 identity

%wheel linear speed
vr = u(1)*r;
B = [vr*cos(xprev(3));
     vr*sin(xprev(3));
     vr*tan(u(2))/l];
 
xcur = xprev + dt*B;

