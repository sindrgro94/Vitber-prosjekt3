%For � f� en sirkel i sentrum
%Oppgave 9
%denne skal ta inn en tilbakeprojeksjon og legge til et h�ypassfilter
function oppgave9hoypass(tilbakeProjeksjon)

close all
%Normaliserer matrisen for � f� frem et ok bilde 
[N,M]=size(tilbakeProjeksjon);
mellom = ones(N,M).*min(min(tilbakeProjeksjon));
ny = tilbakeProjeksjon-mellom;
imageA = ny./max(max(ny));


%Fouriertransformerer bildet
fftA = fft2(double(imageA));
fftB = fftshift(fftA);
fftC = fftB;


%Setter verdier i sentrum lik null
[N,M]=size(fftA);
R = 100;
senter = floor((M)/2)+1;

for i = 1:length(tilbakeProjeksjon)
    for j = 1:length(tilbakeProjeksjon)
        if (i-senter)^2+(j-senter)^2 > R^2
            fftB(i,j)=fftB(i,j)*0;
        end
    end
end      

%Image C er fftB transformert tilbake og skal derfor etter normalisering
%Ligne p� orginalbildet
imageC = ifft2(ifftshift(fftB));

%Normaliserer imageC
[N,M]=size(imageC);
mellom1 = ones(N,M).*min(min(imageC));
ny1 = imageC-mellom1;
NormImageC = ny1./max(max(ny1));


%Plotter originalbilder mot filtrerte bilder
h = figure;
subplot(2,2,2),imagesc((NormImageC),[0,1]),axis square, colormap gray, title('H�ypassfilter')
subplot(2,2,1),imagesc(imageA,[0,1]), axis square, colormap gray,title('Original')
subplot(2,2,4),imagesc(abs(fftB),[0 1]),axis square, colormap gray, title('Fourier med h�ypassfilter') 
subplot(2,2,3),imagesc(abs(fftC),[0 1]),axis square, colormap gray, title('Fourier uten h�ypassfilter')
saveTightFigurenr2(h,'H�ypass');

end

