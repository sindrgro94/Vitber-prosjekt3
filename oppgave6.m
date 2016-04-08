function matrix = oppgave6 (N)
 matrix = create16x16filled4x4center();
 numDiags = 2*N - 1;
 nTheta = 360;
 dTheta = pi/nTheta; %%=0.5*
 theta = [0:dTheta:pi];
 
 im = zeros(N,N);
 x = zeros(1,N);
 s = zeros(N,N);
 sm = zeros(1,2*N-1);
 y = x;
 a = 1;
 for u = 1: N
     x(u) = ((2*u-N-1)/2)*a;
     y(u) = ((2*u-N-1)/2)*a;
 end
 
 for m = 1:(2*N-1)
     sm(m) = -(N-m)*a/sqrt(2)
 end
 
 for thetaIter = theta(1):dTheta:theta(end)
    for i = 1:N
        for j = 1:N
        im(i,j)=x(i)*cos(thetaIter) + y(j)*sin(thetaIter);
        end
    end
 end
 
 
         
 
 figure;
 imagesc(matrix);
%imagesc(im1);
colormap('gray');
axis square;
drawnow;
end

function x =  create16x16filled4x4center()
    x = zeros(16,16);
    L = 7:10;
    for i = L
        for j = L
            x(i,j) = 1;
        end
    end
end

