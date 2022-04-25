function R = rot3(axis, angle)
% Rotation matrix given an axis and an angle. 
%     Axis 1 correspond to x-axis
%     Axis 2 correspond to y-axis 
%     Axis 3 correspond to z-axis

c = cos(angle);
s = sin(angle);

switch axis
    case 1
        R = [1, 0, 0; 0, c, -s; 0, s, c];

    case 2
        R = [c, 0, -s;0, 1, 0; s, 0, c];

    case 3
        R = [c, -s, 0; s, c,  0; 0, 0,  1];
end

