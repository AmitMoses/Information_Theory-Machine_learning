function [startC] = K_mean(gmm50,startC,K,plot_flag)

newC = zeros(size(startC));
oldC = startC;
iter = 1;
while sum(abs(newC - oldC),2) > 0
    % Calculate clusters
    [dist_flag] = K_mean_itration(gmm50, startC);
    % Create clusters
    for i = 1:K
        cluster{i} = gmm50((dist_flag==i),:);
         newC(i,:) = mean(cluster{i});
    end
    % Plot
    if plot_flag == 1
        cluster_plot(cluster,startC,iter)
    end
    % Update
    oldC = startC;
    startC = newC;
    iter = iter + 1;
end

end

