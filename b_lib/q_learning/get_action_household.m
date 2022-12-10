function [SelectedActionEstimate, SelectedActionIndex] = get_action_household( State, theta_household, xgrid, dimx, p )
    [ind mu] = indm(State, xgrid, dimx, p);
    ActionEstimates = get_action_estimates_household(theta_household, ind, mu);
    
    maximum = max(max(ActionEstimates));
    [x,y]=find(ActionEstimates==maximum);
    SelectedActionEstimate = ActionEstimates(x(1),y(1));
    SelectedActionIndex = [x(1) y(1)];
end

