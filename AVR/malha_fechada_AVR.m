function [J] = malha_fechada_AVR(Kp,Ki,Kd)

Ka = 10;
tau_a = 0.1;
Amplifier = tf(Ka,[tau_a 1]);
Ke = 1;
tau_e = 0.4;
Exciter = tf(Ke,[tau_e 1]);
Kg = 1;
tau_g = 1;
Generator = tf(Kg,[tau_g 1]);
Ks = 1;
tau_s = 0.01;
Sensor = tf(Ks,[tau_s 1]);

% Sistema = feedback(Amplifier*Exciter*Generator,Sensor);%

Controlador = Kp + Ki*tf(1,[1 0]) + Kd*tf([1 0],[1]);
% sistema_malha_fechada = feedback(Controlador*Sistema,1);
sistema_malha_fechada = feedback(Controlador*Amplifier*Exciter*Generator,Sensor);

t = 0.01:0.01:4;
sinal_refer = 1*ones(400,1);
ye = lsim(sistema_malha_fechada,sinal_refer,t);
erro = sinal_refer - ye;

Vs = lsim(Sensor ,ye,t);
% ISE = sum(abs(erro).^2);
% IAE = sum(abs(erro));
J = sum(abs(sinal_refer - Vs.^2));
end
