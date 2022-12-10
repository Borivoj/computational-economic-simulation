function [ Demand, Labor ] = aggregate_demand(households,HouseholdsActionsIndexes, cfg, BondPrice)
    Demand = zeros(1,numel(cfg.gmgrid));
    Labor = zeros(1,numel(cfg.gmgrid));
    for household_indx = 1:cfg.n_households
       [SDemand,SLabor] =demand_function( households(household_indx),HouseholdsActionsIndexes(household_indx,:), BondPrice, cfg);
       Demand = Demand + SDemand;
       Labor = Labor + SLabor;
    end
end

