%Kp=1.064;Ki=0.9985;Kd=0.3971 
Kp=xbest(1);
Ki=xbest(2);
Kd=xbest(3);

Sistema = tf(14620,[1 0])*tf([0.046 1],[(1/0.0297) 1])*tf(1,[(1/(608^2)) (0.422/608) 1]);%

Controlador = Kp + Ki*tf(1,[1 0]) + Kd*tf([1 0],[1]);
sistema_malha_fechada = feedback(Controlador*Sistema,1);

t = 0.001:0.001:1;
sinal_refer = 1*ones(1000,1);
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