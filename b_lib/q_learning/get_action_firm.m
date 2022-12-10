function [SelectedActionEstimate, SelectedActionIndex] = get_action_firm( State, theta_firm, xgrid, dimx, p, u_subset )
    [ind, mu] = indm(State, xgrid, dimx, p);
    ActionEstimates = get_action_estimates_firm(theta_firm, ind, mu);
    
    if isempty(u_subset)
        [SelectedActionEstimate, SelectedActionIndex] = max(ActionEstimates);
    else 
        [SelectedActionEstimate, SelectedActionIndex_subset] = max(ActionEstimates(u_subset));
        SelectedActionIndex = u_subset(SelectedActionIndex_subset);
    end
end

