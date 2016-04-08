function projection3x3()
    im1 = [0 0 0; 0 1 0; 0 0 0];
    %figure, imagesc(im1), colormap('gray'), axis square, drawnow; %viser
    %den opprinnelige figuren.
    p1 = sum(im1,2); %radprojeksjoner
    p2 = sum(im1,1); %kolonneprojeksjoner
    projIm1 = zeros(3); 
    for i=1:3
        %Er ikke generelt her. deler p? 3 siden det skal fordeles p? 3
        %koordinater. Deler s? p? to siden vi g?r over de samme punktene to
        %ganger.
        projIm1(:,i) = projIm1(:,i)+ p1/6;
        projIm1(i,:) = projIm1(i,:)+ p2/6;
    end
    h = figure, imagesc(projIm1), colormap('gray'), axis square, drawnow;
    %saveTightFigure(h,'oppg4');
end