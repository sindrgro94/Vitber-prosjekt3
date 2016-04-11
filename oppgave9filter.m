%Oppgave 9 filter
function oppgave9filter(mikkelsen)
close all
fantom = load('phantom256backprojected.mat');
filter = oppgave9MakeFilter(fantom.phantom256);
close all
%Normaliserer matrisen for å få frem et ok bilde 
[N,M]=size(mikkelsen);
mellom = ones(N,M).*min(min(mikkelsen));
ny = mikkelsen-mellom;
imageA = ny./max(max(ny));

figure, imshow(imageA), title('Original')

%Fouriertransformerer bildet
fftA = fft2(imageA);
figure, imshow(abs(fftshift(fftA)),[0 10]), colormap gray
title('FFTA shifted')
%kaller den shiftede transformasjonen for fftB
fftB = fftshift(fftA);

%Setter verdier i sentrum lik null
[N,M]=size(fftA);
%senter = floor((M)/2)+1;

% for R = 0:1:180
%     for i = 1:length(mikkelsen)
%         for j = 1:length(mikkelsen)
%             if R^2 < (i-senter)^2+(j-senter)^2 && (i-senter)^2+(j-senter)^2 <= (R+1)^2
%                 fftB(i,j) = fftB(i,j)*R; %%%DETTE ER BARE ANTAGELSER TIL FILTER
%             end
%         end
%     end
% end


H = zeros(N,N);
    for i = 1:length(mikkelsen)
        for j = 1:length(mikkelsen)
           H(i,j) = filter(i,j)*fftB(i,j);
        end
    end

%Transformerer tilbake
filtrert = ifft2(ifftshift(H));

[N,M]=size(filtrert);
mellom = ones(N,M).*min(min(filtrert));
ny = filtrert-mellom;
filtrert = ny./max(max(ny));

figure, imshow(filtrert), title('Filtrert')
end

            
            
            
            
            
            