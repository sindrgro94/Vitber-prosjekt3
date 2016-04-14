function [output] = oppgave7(sinogram,originalImage)

[numDiags,nTheta] = size(sinogram);
N = (numDiags+1)/2;
name = sprintf('posmN%0.fnTheta%.0f.mat',N,nTheta);
output = zeros(N,N);

if exist(['Tilbakeprojeksjonsmatriser\' name],'file') %sjekk om fila med data om projeksjonslinjene finnes
     load(name); % -- ! VIKTIG ! -- innholder matrisene posm og Mval
else %%ellers lag ny fil
     identifySCoordsAndSavePosmAndMval(N,nTheta); %%definert nederst i denne filen
     load(name); %innholder matrisene posm og Mval
end

for thetaIter = 1:nTheta %% plass?r de utsmurte punktene langs projeksjonslinjene
    for m = 1:numDiags
        for i = 1:N  
            if posm(2*m-1,thetaIter,i) ~=0
                output(posm(2*m-1,thetaIter,i),posm(2*m,thetaIter,i)) = output(posm(2*m-1,thetaIter,i),posm(2*m,thetaIter,i)) + sinogram(m,thetaIter)/Mval(m,thetaIter);
            end   
        end
    end
end
    
    output = output./(sum(sum(output)));  %%normaliser slik at sum_ij(f_ij) = 1
    
   
figure; %%start plottingen
if nargin == 2; %%dersom originalbildet er inkludert, lag subplot, ellers plot vanlig.
 subplot(1,2,1);
end
 imagesc(output);
%imagesc(im1);
colormap('gray');
axis square;
drawnow;

if nargin == 2; %%plot originalbildet DERSOM det er to argumenter inn i hovedfunksjonen
subplot(1,2,2);
imagesc(originalImage);
colormap('gray');
axis square;
drawnow;
end
%%regner ut rms-avvik per piksel.
rms = CalculateRMSvalue(originalImage,output);
fprintf('RMS-avviket per piksel er:\n');
disp(rms);
end

function u =  sFunc(x,y,theta) %%regner ut s_ij
    u = x*cos(theta)+y*sin(theta);
end

function identifySCoordsAndSavePosmAndMval(N,nTheta)
 %denne funksjonen avgj?r hvilke punkter (i,j) <-> (x,y) som ligger langs
 %en gitt projekson P(s_m,Theta_n)
 numDiags = 2*N-1;
 dTheta = pi/nTheta; %%steg for Theta (0.5 deg for nTheta = 180)
 theta = 0:dTheta:(pi-dTheta); %%initializer theta-arrayen
 
 posm = zeros(2*numDiags,nTheta, N);
 %%holder koordinatparene (x_i,y_i) i henholdvis (2*i-1,2*i) for gitt
 %%Theta_n og S_i med tilh?rende telling for alle punkter langs
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
        Mval(m,thetaIter) = M; %%etter telling, finn M for p(s_m,Theta_n);
        
    end

 end
     name = sprintf('posmN%.0fnTheta%0.f.mat',N,nTheta);
    save(['Tilbakeprojeksjonsmatriser\' name] ,'posm','Mval'); %%lagre fila med info om alle p(s_m,theta_n)
                                                        %i mappa
                                                        %'Projeksonsmatriser'
end
function rms = CalculateRMSvalue(originalImage,backProjectedImage)
    if size(originalImage) == size(backProjectedImage)
        originalImage = originalImage/sum(sum(originalImage));
        rms = 0;
        N = length(originalImage);
        for x=1:N
            for y = 1:N;
                rms = rms+(backProjectedImage(x,y)-originalImage(x,y))^2;
            end
        end
        rms = sqrt(rms)/N^2;
    else
        rms = -1;
    end
end