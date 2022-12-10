function [rand_indx] = random_actions(cfg, use_firm_u_subset ,firms,households, Wage, Next, Price_G)
    rand_indx.FirmsActionsIndexes = zeros(cfg.n_firms,cfg.DIMS_f.q);
    rand_indx.HouseholdsActionsIndexes = zeros(cfg.n_households,cfg.DIMS_h.q);
    
    for firm_index=1:cfg.n_firms
        if rand <= cfg.eps
    
            if use_firm_u_subset
                if Next
                    avail_actions = sum((cfg.ugrids_f{1}.*cfg.maxLabor)*Wage<=firms(firm_index).NextBudget);
                else
                    avail_actions = sum((cfg.ugrids_f{1}.*cfg.maxLabor)*Wage<=firms(firm_index).Budget);
                end
    
                rand_indx.FirmsActionsIndexes(firm_index)=randi(avail_actions);
            else
                rand_indx.FirmsActionsIndexes(firm_index)=randi(cfg.DIMS_f.dimu);
            end
        end
    end
    
    for household_index=1:cfg.n_households
        random_number = rand;
        if random_number <= cfg.eps
            
            rand_indx.HouseholdsActionsIndexes(household_index,1)=randi(cfg.DIMS_h.dimu(1));
        end
        random_number = rand;
        if random_number <= cfg.eps_w
            rand_indx.HouseholdsActionsIndexes(household_index,2)=randi(cfg.DIMS_h.dimu(2));
        end
    end
end