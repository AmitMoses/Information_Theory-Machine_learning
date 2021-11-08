function [mu_new,sigma_new,phi_new,log_like] = EM_itration(data,mu,sigma,phi)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
% E - step
    K = length(phi);
    N = length(data);
    P = zeros(K,N);
    for j=1:K
       for i = 1:N
          P(j,i) = N_pdf(data(i,:), mu(j,:), sigma(:,:,j)); 
       end
    end
    w = (phi.'.*P) ./ (sum(phi.'.*P,1));

    % M - step
    phi_new = 1/N * sum(w,2).';
    for j = 1:K
%         mu_new(j,:) = sum(w(j,:).*[data(:,j) data(:,j)].',2) ./ sum(w(j,:),2);
        mu_new(j,:) = sum(w(j,:).*data.',2) ./ sum(w(j,:),2);
    end

    for j = 1:K
        sigma_new(:,:,j) = zeros(2);
        for i = 1:N
            sigma_new(:,:,j) = sigma(:,:,j) + ( w(j,i) .* (data(i,:) - mu(j,:)).'...
                * (data(i,:) - mu(j,:)) ) ./ sum(w(j,:),2);
        end
    end
    
    % Log-likelihood
    log_like = 0;
    for i = 1:N
       for j = 1:K
           log_like = log_like + w(j,i)*log(P(j,i));
       end
    end
    
end

