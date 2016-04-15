%Oppgave 9
%denne skal ta inn en sinogram og gjøre det skarpere
close all
% figure;
% I=imread('sexyMikkelsen.pbm');
% S=fftshift(fft2(I));
% L=log2(S);
% A=abs(L);
% imagesc(A), colormap('gray'), axis square;
% 
% figure;
% B = ifft2(ifftshift(S));
% imagesc(B), colormap('gray'), axis square;

%Normaliserer matrisen for å få frem et ok bilde 
[N,M]=size(mikkelsen);
mellom = ones(N,M).*min(min(mikkelsen));
ny = mikkelsen-mellom;
sexyMikkelsen = ny./max(max(ny));
imageA = sexyMikkelsen;
figure, imshow(imageA)
title('Image A - Greek Church')

%Fouriertransformerer bildet
fftA = fft2(double(imageA));
figure, imshow(abs(fftshift(fftA)),[0 10]), colormap gray
title('Image A FFT2 Magnitude')
%kaller den shiftede transformasjonen for fftB
fftB = fftshift(fftA);

%Setter verdier i sentrum lik null
[N,M]=size(fftA);
R = 100;
senter = floor((M)/2);
for i = -R:1:R
    for j = -R:1:R
        fftB(senter+j,senter+i)=fftB(senter+j,senter+i).*0.5;
    end
end

%Viser transformasjonen med verdier i sentrum lik null
figure, imshow(abs(fftB),[0 10]), colormap gray
title('Image A FFT2 Magnitude')      

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


for i = 0:0.1:R
    for j = 0:0.01:2*pi
        x = floor(i*cos(j));
        y = floor(i*sin(j));
        fftBHoy(senter+x,senter+y)=fftB(senter+x,senter+y);
    end
end 








