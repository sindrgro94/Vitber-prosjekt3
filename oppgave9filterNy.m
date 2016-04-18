%Oppgave 9 filter
function oppgave9filterNy(tilbakeProjeksjon)
%close all

%Normaliserer matrisen for å få frem et ok bilde 
[N,M]=size(tilbakeProjeksjon);
mellom = ones(N,M).*min(min(tilbakeProjeksjon));
ny = tilbakeProjeksjon-mellom;
imageA = ny./max(max(ny));


%Fouriertransformerer bildet
fftA = fft2(imageA);
%kaller den shiftede transformasjonen for fftB
fftB = fftshift(fftA);

%Setter verdier i sentrum lik null
[N,M]=size(fftA);
senter = floor((M)/2)+1;


k = 1;
    for i = 1:length(tilbakeProjeksjon)
        for j = 1:length(tilbakeProjeksjon)
            fftB(i,j) = fftB(i,j)*k*(sqrt((i-senter)^2+(j-senter)^2));
        end
    end


%Transformerer tilbake
filtrertNy = ifft2(ifftshift(fftB*2));

%Illustrerer resultatet
h = figure;
subplot(1,2,2),imagesc(real(filtrertNy),[-2,1]),axis square, colormap gray, title('Filtrert lineært')
subplot(1,2,1),imagesc(imageA), axis square, colormap gray,title('Original')
% figure;
% subplot(1,2,1),imagesc(real(fftshift(fftA))),axis square, colormap gray, title('Original Fourier')
% subplot(1,2,2),imagesc(real(fftB)),axis square, colormap gray, title('Filtrert Fourier')
saveTightFigurenr2(h,'Mikkelsen')
end
            