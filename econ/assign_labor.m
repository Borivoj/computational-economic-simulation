function [ HouseholdFirm ] = assign_labor(HouseholdsActionsIndexes, FirmsActionIndexes ,cfg)
    LaborDemanded = floor(cfg.ugrids_f{1}(FirmsActionIndexes)*cfg.maxLabor);
    LaborSupplied = cfg.ugrids_h{2}(HouseholdsActionsIndexes(:,2));

    PositionsRemaining = LaborDemanded;
    HouseholdFirm=zeros(cfg.n_households,1);
    for household_indx = 1:cfg.n_households
       if sum(PositionsRemaining)>=1 && LaborSupplied(household_indx)>0 
          [val, firm_indx] = find(PositionsRemaining>=1);
          try
            firm_indx = firm_indx(randi(numel(firm_indx)));
          catch
              disp('xas');
          end
          PositionsRemaining(firm_indx) = PositionsRemaining(firm_indx) - 1;
          HouseholdFirm(household_indx)=firm_indx;
       end
    end

end

