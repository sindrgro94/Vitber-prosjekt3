function [output,t] = oppgave7(sinogram,originalImage)
%  testMatrix = create16x16filled4x4center(N);
%  matrix = testMatrix
tic
[numDiags,nTheta] = size(sinogram);
N = (numDiags+1)/2;
 dTheta = pi/nTheta; %%=0.5*
 theta = 0:dTheta:(pi-dTheta);
 name = sprintf('posm%0.f.mat',N);
 positionLoaded = 0;
 
 if exist(name)
     load(name); %innholder matrisene posm og Mval
     positionLoaded = 1;
 end
 
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

     
 
 if positionLoaded == 1
    for thetaIter = 1:nTheta
        for m = 1:numDiags
            for i = 1:N  
                if posm(2*m-1,thetaIter,i) ~=0
                    output(posm(2*m-1,thetaIter,i),posm(2*m,thetaIter,i)) = output(posm(2*m-1,thetaIter,i),posm(2*m,thetaIter,i)) + sinogram(m,thetaIter)/Mval(m,thetaIter);
                end   
            end
        end
    end
    
    output = output./(sum(sum(output)));
    t = toc
    return
 
 else
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
 end
 
 output = output./(sum(sum(output))); %%normaliser slik at sum_ij(f_ij) = 1
         
 
 figure;
 if nargin == 2;
 subplot(1,2,1);
 end
 imagesc(output);
%imagesc(im1);
colormap('gray');
axis square;
drawnow;

if nargin == 2;
    subplot(1,2,2);
    imagesc(originalImage);
    colormap('gray');
    axis square;
    drawnow;
end
end

function u =  sFunc(x,y,theta)
    u = x*cos(theta)+y*sin(theta);
end