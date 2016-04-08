function projMatrix = makeProjectionNxN(matrix,sizeN,nTheta)
    projMatrix = zeros(2*sizeN-1,nTheta);
    theta = zeros(1,nTheta);
    Sm = zeros(1,2*sizeN-1);
    a=1;
    for n = 1:nTheta
        theta(n) = (n-1)*pi/nTheta;
    end
    for m = 1:2*sizeN-1
        Sm(m) = -(sizeN-m)*a/sqrt(2);
    end
    %%Projiseringen:
    for angle=1:nTheta
        for m = 1:2*sizeN-1
            %%inni her g?r vi over alle vinkler og s-er.
            sUpperLim= Sm(m) + a/2;
            sLowerLim= Sm(m) - a/2;
            for x = 1:sizeN
                for y = 1:sizeN
                    s = sline( (2*x-sizeN-1)*a/2, (2*y-sizeN-1)*a/2, theta(angle) );
                    if s>=sLowerLim && s<=sUpperLim
                        projMatrix(m,angle)= projMatrix(m,angle)+matrix(x,y);
                    end
                end
            end
        end
    end
    h = figure; imagesc(projMatrix), colormap('gray'), axis square, drawnow;
    %saveTightFigure(h,'oppg5');
end

function S=sline(x,y,theta)
S = x*cos(theta)+y*sin(theta);
end