function [ ] = cluster_plot(cluster, startC, iteration)
    K = length(cluster);
    figure()
    colors = ['r','b','k','m','c','g','y'];
    for i = 1:K
        scatter(cluster{i}(:,1),cluster{i}(:,2),'.','MarkerEdgeColor',colors(i))
        hold on
        scatter(startC(i,1),startC(i,2),'MarkerEdgeColor',colors(i))
        legend(['cluster ',num2str(i)],['center point ',num2str(i)])
    end
    text = {['cluster ',num2str(1)],['center point ',num2str(1)],...
            ['cluster ',num2str(2)],['center point ',num2str(2)],...
            ['cluster ',num2str(3)],['center point ',num2str(3)],...
            ['cluster ',num2str(4)],['center point ',num2str(4)],...
            ['cluster ',num2str(5)],['center point ',num2str(5)],...
            ['cluster ',num2str(6)],['center point ',num2str(6)],...
            ['cluster ',num2str(7)],['center point ',num2str(7)],};
    legend(text,'Location','northwest')
    title(['K-mean iteration: ',num2str(iteration)])
    xlabel('x-axis')
    ylabel('y-axis')
    hold off
    grid on
    grid minor
end

