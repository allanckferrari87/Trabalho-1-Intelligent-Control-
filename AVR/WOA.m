warning('off')
%% Algoritmo WOA
Np=10;
Ne=3;
x = 20*rand(Ne,Np); % população aleatória
Score =inf;
iter = 100;
    k=1;
    while (k <= iter) 
    a = 2 - (2*(k/iter));
    a2=-1+k*((-1)/iter);
    
    for i=1:Np  
    Kp = x(1,i);
    Ki = x(2,i);
    Kd = x(3,i);
    [ISE] = malha_fechada_AVR(Kp,Ki,Kd);

        if ISE<Score 
            Score=ISE; 
            xbest=x(:,i);
        end
        
    end
    
    
    for j = 1:Np    
        r1 = rand();
        r2 = rand();
        A=2*a*r1-a;
        C=2*r2;    
        b=1;              
        l=(a2-1)*rand+1;
        p = rand();
            for i=1:Ne
                if p < 0.5
                    if abs(A) < 1
                    D = abs(C*xbest(i,1)-x(i,j));  
                    x(i,j)=xbest(i,1)-A*D;
                    elseif abs(A) >= 1
                    r=randperm(Np,1);
                    D = abs(C*x(i,r)-x(i,j));  
                    x(i,j)=x(i,r)-A*D;
                    end
                elseif p >= 0.5
                    D = abs(xbest(i,1)-x(i,j));
                    x(i,j) = D*exp(b*l)*cos(2*pi*l)+xbest(i,1);
                end
            end
    end

    k=k+1;
    Score
    E(k) = Score;
    end
    xbest
    