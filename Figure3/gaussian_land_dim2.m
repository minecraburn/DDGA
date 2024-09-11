function [P,Xlim,Ylim,Plim,l,a1,a2] = gaussian_land_dim2(V, Sigma, circle, phi, u1, u2, v1, v2, num)
% Gaussian approximation function, V: a n*2 matrix with 0 and 1.
% phi is the weighted summation.
% circle is the data of limit cycle

    gauss = @(A,x,y) A(1,1) .* x.^2 + A(2,2) .* y.^2 + 2 * A(1,2) .* x .*y;

    m = length(phi);
    sigma0_pca = zeros(2,2,m);
    mu_pca = zeros(m,2);
    for i=1:m
       mu_pca(i,:) = V'*circle(i,:)'; % low-dimensional trajectory
       sigma0_pca(:,:,i) = V'*Sigma(:,:,i)*V; % low-dimensional covariance
    end

    [a1,a2]=meshgrid(linspace(u1,v1,num),linspace(u2,v2,num)); % mesh
    
    P=zeros(num); % landscape
    
    Xlim = circle * V(:,1); % information on the limit cycle
    Ylim = circle * V(:,2);
    Plim = zeros(m,1);
    
    for k=1:m
        sig=sigma0_pca(:,:,k);

        inv_cov = inv(sig);

        Cons1 = 1 / sqrt((2*pi) * det( sig ));
        Cons2 = exp(-1/2);

        Z = Cons1 * Cons2 .^ gauss(inv_cov, a1-mu_pca(k,1), a2-mu_pca(k,2));
        
        P = P + Z * phi(k); % weighted summation of Gaussian distributions
        
        Zlim = Cons1 * Cons2 .^ gauss(inv_cov, Xlim-mu_pca(k,1), Ylim-mu_pca(k,2));
        
        Plim = Plim + Zlim * phi(k);
    end
    
    Plim = Plim / sum(P,'all');
    P = P / sum(P,'all');   
    
    % P = -log10(max(P,1e-6)); % probability-->landscape
    P = -log(P);

    % Plim = -log10(max(Plim,1e-6)); % probability-->landscape
    Plim = -log(Plim);

    [~,l] = findpeaks(Plim); % checkpoint
    
end