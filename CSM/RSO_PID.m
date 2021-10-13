clc
clear all
warning('off')
Np=10;
Ne=3;
Positions = 1*rand(Ne,Np);  % população aleatória%reduzir espaço de busca
Max_iterations = 100;
fmin = inf;
Score =inf;
l=0;
x = 1;
y = 2;
R = floor((y-x).*rand(1,1) + x);
Upper_bound=10;
Lower_bound=-10;
    k=1;
    while (k < Max_iterations ) 
        
    
    for i=1:size(Positions,2)  
        Kp = Positions(1,i);
        Ki = Positions(2,i);
        Kd = Positions(3,i);
        [J] = malha_fechada_CSM(Kp,Ki,Kd);

        if J<Score 
            Score=J; 
            Position=Positions(:,i);
        end
        
    end
    A=R-l*((R)/Max_iterations); 
    
    for i=1:size(Positions,2)
        for j=1:size(Positions,1)     
            C=2*rand();          
            P_vec=A*Positions(j,i)+abs(C*((Position(j)-Positions(j,i))));                   
            P_final=Position(j)-P_vec;
            Positions(j,i)=P_final;
            
        end
    end    
    k=k+1
    Score
    E(k) = Score;
    end
    xbest = Position;
    k=1:100;
    plot(k,E)
    xlabel('iterations')
    ylabel('cost function J')
    Kp = xbest(1)
    Ki = xbest(2)
    Kd = xbest(3)