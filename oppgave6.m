function sinogram = oppgave6 (matrix)
%  testMatrix = create16x16filled4x4center(N);
%  matrix = testMatrix
 N = length(matrix);
 numDiags = 2*N - 1;
 nTheta = 180;
 dTheta = pi/nTheta; %%=0.5*
 theta = 0:dTheta:(pi-dTheta);
 
 
 x = zeros(1,N);
 sm = zeros(1,numDiags);
 sinogram = zeros(numDiags,length(theta));
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
        sUpper = sm(m)+a/sqrt(2);
        sLower = sm(m)-a/sqrt(2);
        for i = 1:N
            for j = 1:N
            s = sFunc(x(i),y(j),theta(thetaIter));
            if s >= sLower && s <= sUpper
                sinogram(m,thetaIter) = sinogram(m,thetaIter) + matrix(i,j);
            end
            
            end
        end
    end
 end
 
 
         
 
%  figure;
%  imagesc(sinogram);
% %imagesc(im1);
% colormap('gray');
% axis square;
% drawnow;
end


function u =  sFunc(x,y,theta)
    u = x*cos(theta)+y*sin(theta);
end
