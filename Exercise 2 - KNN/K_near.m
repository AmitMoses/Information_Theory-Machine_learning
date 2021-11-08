function pred = K_near(K,Xtrain,Ytrain,X)
pred = zeros(size(X,1),1);
     for i = 1:size(X,1)
         
         % find K nearest neighbor
         digit = X(i,:);
         digit_repmat = repmat(digit,size(Xtrain,1),1);
%          distance = vecnorm(dig_repmat - Xtrain,2,2);
         distance = sqrt(sum((digit_repmat - Xtrain).^2,2));
         [~,indx] = mink(distance,K);
         K_near = Ytrain(indx);
         
         % Decision - 
         % avarage over K nearest neighbor will be close to the majority
         % of the neighbors, 3 or 5. So the decision critiria is:
         % less or more then (5+3)/2 
         if mean(K_near) < (5+3)/2
            pred(i) = 3;
         elseif mean(K_near) >= (5+3)/2
             pred(i) = 5;
         end
     end
end