function [ ActionEstimates ] = get_action_estimates_household( theta_household, ind, mu )
    dimu = [size(theta_household,3) size(theta_household,4)];
    ActionEstimates = zeros(dimu(1),dimu(2));
    for ActionIndex = 1:dimu(1)
        for WorksIndex = 1:dimu(2)
            act=theta_household(ind(:,1), ind(:,2),ActionIndex, WorksIndex);
            check_one = [act(1,1)*mu(1,1)+act(2,1)*mu(2,1) act(1,2)*mu(1,1)+act(2,2)*mu(2,1)]*mu(:,2);
            check_two = [act*mu(:,2)]'*mu(:,1);
            if check_one +0.0001 < check_two || check_one -0.0001 > check_two 
                error('This should never happen');
            end
            ActionEstimates(ActionIndex,WorksIndex) = check_two;
        end
    end
end

