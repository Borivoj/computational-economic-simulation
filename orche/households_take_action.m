function [ HouseholdsActionsIndexes ] = households_take_action( cfg,households,State )
    HouseholdsActionsIndexes=zeros(cfg.n_households, cfg.DIMS_h.q);
    for household_index = 1:cfg.n_households
       HouseholdsActionsIndexes(household_index,:)=households(household_index).action(State,cfg, 0);
    end
end

