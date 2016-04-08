function matrix = oppgave6 (N)
 matrix = create16x16filled4x4center();
 numDiags = 2*N - 1;
 nTheta = 360;
 dTheta = pi/nTheta; %%=0.5*
 theta = [0:dTheta:pi];
 
 
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

