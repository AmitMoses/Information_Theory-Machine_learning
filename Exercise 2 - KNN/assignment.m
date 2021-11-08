% =========================================
%       Homework on K-Nearest Neighbors
% =========================================
% Course: Introduction to Information Theory
% Lecturer: Haim H. Permuter.
%
% NOTE:
% -----
% Please change the variable ID below to your ID number as a string.
% Please do it now and save this file before doing the assignment
close all
clear ;
clc
ID = '312614324';

%% Loading and plot a sample of the data
% ---------------------------------------
% The MNIST database contains in total of 60000 train images and 10000 test images
% of handwritten digits.
% This database is a benchmark for many classification algorithms, including neural networks.
% For further reading, visit http://yann.lecun.com/exdb/mnist/
%
% You will implement the KNN algorithm to classify two digits from the database: 3 and 5.
% First, we will load the data from .MAT file we have prepared for this assignment: MNIST_3_and_5.mat
load('MNIST_3_and_5.mat')
% The data is divided into 2 pairs:
% (Xtrain, Ytrain) , (Xvalid, Yvalid)
% In addition, you have unlabeled test sample in Xtest.
%
% Each row of a X matrix is a sample (gray-scale picture) of dimension 784 = 28^2,
% and the digit (number) is in the corresponding row of the Y vector.
%
% To plot the digit, see attached function 'plot_sample.m'
sampleNum = 1;
plot_sample(Xvalid(sampleNum,:),Yvalid(sampleNum))


% Build a KNN classifier based on what you've learned in class:
%
% 1. The classifier should be given a train dataset (Xtrain, Ytain),  and a test sample Xtest.
% 2. The classifier should return a class for each row in test sample in a column vector Ytest.
%
% Finally, your results will be saved into a <ID>.txt file, where each row is an element in Ytest.
%
% Note:
% ------
% For you conveniece (and ours), give you classifications in a 1902 x 1 vector named Ytest,
% and set the variable ID at the beginning of this file to your ID.


% < your code here >
%% Train
tic
 K_vec = 1:21;
 disp('Train results:')
 X = Xtrain(1:100,:);
 Y = Ytrain(1:100,:);
 for K_idx = 1:length(K_vec)
    K = K_vec(K_idx);
    pred = K_near(K,Xtrain,Ytrain,X); %  K nearest neighbor
    Train_acc(K_idx) = acc_meas(Y,pred); % Valitation accuracy
    text = [' K = ',num2str(K),' Train acc = ',num2str(Train_acc(K_idx)*100),'%'];
    disp(text)
 end
 toc
 
%% Validation
 disp('Vlidation results:')
 X = Xvalid;
 Y = Yvalid;
 for K_idx = 1:length(K_vec)
    K = K_vec(K_idx);
    pred = K_near(K,Xtrain,Ytrain,X); %  K nearest neighbor
    Val_acc(K_idx) = acc_meas(Y,pred); % Valitation accuracy
    text = [' K = ',num2str(K),' Validation acc = ',num2str(Val_acc(K_idx)*100),'%'];
    disp(text)
 end
 
 toc
 %% Test
K = 17;
text = ['Run Test for: K = ', num2str(K)];
disp(text)
X = Xtest;
Ytest = K_near(K,Xtrain,Ytrain,X);
toc
 
%% save classification results
disp('saving')
csvwrite([ID '.txt'], Ytest)
disp('done')

%saving to correct format
disp('saving')
writematrix(Ytest, [ID '.txt'])
disp('done')

%% Plot
figure()
plot(K_vec, Val_acc*100,'*-')
grid on
grid minor
xlabel('K')
ylabel('Val acc [%]')
ylim([96 100])
xlim([K_vec(1) K_vec(end)])
hold on
plot([K_vec(1) K_vec(end)], [Val_acc(17) Val_acc(17)]*100,'r--')
legend('Val acc','Max acc')
title('Validation accuracy')