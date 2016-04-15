%test
N = 256;
im1 = phantom(N);
F = fftshift(fft2(im1));
im2 = ifft2(ifftshift(F));
h = figure;
subplot(1,2,1), imagesc(im1), colormap('gray'), axis square, title('Før transformasjon');
subplot(1,2,2), imagesc(im2), colormap('gray'), axis square, title('Etter transformasjon');
saveTightFigurenr2(h,'TestAvFourier');

figure;
I=phantom(N);
S=fftshift(fft2(I));
L=log(S);
A=abs(L);
imagesc(A), colormap('gray'), axis square;

figure;
B = ifft2(ifftshift(S));
imagesc(B), colormap('gray'), axis square;

