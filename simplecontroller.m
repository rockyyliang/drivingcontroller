function [v,delta] = simplecontroller(xcur, track)
%SIMPLECONTROLLER Summary of this function goes here

kp = 2;

v = 10;



delta = kp*xcur(1)-track(1,:);


end

