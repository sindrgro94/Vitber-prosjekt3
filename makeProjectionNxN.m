function projMatrix = makeProjectionNxN(matrix,sizeN,nTheta)
    projMatrix = zeros(sizeN-1,nTheta);
    theta = zeros(1,nTheta);
    Sm = zeros(1,sizeN-1);
    a=1;
   % (xi,yj) = ((2i ? N ? 1)/2,(2j ? N ? 1)/2)a
    for n = 1:nTheta
        theta(n) = (n-1)*pi/nTheta;
    end
    for m = 1:sizeN-1
        Sm(m) = -(-sizeN-m)*a/sqrt(2);
    end
    for angle=1:nTheta
        for m = 1:sizeN-1
            %%inni her g?r vi over alle vinkler og s-er.
            sUpperLim= sm(m) + a/2;
            sLowerLim= sm(m) - a/2;
            for x = 1:sizeN
                for y = 1:sizeN
                    s = sline((2*x-sizeN-1)/2,(2*y-sizeN-1)/2,theta(angle));
                    if s>sLowerLim && s<sUpperLim
                        projMatrix(m,angle)= projMatrix(m,angle)+matrix(x,y);
                    end
                end
            end
        end
    end
end

function S=sline(x,y,theta)
S = x*cos(theta)+y*sin(theta);
end