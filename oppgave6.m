function sinogram = oppgave6 (matrix,saveName)
% matrix [N x N matrix] er bildet som skal scannes til et sinogram
% saveName [string]  (optional) spesifiserer hva navnet p� .txt-filen skal v�re
% (OBS! Ikke inkluder '.txt' i saveName, KUN en streng med navnet du
% �nsker.

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
        sUpper = sm(m)+a/(2*sqrt(2));
        sLower = sm(m)-a/(2*sqrt(2));
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

if nargin == 2;
vname=@(x) inputname(1);
sinogramString = vname(sinogram);
saveNameTxt = sprintf([saveName '.txt']);
save (['sinogram\' saveNameTxt],sinogramString, '-ascii')  ;
end
end


function u =  sFunc(x,y,theta)
    u = x*cos(theta)+y*sin(theta);
end

function identifySCoordsAndSavePosmAndMval(N,nTheta)
 %denne funksjonen avgj�r hvilke punkter (i,j) <-> (x,y) som ligger langs
 %en gitt projekson P(s_m,Theta_n)
 numDiags = 2*N-1;
 dTheta = pi/nTheta; %%steg for Theta (0.5 deg for nTheta = 180)
 theta = 0:dTheta:(pi-dTheta); %%initializer theta-arrayen
 
 posm = zeros(2*numDiags,nTheta, N);
 %%holder koordinatparene (x_i,y_i) i henholdvis (2*i-1,2*i) for gitt
 %%Theta_n og S_i med tilh�rende telling for alle punkter langs
 %%p(s_i,Theta_N)
 Mval = zeros(numDiags,nTheta); %%holder M-verdiene for gitt m, Theta_n
 x = zeros(1,N);
 sm = zeros(1,numDiags);
 y = x;
 a = 1;
 for u = 1: N
     x(u) = ((2*u-N-1)/2)*a; %%definer alle punkter x_u
     y(u) = ((2*u-N-1)/2)*a; %%definer alle punkter y_u
 end
 

 for m = 1:numDiags
     sm(m) = -(N-m)*a/sqrt(2); %%definer alle s_m
 end
 
 for thetaIter = 1:nTheta
     fprintf('Scanning... Theta = %.0f/%.0f deg\n',thetaIter,nTheta);
    for m = 1:numDiags
        sUpper = sm(m)+a/(2*sqrt(2)); %%sjekker avstanden mellom s(x,y)
        sLower = sm(m)-a/(2*sqrt(2)); %%og s_m
        M = 0;
        for i = 1:N  
            for j = 1:N
                s = sFunc(x(i),y(j),theta(thetaIter));
                
                if s >= sLower && s <= sUpper %%dersom s(x,y) er innafor
                    M = M + 1;                %%grensene
                    posm(2*m-1,thetaIter,M) = i;
                    posm(2*m,thetaIter,M) = j;
                end
                
                
            end
          
        end
        
    end

 end
     name = sprintf('posmN%.0fnTheta%0.f.mat',N,nTheta);
    save(['Projeksjonsmatriser\' name] ,'posm','Mval'); %%lagre fila med info om alle p(s_m,theta_n)
                                                        %i mappa
                                                        %'Projeksonsmatriser'
end
