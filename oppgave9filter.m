%Oppgave 9 filter
function oppgave9filter(mikkelsen)
%close all
%fantom = load('phantom256backprojected.mat');
%filter = oppgave9MakeFilter(fantom.phantom256);
close all
%Normaliserer matrisen for � f� frem et ok bilde 
[N,M]=size(mikkelsen);
mellom = ones(N,M).*min(min(mikkelsen));
ny = mikkelsen-mellom;
imageA = ny./max(max(ny));

%figure, imshow(imageA), title('Original')

%Fouriertransformerer bildet
fftA = fft2(imageA);
figure, imshow(abs(fftshift(fftA)),[0 10]), colormap gray
title('FFTA shifted')
%kaller den shiftede transformasjonen for fftB
fftB = fftshift(fftA);

%Setter verdier i sentrum lik null
[N,M]=size(fftA);
senter = floor((M)/2)+1;

vB = 4;
vL = 50;
hB = 4;
hL = 50;
% fftB(1:vL,128-vB/2:128+vB/2) = fftB(1:vL,128-vB/2:128+vB/2)*0;
% fftB(256-vL+1:256,128-vB/2:128+vB/2) = fftB(256-vL+1:256,128-vB/2:128+vB/2)*0;
% fftB(128-hB/2:128+hB/2,1:hL) = fftB(128-hB/2:128+hB/2,1:hL)*0;
% fftB(128-hB/2:128+hB/2,256-hL+1:256) = fftB(128-hB/2:128+hB/2,256-hL+1:256)*0;
filtrert = ifft2(ifftshift(fftB));
figure, imshow(fftB), title('Litt filter')

%figure, imshow(filtrert), title('Litt filtrert uten normalisering')


for R = 0:1:181
    for i = 1:length(mikkelsen)
        for j = 1:length(mikkelsen)
            if R^2 < (i-senter)^2+(j-senter)^2 && (i-senter)^2+(j-senter)^2 <= (R+1)^2
                 fftB(i,j) = fftB(i,j)*1.5*R; %%%DETTE ER BARE ANTAGELSER TIL FILTER
             end
        end
    end
end


% H = zeros(N,N);
%     for i = 1:length(mikkelsen)
%         for j = 1:length(mikkelsen)
%            H(i,j) = filter(i,j)*fftB(i,j);
%         end
%     end

%Transformerer tilbake
filtrertNy = ifft2(ifftshift(fftB));
%figure, imshow(filtrertNy), title('Filtrert uten normalisering')
[N,M]=size(filtrertNy);
mellom = ones(N,M).*min(min(filtrertNy));
ny = filtrertNy-mellom;
filtrertN = ny./max(max(ny));

%figure, imshow(filtrert), title('Filtrert')
figure, imshow(fftB), title('Filtrert trans')
figure;
subplot(2,2,1),imshow(filtrertNy), title('Filtrert uten normalisering')
subplot(2,2,2),imshow(filtrertN), title('Filtrert med normalisering')
subplot(2,2,3),imshow(imageA), title('Original')
subplot(2,2,4),imshow(filtrert), title('Litt filtrert uten normalisering')

end
% if R<10
%             if R^2 < (i-senter)^2+(j-senter)^2 && (i-senter)^2+(j-senter)^2 <= (R+1)^2
%                 fftB(i,j) = fftB(i,j)*R; %%%DETTE ER BARE ANTAGELSER TIL FILTER
%             end
%             elseif R>10&&R<100
%                 if R^2 < (i-senter)^2+(j-senter)^2 && (i-senter)^2+(j-senter)^2 <= (R+1)^2
%                 fftB(i,j) = fftB(i,j)*R; %%%DETTE ER BARE ANTAGELSER TIL FILTER
%                 end
%             else
%                  if R^2 < (i-senter)^2+(j-senter)^2 && (i-senter)^2+(j-senter)^2 <= (R+1)^2
%                 fftB(i,j) = fftB(i,j)*R; %%%DETTE ER BARE ANTAGELSER TIL FILTER
%                 end
%             end
            
            
            
            
            
            