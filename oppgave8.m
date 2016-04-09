function oppgave8()

for i = 1:11
    if i < 10
        name = sprintf('sinogram0%i.txt',i);
    else 
        name = sprintf('sinogram%i.txt',i);
    end
    
    sinogram = load(name);
    directBackwardsProjection = oppgave7(sinogram);
    
    h = figure;
    imagesc(directBackwardsProjection);
    %imagesc(im1);
    colormap('gray');
    axis square;
    drawnow;
    
     if i < 10
        name = sprintf('sinogram0%i.pdf',i);
    else 
        name = sprintf('sinogram%i.pdf',i);
     end
    
    saveTightFigure(h,name);
    close all;
end
end
        