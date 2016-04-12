%her lager vi filteret
function filter = oppgave9MakeFilter(fantom)

close all
[M,N] = size(fantom);
skarp = phantom(M);
%Normaliserer matrisen for å få frem et ok bilde 
mellom = ones(N,M).*min(min(fantom));
ny = fantom-mellom;
fantom = ny./max(max(ny));

mellom = ones(N,M).*min(min(skarp));
ny = skarp-mellom;
skarp = ny./max(max(ny));
figure, imshow(abs(skarp)), colormap gray
title('Skarp')
figure, imshow(abs(fantom)), colormap gray
title('Projeksjon')

F = fftshift(fft2(double(skarp)));
G = fftshift(fft2(double(fantom)));

Flog = log(abs(F));
Glog = log(abs(G));
figure;
subplot(1,2,1), imagesc(Flog,[-2,10]), axis square, colorbar, title('skarp');
subplot(1,2,2), imagesc(Glog,[-2,10]), axis square, colorbar, title('fantom');

% %for å teste om den fungere
% diff = Flog-Glog;
% figure, imshow(diff,[0 5]), colormap gray;

%finner A som et filter
filter = zeros(N,N);
for i = 1:N
    for j = 1:N
        filter(i,j)= F(i,j)/G(i,j);
    end
end

differanse = (F(128,:)-G(128,:));
figure;
plot(1:256,real(F(128,:)-G(128,:)))

H = zeros(N,N);
for i = 1:N
    for j = 1:N
        H(i,j)= filter(i,j)*G(i,j);
    end
end

imageC = ifft2(ifftshift(H));
figure, imshow(abs(imageC)), colormap gray
title('Image C  uten normalisering')





