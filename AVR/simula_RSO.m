%Kp=1.064;Ki=0.9985;Kd=0.3971 
Kp=xbest(1);
Ki=xbest(2);
Kd=xbest(3);
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
plot(t,ye)
hold on
plot(t,sinal_refer)
ylabel('Amplitude');
xlabel('Time seconds')
legend('Reference signal','PID-RSO')
erro = sinal_refer - ye;
ISE =trapz(t,erro.^2)
IAE =trapz(t,abs(erro))
ITAE = trapz(t,t'.*abs(erro))
ITSE =trapz(t,t'.*erro.^2)