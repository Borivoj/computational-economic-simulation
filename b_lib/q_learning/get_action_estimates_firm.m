function [ ActionEstimates ] = get_action_estimates_firm( theta_firm, ind, mu )
    dimu = [size(theta_firm,3)];
    %ActionEstimates = theta_firm(ind(:,1),:)'*mu;
    ActionEstimates = zeros(dimu(1),1);
    for ActionIndex = 1:dimu(1)
        act=theta_firm(ind(:,1), ind(:,2),ActionIndex);
        check_one = [act(1,1)*mu(1,1)+act(2,1)*mu(2,1) act(1,2)*mu(1,1)+act(2,2)*mu(2,1)]*mu(:,2);
        check_two = [act*mu(:,2)]'*mu(:,1);
        if check_one +0.0001 < check_two || check_one -0.0001 > check_two
            error('This should never happen');
        end
        ActionEstimates(ActionIndex) = check_two;
    end
end

