%Oppgave 9 filter
function oppgave9filter(tilbakeProjeksjon)
%close all

%Normaliserer matrisen for å få frem et ok bilde 
[N,M]=size(tilbakeProjeksjon);
mellom = ones(N,M).*min(min(tilbakeProjeksjon));
ny = tilbakeProjeksjon-mellom;
imageA = ny./max(max(ny));

%Fouriertransformerer bildet
fftA = fft2(imageA);
%kaller den shiftede transformasjonen for fftB
fftB = fftshift(fftA);

%Setter verdier i sentrum lik null
[N,M]=size(fftA);
senter = floor((M)/2)+1;

k = 1;
step = 1/sqrt(2)-0.01;
for R = 0:step:181
    for i = 1:length(tilbakeProjeksjon)
        for j = 1:length(tilbakeProjeksjon)
            if R^2 < (i-senter)^2+(j-senter)^2 && (i-senter)^2+(j-senter)^2 <= (R+step)^2
                 fftB(i,j) = fftB(i,j)*k*(R); %%%DETTE ER BARE ANTAGELSER TIL FILTER
             end
        end
    end
end


%Transformerer tilbake
filtrertNy = ifft2(ifftshift(fftB));

%Illustrerer resultatet
figure;
subplot(1,2,2),imagesc((filtrertNy),[0,0.75]),axis square, colormap gray, title('Filtrert linneært')
subplot(1,2,1),imagesc(imageA), axis square, colormap gray,title('Original')
figure;
subplot(1,2,1),imagesc(real(fftshift(fftA))),axis square, colormap gray, title('Original Fourier')
subplot(1,2,2),imagesc(real(fftB)),axis square, colormap gray, title('Filtrert Fourier')


end

            
            
            
            
            
            