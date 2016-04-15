function oppgave8()

for i = 1:11
    tic
    if i < 10
        name = sprintf('sinogram0%i.txt',i);
    else 
        name = sprintf('sinogram%i.txt',i);
    end
    disp(i)
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
    fprintf('\nEstimated time left: %.0f min',timer*(11-i)/60);
end
end
        