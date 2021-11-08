function acc = acc_meas(lable,est)
    % Accuracy measure between lable and est
    
    est_01 = zeros(length(est),1);
    est_01(est == 5) = 1;
    lable_01 = zeros(length(lable),1);
    lable_01(lable == 5) = 1;
    
    acc = 1 - sum(abs( est_01 - lable_01 ))/length(lable);
    
end