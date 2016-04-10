function [output] = oppgave7(sinogram)
%  testMatrix = create16x16filled4x4center(N);
%  matrix = testMatrix
[numDiags,nTheta] = size(sinogram);
N = (numDiags+1)/2;
 dTheta = pi/nTheta; %%=0.5*
 theta = 0:dTheta:(pi-dTheta);
 
 x = zeros(1,N);
 sm = zeros(1,numDiags);
 output = zeros(N,N);
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
        Pos = zeros(2,1);
        for i = 1:N  
            for j = 1:N
                s = sFunc(x(i),y(j),theta(thetaIter));
                
                if s >= sLower && s <= sUpper
                    M = M + 1;
                    Pos(1,M) = i;
                    Pos(2,M) = j;
                end
                
                
            end
          
        end
         if sum(sum(Pos)) ~= 0
            for i = 1:length(Pos(1,:))
             
                    output(Pos(1,i),Pos(2,i)) = output(Pos(1,i),Pos(2,i)) + sinogram(m,thetaIter)/M;
          
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