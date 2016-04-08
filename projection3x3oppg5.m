function projection3x3oppg5()
    im1 = [0 0 0; 0 1 0; 0 0 0];
    pRows = sum(im1,2); %radprojeksjoner
    pCol = sum(im1,1); %kolonneprojeksjoner
    pPi4 = im1(1,1)+im1(2,2)+im1(3,3);
    p3Pi4 = im1(1,3)+im1(2,2)+im1(3,1);
    projIm1 = zeros(3);
    %%Deler ut Verdiene:
    projIm1(1,1) = (pRows(1)+pCol(1)+pPi4)/(3);
    projIm1(1,2) = (pRows(1)+pCol(2))/(3);
    projIm1(1,3) = (pRows(1)+pCol(3)+p3Pi4)/(3);
    projIm1(2,1) = (pRows(2)+pCol(1))/(3);
    projIm1(2,2) = (pRows(2)+pCol(2)+pPi4+p3Pi4)/(3);
    projIm1(2,3) = (pRows(2)+pCol(3))/(3);
    projIm1(3,1) = (pRows(3)+pCol(1)+p3Pi4)/(3);
    projIm1(3,2) = (pRows(3)+pCol(2))/(3);
    projIm1(3,3) = (pRows(3)+pCol(3)+pPi4)/(3);
    %plot av figur.
    disp(projIm1);
    totalSum = sum(sum(projIm1));
    projIm1 = projIm1/totalSum;
    disp(sum(projIm1));
    disp(sum(sum(projIm1)));
    h = figure; imagesc(projIm1), colormap('gray'), axis square, drawnow;
    %saveTightFigure(h,'oppg5');
end