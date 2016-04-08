function oppgave6 (matrix, N)
 testMatrix = create16x16filled4x4center(N);
 matrix = testMatrix;
 numDiags = 2*N - 1;
 nTheta = 360;
 dTheta = pi/nTheta; %%=0.5*
 theta = 0:dTheta:(pi);
 
 
 x = zeros(1,N);
 sm = zeros(1,numDiags);
 projMat = zeros(numDiags,length(theta));
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
    for m = 1:numDiags
        sUpper = sm(m)+a/2;
        sLower = sm(m)-a/2;
        for i = 1:N
            for j = 1:N
            s = sFunc(x(i),y(j),theta(thetaIter));
            if s > sLower && s < sUpper
                projMat(m,thetaIter) = projMat(m,thetaIter) + matrix(i,j);
            end
            
            end
        end
    end
 end
 
 
         
 
 figure;
 imagesc(projMat);
%imagesc(im1);
colormap('gray');
axis square;
drawnow;
end


function u =  sFunc(x,y,theta)
    u = x*cos(theta)+y*sin(theta);
end
