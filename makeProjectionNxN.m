function projMatrix = makeProjectionNxN(Matrix,sizeN,nTheta)
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
            projMatrix(m,angle)=
        end
    end
end