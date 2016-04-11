%For å få en sirkel i sentrum
%Oppgave 9
%denne skal ta inn en sinogram og gjøre det skarpere
function oppgave9hoypass(mikkelsen)

close all
%Normaliserer matrisen for å få frem et ok bilde 
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
R = 100;
senter = floor((M)/2)+1;

for i = 1:length(mikkelsen)
    for j = 1:length(mikkelsen)
        if (i-senter)^2+(j-senter)^2 > R^2
            fftB(i,j)=fftB(i,j)*0;
        end
    end
end

%Viser transformasjonen med verdier i sentrum lik null
figure, imshow(abs(fftB),[0 10]), colormap gray
title('FFTB')      

%Image C er fftB transformert tilbake og skal derfor etter normalisering
%Ligne på orginalbildet
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

