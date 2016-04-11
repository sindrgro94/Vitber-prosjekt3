function sinogram = oppgave6_muligRaskere (matrix)
  %testMatrix = create16x16filled4x4center(16);
  %matrix = testMatrix;
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
        for i = 1:N
            for j = 1:N
                Sxy = sFunc(x(i),y(j),theta(thetaIter));
                s = findCorrectS(sm,Sxy,a);
                sinogram(s(1),thetaIter) = sinogram(s(1),thetaIter) + matrix(i,j);
                if length(s)>1
                    sinogram(s(2),thetaIter) = sinogram(s(2),thetaIter) + matrix(i,j);
                end
            end
        end
 end
 
 
         
 
 figure;
 imagesc(sinogram);
%imagesc(im1);
colormap('gray');
axis square;
drawnow;
end


function u =  sFunc(x,y,theta)
    u = x*cos(theta)+y*sin(theta);
end

function s = findCorrectS(Sm, Sxy, a)
    counter = 1;
    for m = 1:length(Sm)
        sUpper = Sm(m)+a/(2*sqrt(2));
        sLower = Sm(m)-a/(2*sqrt(2));
        if Sxy<=sUpper && Sxy>=sLower
            s(counter) = m;
            counter = counter + 1;
        end
    end
end