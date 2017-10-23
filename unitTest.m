Acc=150;
acc(1:20) = 0;
acc(21:30) = Acc;
acc(31:40) = -Acc;
acc(41:60) = 0;
acc(61:70) = -Acc;
acc(71:80) = Acc;
acc(81:120) = 0;
acc(121:130) = -Acc;
acc(131:140) = Acc;
acc(141:160) = 0;
acc(161:170) = Acc;
acc(171:180) = -Acc;
acc(181:201) = 0;

[velocity, position]=integrateAcceleration(accelPoints,timeStep);
Tl=0.4.*velocity;