function oppgave8()

%For å kjøre denne, MÅ "current folder" (kommando "pwd" i MATLAB)
%være "...\Vitber-prosjekt3\", samt at alle undermapper i denne mappen
%er en del av "current path".
%får du feil ved "saveTightFigurenr2.m", er trolig dette feilen.
try 
    cd('Vitber-prosjekt3-master');
catch
    %%fortsett kjøring, du er trolig allerede inne i 
    %mappa som du skal.
end


for i = 1:11
    tic
    if i < 10
        name = sprintf('sinogram0%i.txt',i);
    else 
        name = sprintf('sinogram%i.txt',i);
    end
    fprintf('Jobber med bilde %.0f/11\n',i);
    sinogram = load(name);
    directBackwardsProjection = oppgave7(sinogram);
    
    h = figure;
    imagesc(directBackwardsProjection);
    %imagesc(im1);
    colormap('gray');
    axis square;
    drawnow;
    
     if i < 10
        name = sprintf('directBackProjection0%i.pdf',i);
    else 
        name = sprintf('directBackProjection%i.pdf',i);
     end
    
    saveTightFigure(h,['Tilbakeprojiseringer\' name]);
    close all;
    timer = toc;
    fprintf('\nEstimated time left: %.0f min og %0.f sek\n',timer*(11-i)/60,mod(timer*(11-i),60));
end
end
        