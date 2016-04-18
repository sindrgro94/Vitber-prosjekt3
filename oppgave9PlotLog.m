%her lager vi filteret
function oppgave9PlotLog(fantom)
close all
[M,N] = size(fantom);
skarp = phantom(M);
%Normaliserer matrisen for ? f? frem et ok bilde 
mellom = ones(N,M).*min(min(fantom));
ny = fantom-mellom;
fantom = ny./max(max(ny));

mellom = ones(N,M).*min(min(skarp));
ny = skarp-mellom;
skarp = ny./max(max(ny));

% figure, imshow(abs(fantom)), colormap gray
% title('Projeksjon')

F = fftshift(fft2(double(skarp)));
G = fftshift(fft2(double(fantom)));

Flog = log(abs(F));
Glog = log(abs(G));
h = figure;
subplot(1,2,1), imagesc(Flog,[0,5]), colormap('gray'), title('Original'), axis square;
subplot(1,2,2), imagesc(Glog,[0,5]), colormap('gray'), title('Projeksjon'),axis square;
saveTightFigurenr2(h,'log');


% %for ? teste om den fungere
% diff = Flog-Glog;
% figure, imshow(diff,[0 5]), colormap gray;

%finner A som et filter
% filter = zeros(N,N);
% for i = 1:N
%     for j = 1:N
%         filter(i,j)= F(i,j)/G(i,j);
%     end
% end

% 
figure;
[X,Y] = meshgrid(1:N,1:N);
surf(X,Y,abs(G./F))
zlim([0,1000]);

H = zeros(N,N);

for i = 1:N
    for j = 1:N
        H(i,j) = sqrt((127-i)^2+(127-j)^2)*G(i,j);
    end
end


figure;
subplot(2,2,1), imshow(F), title('Original');
subplot(2,2,2), imshow(G), title('Projeksjon');
subplot(2,2,3), imshow(H), title('Filtrert');

imageC = ifft2(ifftshift(H));


figure;
subplot(1,2,1), imagesc(real(skarp),[0,1]), axis square ,colormap gray, title('Original')
subplot(1,2,2), imagesc(real(imageC),[0.5,4]), axis square, colormap gray, title('Filtrert')






