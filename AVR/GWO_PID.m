clc
clear all
warning('off')
Ne = 3;% Tamanho da dimensão, são os parâmetros a serem estimados (Kp, Ki e Kd) 
Np=10;
x = 10*rand(Ne,Np);   % população aleatória
x_alfa=zeros(1,Np);
Alpha_score=inf;
x_beta=zeros(1,Np);
Beta_score=inf;
x_delta=zeros(1,Np);
Delta_score=inf; 
iter = 100;
    k=0;
    while (k < iter) 
    
        for i=1:Np         
      
        Kp = x(1,i);
        Ki = x(2,i);
        Kd = x(3,i);
        [J] = malha_fechada_AVR(Kp,Ki,Kd);

        if J<Alpha_score 
            Alpha_score=J; % Update alpha
            x_alfa=x(:,i);
        end
        
        if J>Alpha_score && J<Beta_score 
            Beta_score=J; % Update beta
            x_beta=x(:,i);
        end
        
        if J>Alpha_score && J>Beta_score && J<Delta_score 
            Delta_score=J; % Update delta
            x_delta=x(:,i);
        end
        
        
        
        end
            
    a = 2 - (2*(k/iter));
     
    Aa = a*(2*rand(Ne,Np)-1);
    Ab = a*(2*rand(Ne,Np)-1);
    Ac = a*(2*rand(Ne,Np)-1);
    Ca = 2*rand(Ne,Np);
    Cb = 2*rand(Ne,Np);
    Cc = 2*rand(Ne,Np);
    Da = abs((x_alfa(1:Ne,1)*ones(1,Np)).*Ca - x);
    Db = abs((x_beta(1:Ne,1)*ones(1,Np)).*Cb - x);
    Dc = abs((x_delta(1:Ne,1)*ones(1,Np)).*Cc - x);
    
    X1 = x_alfa(1:Ne,1)*ones(1,Np) - Aa.*Da;
    X2 = x_beta(1:Ne,1)*ones(1,Np) - Ab.*Db;
    X3 = x_delta(1:Ne,1)*ones(1,Np) - Ac.*Dc;
    
    x = ((X1 + X2 + X3)/3);
    Alpha_score
    k=k+1
    E(k) = Alpha_score;
    end
    xbest = x_alfa;
    ep = k;
    k=1:100;
    plot(k,E)
    xlabel('iterations')
    ylabel('cost function J')
    Kp = x_alfa(1)
    Ki = x_alfa(2)
    Kd = x_alfa(3)