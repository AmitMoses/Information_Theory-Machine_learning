close all
clear
clc

%% Gaussian Parameters
% Gaussian #1
p1 = 0.7;
mu1 = [ -1  -1 ];
sigma1 = [ 0.8 0 ; 0 0.8];
% Gaussian #2
mu2 = [ 1  1 ];
sigma2 = [ 0.75 -0.2; -0.2 0.6 ];
p2 = 1 - p1;

%% GMM generation 
N = 10000;
gaussian1 = mvnrnd(mu1,sigma1,N);
gaussian2 = mvnrnd(mu2,sigma2,N);
p_temp = rand(1,N);
p_vec = zeros(1,N);
p_vec(p_temp < p1) = 1;
p_vec = repmat(p_vec,2,1).';
gmm = p_vec.*gaussian1 + (1 - p_vec).*gaussian2;

%% EM
K = 2;
% initial value
it_phi = ones(1,K)/K; 
for  k =1:K
    it_sigma(:,:,k) = [1 0 ; 0 1];
end
it_mu = -3 + (3+3)*rand(K,2);

start_with_Kmean_initial = 0;
if start_with_Kmean_initial == 1
    plot_flag = 0;
    [it_mu] = K_mean(gmm,it_mu,K, plot_flag);
end

gauusian_plot(gmm, it_mu,it_sigma,0,1)

%loop
total_error = 10;
iter = 1;
tolerance = 1e-3;
while total_error > tolerance && iter <= 20   
    % EM iteration
    [mu_new,sigma_new,phi_new,log_like(iter)] = EM_itration(gmm,it_mu,it_sigma,it_phi);  
    
    % Error calculate
    error(1) = sum(abs(mu_new - it_mu),'all')/length(mu_new);
    error(2) = sum(abs(sigma_new - it_sigma),'all')/length(sigma_new);
    error(3) = sum(abs(phi_new - it_phi))/length(phi_new);
    total_error = mean(error);
    
    % Text diaplay
    disp(['iteration: ',num2str(iter),', error = ',num2str(total_error)...
        ,' Log-likelihood: ',num2str(log_like(iter))])
    
    % Update parameters
    it_mu = mu_new;
    it_sigma = sigma_new;
    it_phi = phi_new;
    iter = iter + 1; 
    
    % Plot
    plot_flag = 5;
    gauusian_plot(gmm, it_mu,it_sigma,iter-1,plot_flag)  
end
gauusian_plot(gmm, it_mu,it_sigma,iter-1,1)
% log-likelihood plot
figure()
plot(1:(iter-1), log_like)
grid on
grid minor
title('log-liklihood')
xlabel('iteration')
ylabel('log-liklihood')
