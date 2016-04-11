%test
N = 256;
im1 = phantom(N);
F = fftshift(fft2(im1));
im2 = ifft2(ifftshift(F));
figure;
subplot(1,2,1), imagesc(im1), colormap('gray'), axis square;
subplot(1,2,2), imagesc(im2), colormap('gray'), axis square;
title('Like bilder')
