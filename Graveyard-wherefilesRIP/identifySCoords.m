function identifySCoords(N,nTheta)

 numDiags = 2*N-1;
 dTheta = pi/nTheta; %%=0.5*
 theta = 0:dTheta:(pi-dTheta);
 
 posm = zeros(2*numDiags,nTheta, N);
 Mval = zeros(numDiags,nTheta);
 x = zeros(1,N);
 sm = zeros(1,numDiags);
 y = x;
 a = 1;
 for u = 1: N
     x(u) = ((2*u-N-1)/2)*a;
     y(u) = ((2*u-N-1)/2)*a;
 end
 

 for m = 1:numDiags
     sm(m) = -(N-m)*a/sqrt(2);
 end
 
 for thetaIter = 1:nTheta
     disp(thetaIter)
    for m = 1:numDiags
        sUpper = sm(m)+a/(2*sqrt(2));
        sLower = sm(m)-a/(2*sqrt(2));
        M = 0;
        for i = 1:N  
            for j = 1:N
                s = sFunc(x(i),y(j),theta(thetaIter));
                
                if s >= sLower && s <= sUpper
                    M = M + 1;
                    posm(2*m-1,thetaIter,M) = i;
                    posm(2*m,thetaIter,M) = j;
                end
                
                
            end
          
        end
        Mval(m,thetaIter) = M;
        
    end

 end
     name = sprintf('posm%.0f.mat',N);
    save(name,'posm','Mval');
end
 
 
 function u =  sFunc(x,y,theta)
    u = x*cos(theta)+y*sin(theta);
end
 
