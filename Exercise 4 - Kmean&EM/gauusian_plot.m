function [ ] = gauusian_plot(data, mu,sigma,iteration,plot_flag)

    if mod(iteration,plot_flag) == 0
        % Mashgrid generation
        x = -4:0.1:4;
        y = -4:0.1:4;
        [X,Y] = meshgrid(x,y);
                
        % Plot
        N = size(mu,1);
        figure()
        scatter(data(:,1),data(:,2),'.')
        hold on
        for i = 1:N
            Z{i} = mvnpdf ( [X( : ) , Y( : ) ] ,mu(i,:), sigma(:,:,i) );
            Z{i} = reshape(Z{i},size(X));
            contour (X,Y,Z{i})
            hold on
        end
        hold off
        grid on
        grid minor
        title(['EM iteretion: ',num2str(iteration)])
        xlabel('x-axis')
        ylabel('y-axis')
    end
    
end

