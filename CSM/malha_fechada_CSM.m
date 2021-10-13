function [J] = malha_fechada_CSM(Kp,Ki,Kd)



Sistema = tf(14620,[1 0])*tf([0.046 1],[(1/0.0297) 1])*tf(1,[(1/(608^2)) (0.422/608) 1]);%

Controlador = Kp + Ki*tf(1,[1 0]) + Kd*tf([1 0],[1]);
sistema_malha_fechada = feedback(Controlador*Sistema,1);

t = 0.001:0.001:1;
sinal_refer = 1*ones(1000,1);
ye = lsim(sistema_malha_fechada,sinal_refer,t);
erro = sinal_refer - ye;

IAE =trapz(t,abs(erro));
J = sum(abs(sinal_refer - ye.^2));
end
