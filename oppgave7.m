function [output] = oppgave7(sinogram)
%  testMatrix = create16x16filled4x4center(N);
%  matrix = testMatrix
[numDiags,nTheta] = size(sinogram);
M = (numDiags+1)/2;
 dTheta = pi/nTheta; %%=0.5*
 theta = 0:dTheta:(pi-dTheta);
 
 
 x = zeros(1,M);
 sm = zeros(1,numDiags);
 output = zeros(M,M);
 y = x;
 a = 1;
 for u = 1: M
     x(u) = ((2*u-M-1)/2)*a;
     y(u) = ((2*u-M-1)/2)*a;
 end
 

 for m = 1:numDiags
     sm(m) = -(M-m)*a/sqrt(2);
 end
 

 for thetaIter = 1:nTheta
     disp(thetaIter)
    for m = 1:numDiags
        sUpper = sm(m)+a/sqrt(2);
        sLower = sm(m)-a/sqrt(2);
      
        for i = 1:M  
            for j = 1:M
                s = sFunc(x(i),y(j),theta(thetaIter));
                
                if s >= sLower && s <= sUpper
                    output(i,j) = output(i,j) + sinogram(m,thetaIter);
                end
                
                
            end
          
        end
    end
 end
 
 output = output./(sum(sum(output))); %%normaliser slik at sum_ij(f_ij) = 1
         
 
 figure;
 imagesc(output);
%imagesc(im1);
colormap('gray');
axis square;
drawnow;
end


function u =  sFunc(x,y,theta)
    u = x*cos(theta)+y*sin(theta);
end