function x =  create16x16filled4x4center(N)
    x = zeros(N,N);
    L = N/2+1:N/2+2;
    for i = L
        for j = L
            x(i,j) = 1;
        end
    end
end
