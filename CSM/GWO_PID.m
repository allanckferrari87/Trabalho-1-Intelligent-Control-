clc
clear all
warning('off')
Ne = 3;% Tamanho da dimens�o, s�o os par�metros a serem estimados (Kp, Ki e Kd) 
Np=10;
x = 1*rand(Ne,Np);   % popula��o aleat�ria
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
        [IAE] = malha_fechada_CSM(Kp,Ki,Kd);

        if IAE<Alpha_score 
            Alpha_score=IAE; % Update alpha
            x_alfa=x(:,i);
        end
        
        if IAE>Alpha_score && IAE<Beta_score 
            Beta_score=IAE; % Update beta
            x_beta=x(:,i);
        end
        
        if IAE>Alpha_score && IAE>Beta_score && IAE<Delta_score 
            Delta_score=IAE; % Update delta
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
    ylabel('J')
    Kp = x_alfa(1)
    Ki = x_alfa(2)
    Kd = x_alfa(3)