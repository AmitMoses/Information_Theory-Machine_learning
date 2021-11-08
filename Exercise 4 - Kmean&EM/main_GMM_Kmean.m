close all
clear
clc
%% Parameters
% Gaussian #1
p1 = 0.7;
mu1 = [ -1  -1 ];
sigma1 = [ 0.8 0 ; 0 0.8];

% Gaussian #2
mu2 = [ 1  1 ];
sigma2 = [ 0.75 -0.2; -0.2 0.6 ];
p2 = 1 - p1;

%% GMM generation 
N = 1000;
gaussian1 = mvnrnd(mu1,sigma1,N);
gaussian2 = mvnrnd(mu2,sigma2,N);
p_temp = rand(1,N);
p_vec = zeros(1,N);
p_vec(p_temp < p1) = 1;
p_vec = repmat(p_vec,2,1).';
gmm = p_vec.*gaussian1 + (1 - p_vec).*gaussian2;

%% K-meam
% (a) plot
gmm50 = gmm(1:50,:);
% gmm50 = gmm;
figure()
scatter(gmm50(:,1),gmm50(:,2),'.')
grid on
grid minor
xlabel('x-axis')
ylabel('y-axis')
title('50 samples from the distribution')

% (b) K-mean
K = 3;  % for plot, maximum is 7
plot_flag = 1;

idxC = randi(46,[1,K]);
startC = gmm50(idxC,:);
[startC] = K_mean(gmm50, startC, K, plot_flag);




