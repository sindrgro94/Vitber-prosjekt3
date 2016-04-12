%Oppgave 9 filter
function oppgave9filter(mikkelsen)
%close all

%Normaliserer matrisen for å få frem et ok bilde 
[N,M]=size(mikkelsen);
mellom = ones(N,M).*min(min(mikkelsen));
ny = mikkelsen-mellom;
imageA = ny./max(max(ny));

%figure, imshow(imageA), title('Original')

%Fouriertransformerer bildet
fftA = fft2(imageA);
% figure, imshow(abs(fftshift(fftA)),[0 10]), colormap gray
% title('FFTA shifted')
%kaller den shiftede transformasjonen for fftB
fftB = fftshift(fftA);

%Setter verdier i sentrum lik null
[N,M]=size(fftA);
senter = floor((M)/2)+1;

% vB = 8;
% vL = 120;
% hB = 8;
% hL = 120;
% fftB(1:vL,128-vB/2:128+vB/2) = fftB(1:vL,128-vB/2:128+vB/2)*0.1;
% fftB(256-vL+1:256,128-vB/2:128+vB/2) = fftB(256-vL+1:256,128-vB/2:128+vB/2)*0.1;
% fftB(128-hB/2:128+hB/2,1:hL) = fftB(128-hB/2:128+hB/2,1:hL)*0.1;
% fftB(128-hB/2:128+hB/2,256-hL+1:256) = fftB(128-hB/2:128+hB/2,256-hL+1:256)*0.1;
% filtrert = ifft2(ifftshift(fftB));
%figure, imshow(fftB), title('Litt filter')
% m = 1;
% for i = (1+m):(256-m)
%     for k = -m:1:m
%     fftB(i+k,i+k)= fftB(i+k,i+k)*0;
%     end
% end
% 
% for i = (1+m):(256-m)
%     for k = -m:1:m
%     fftB(i+k,257-i+k)= fftB(i+k,257-i+k)*0;
%     end
% end


%figure, imshow(filtrert), title('Litt filtrert uten normalisering')

k = 1;
for R = 0:1:181
    for i = 1:length(mikkelsen)
        for j = 1:length(mikkelsen)
            if R<15 && R^2 < (i-senter)^2+(j-senter)^2 && (i-senter)^2+(j-senter)^2 <= (R+1)^2
                 fftB(i,j) = fftB(i,j)*k*R; %%%DETTE ER BARE ANTAGELSER TIL FILTER
            elseif R>=15 && R^2 < (i-senter)^2+(j-senter)^2 && (i-senter)^2+(j-senter)^2 <= (R+1)^2
                 fftB(i,j) = fftB(i,j)*k*R; %%%DETTE ER BARE ANTAGELSER TIL FILTER
             end
        end
    end
end


%Transformerer tilbake
filtrertNy = ifft2(ifftshift(fftB));
%figure, imshow(filtrertNy), title('Filtrert uten normalisering')
% [N,M]=size(filtrertNy);
% mellom = ones(N,M).*min(min(filtrertNy));
% ny = filtrertNy-mellom;
% filtrertN = ny./max(max(ny));

%figure, imshow(filtrert), title('Filtrert')
% figure, imshow(fftB), title('Filtrert trans')
figure;
subplot(1,2,2),imshow(filtrertNy), title('Filtrert linneært')
subplot(1,2,1),imshow(imageA), title('Original')
figure;
subplot(1,2,1),imshow(real(fftshift(fftA))), title('Original Fourier')
subplot(1,2,2),imshow(real(fftB)), title('Filtrert Fourier')


end

            
            
            
            
            
            