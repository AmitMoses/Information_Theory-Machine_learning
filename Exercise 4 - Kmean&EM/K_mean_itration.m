function [dist_flag] = K_mean_itration(data,startC)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    K = size(startC,1);
    startC_reshape = reshape(startC.',1,[],K);
    data_rapmat = repmat(data,[1,1,K]);
    dist = sum((startC_reshape - data_rapmat).^2,2);
    dist_reshape = reshape(dist,[],K);
    a = min(dist_reshape,[],2);
    [row,col] = find(dist_reshape - a == 0);
    [~,I] = sort(row);
    dist_flag = col(I);

end

