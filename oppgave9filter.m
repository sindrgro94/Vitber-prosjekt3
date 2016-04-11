%Oppgave 9 filter
function oppgave9filter(mikkelsen)
close all
%Normaliserer matrisen for � f� frem et ok bilde 
[N,M]=size(mikkelsen);
mellom = ones(N,M).*min(min(mikkelsen));
ny = mikkelsen-mellom;
sexyMikkelsen = ny./max(max(ny));
imageA = sexyMikkelsen;
figure, imshow(imageA)
title('Image A - Original')

%Fouriertransformerer bildet
fftA = fft2(double(imageA));
figure, imshow(abs(fftshift(fftA)),[0 10]), colormap gray
title('FFTA shifted')
%kaller den shiftede transformasjonen for fftB
fftB = fftshift(fftA);

%Setter verdier i sentrum lik null
[N,M]=size(fftA);
senter = floor((M)/2)+1;

for R = 0:1:180
    for i = 1:length(mikkelsen)
        for j = 1:length(mikkelsen)
            if R^2 < (i-senter)^2+(j-senter)^2 && (i-senter)^2+(j-senter)^2 <= (R+1)^2
                fftB(i,j) = fftB(i,j)*(R+0.1); %%%DETTE ER BARE ANTAGELSER TIL FILTER
            end
        end
    end
end

%Viser transformasjonen med verdier i sentrum lik null
figure, imshow(abs(fftB),[0 10]), colormap gray
title('FFTB')      

%Image C er fftB transformert tilbake og skal derfor etter normalisering
%Ligne p� orginalbildet
imageC = ifft2(ifftshift(fftB));
figure, imshow(abs(imageC)), colormap gray
title('Image C  uten normalisering')

%Normaliserer imageC
[N,M]=size(imageC);
mellom1 = ones(N,M).*min(min(imageC));
ny1 = imageC-mellom1;
sexyImageC = ny1./max(max(ny1));

figure, imshow(real(sexyImageC)), colormap gray
title('Image C  med normalisering')
end

            
            
            
            
            
            