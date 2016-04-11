%Oppgave 9
%denne skal ta inn en sinogram og gjøre det skarpere

figure;
I=imread('directBackProjection01.pdf');
S=fftshift(fft2(I));
L=log(S);
A=abs(L);
imagesc(A), colormap('gray'), axis square;

figure;
B = ifft2(ifftshift(S));
imagesc(B), colormap('gray'), axis square;